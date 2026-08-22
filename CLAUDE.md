# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

- Install dependencies: `flutter pub get`
- Lint / static analysis: `flutter analyze --no-pub`
- Run all tests: `flutter test`
- Run a single test file: `flutter test test/widget_test.dart`
- Regenerate localizations after editing `lib/l10n/app_en.arb` / `app_de.arb`: `flutter gen-l10n`
- Run the app in Chrome (fastest inner loop for UI iteration): `flutter run -d chrome --web-port=8765`
- List available devices/simulators: `flutter devices`
- Run on a specific device: `flutter run -d <device-id>`

There is no CI config, no custom build/lint scripts, and no golden/integration test setup beyond the single widget smoke test in `test/widget_test.dart`.

## Architecture

Flutter companion-app clone for a Mercedes-Benz vehicle (EQS 580), using `go_router` for navigation and `flutter_bloc` (Cubit) for state management, structured as clean architecture: **domain → data → presentation**.

```
lib/
  domain/
    entities/         Vehicle, AppBrand — plain Dart, no Flutter imports
    repositories/      abstract interfaces (VehicleRepository, ThemeRepository, LocaleRepository, BrandRepository)
    usecases/           one class per mutation (ToggleLock, SetTargetTemp, SetThemeMode, SetBrand, ...)
  data/
    repositories/       in-memory ChangeNotifier implementations of the domain interfaces (no backend, mocked data)
  presentation/
    cubits/             VehicleCubit, ThemeCubit, LocaleCubit, BrandCubit — thin: each public method calls one use case
    theme/               colors.dart (AppColors), typography.dart (AppTypography), app_theme.dart
    router/              app_router.dart
    widgets/             shared building blocks (MBCard, MBGlassSurface, MBSectionHeader, MBDivider, MBStatusChip, MBButton, MBControlButton, AppIconMark)
    features/            one folder per bottom-nav destination (home, vehicle_status, remote_control, navigation, services) plus auth, splash, shell
  core/
    di/app_locator.dart  tiny manual service locator (no get_it) — see below
  main.dart, app.dart
```

- **`lib/main.dart`** — entry point. Calls `AppLocator.setup()`, then wraps the app in `MultiBlocProvider` supplying `VehicleCubit`, `ThemeCubit`, `LocaleCubit`, `BrandCubit` (each constructed from its `AppLocator.*Repository`).
- **`lib/app.dart`** — root `MaterialApp.router`. Watches `ThemeCubit`/`LocaleCubit`/`BrandCubit` via `context.watch<T>().state`, keyed by `ValueKey((themeMode, locale, brand))` so any of the three forces a full remount.
- **`lib/core/di/app_locator.dart`** (`AppLocator`) — a small static holder instantiated once in `main.dart`. Widgets with a `BuildContext` should use the Cubits via `context.watch`/`context.read`; `AppLocator` exists only for the handful of call sites that read theme/brand state *without* a `BuildContext` — `AppColors`, `AppTypography`, `MBCard`, `MBGlassSurface`, `main_shell.dart`'s nav bar.
- **Cubits are thin**: `state` is usually the domain value itself (`VehicleCubit extends Cubit<Vehicle>`, `ThemeCubit extends Cubit<ThemeMode>`, `LocaleCubit extends Cubit<Locale?>`, `BrandCubit extends Cubit<AppBrand>`); each public method forwards to exactly one use case. **`Vehicle` is immutable** (`copyWith`) specifically because Cubit/Bloc skip `emit` when the new state is `==` the current one — for a plain class that's reference identity, so the repository must produce a *new* `Vehicle` instance on every mutation, not mutate fields in place.
- **`lib/features/<feature>/`** — one folder per bottom-nav destination (`home`, `vehicle_status`, `remote_control`, `navigation`, `services`) plus `auth`, `splash`, `shell`. Each screen is a single large `StatelessWidget` file with private (`_Foo`) helper widgets for its sections, rather than being split into many small files.
- **`lib/presentation/widgets/`** — shared building blocks (`MBCard`, `MBGlassSurface`, `MBSectionHeader`, `MBDivider`, `MBStatusChip`, `MBButton`, `MBControlButton`, `AppIconMark`) used across all feature screens.

### Theming — read this before touching colors

- **`lib/presentation/theme/colors.dart`** (`AppColors`) and **`typography.dart`** (`AppTypography`) are **not** driven by `Theme.of(context)` / `InheritedWidget`. They're plain static getters that read `AppLocator.themeRepository.isDark` and `AppLocator.brandRepository.brand` directly and return different colors/fonts per theme mode and per sub-brand. Most `AppColors` members (`background`, `surface`, `textPrimary`, `divider`, `accentBlue`, `accentBlueDim`, etc.) are dynamic getters; a handful (`accentGold`, `success`, `warning`, `error`) are true `static const` colors that don't change with theme or brand.
- **Consequence: never mark a widget `const` at its call site if its `build()` (directly or via a helper it composes, e.g. `AppTypography.*`) reads one of the dynamic `AppColors` getters.** Because these getters aren't wired through Flutter's `InheritedWidget` dependency system, a `const` widget instance can be reused across a theme/brand change without rebuilding, silently freezing it with stale colors. This bit `MBSectionHeader`, `MBDivider`, the Services "MY SERVICES" card grid, and later `accentBlue`-using `Icon`/`BorderSide` literals when `accentBlue` became brand-dependent — in each case the fix was removing `const` from the call site. Because of this, `prefer_const_constructors` and `prefer_const_literals_to_create_immutables` are disabled project-wide in `analysis_options.yaml`; don't re-enable them without auditing every call site.
- **Three selectable sub-brands** (`AppBrand`: `mercedes`, `amg`, `maybach`), picked in Services → Appearance → Brand. `accentBlue`/`accentBlueDim` and the `AppTypography` font family (Titillium Web / Oswald / Playfair Display) all switch on `AppLocator.brandRepository.brand` — this means any widget already using `AppColors.accentBlue` for CTAs/highlights re-skins automatically with no per-widget changes.
- The `_VehicleHeroCard` in `home_screen.dart` and the dark map styling in `navigation_screen.dart` intentionally use fixed `Colors.black`/`Colors.white` or theme-invariant colors rather than `AppColors`, since they need to stay legible/consistent regardless of theme.
- When testing a theme change, a live `flutter run -d chrome` session sometimes doesn't reflect an edit until the process is restarted (hot reload/restart via stdin isn't available when the process is launched detached/backgrounded) — kill and relaunch `flutter run` to verify a fix rather than trusting an already-running session.

### Modal bottom sheets

`MainShell`'s `Scaffold` uses `extendBody: true`, so its floating glass nav bar overlays on top of body content — including modal bottom sheets pushed on the current branch's nested `Navigator` (from `StatefulShellRoute`). Any `showModalBottomSheet` whose content could sit near the bottom of the screen must pass `useRootNavigator: true`, or the nav bar will visually sit on top of (and intercept taps on) the sheet's lower content. See the language picker in `services_screen.dart` for the working pattern.
