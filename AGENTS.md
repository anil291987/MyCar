# AGENTS.md

Instructions for OpenAI Codex (and other agentic coding tools) working in this repository.

## This repo

Flutter companion-app clone for a Mercedes-Benz vehicle (EQS 580), using
`go_router` for navigation and `provider` for state. No backend — all
vehicle data is mocked/in-memory.

## Commands

- Install dependencies: `flutter pub get`
- Lint / static analysis: `flutter analyze --no-pub`
- Run all tests: `flutter test`
- Run a single test file: `flutter test test/widget_test.dart`
- Run the app in Chrome (fastest inner loop for UI iteration): `flutter run -d chrome --web-port=8765`
- Run on a specific device: `flutter run -d <device-id>` (see `flutter devices`)

There is no CI config and no golden/integration test setup beyond the single
widget smoke test in `test/widget_test.dart`.

## Architecture

- `lib/main.dart` — entry point. Wraps the app in an app-wide
  `ChangeNotifierProvider<VehicleState>`.
- `lib/app.dart` — root `MaterialApp.router`. Rebuilds on `ThemeController`
  changes via `AnimatedBuilder`, keyed by `ValueKey(ThemeController.instance.mode)`
  so a theme switch forces a full remount.
- `lib/core/router/app_router.dart` — single `GoRouter` static singleton.
  `StatefulShellRoute.indexedStack` (`MainShell` + bottom nav) with branches
  `/home`, `/status`, `/remote`, `/navigation`, `/services`, plus standalone
  `/splash` and `/login`.
- `lib/data/vehicle_state.dart` — the only app state
  (`VehicleState extends ChangeNotifier`), read via `context.watch`/`context.read`.
- `lib/features/<feature>/` — one folder per bottom-nav destination
  (`home`, `vehicle_status`, `remote_control`, `navigation`, `services`) plus
  `auth`, `splash`, `shell`. Each screen is one large `StatelessWidget` file
  with private (`_Foo`) helper widgets for its sections.
- `lib/core/widgets/` — shared building blocks (`MBCard`, `MBSectionHeader`,
  `MBDivider`, `MBStatusChip`, `MBButton`, `MBControlButton`).

## Theming — read this before touching colors

`lib/core/theme/colors.dart` (`AppColors`) and `lib/core/theme/typography.dart`
(`AppTypography`) are **not** driven by `Theme.of(context)` /
`InheritedWidget`. They're plain static getters that read
`ThemeController.instance.isDark` directly. Most `AppColors` members
(`background`, `surface`, `textPrimary`, `divider`, etc.) are dynamic
getters; a handful (`accentBlue`, `accentGold`, `success`, `warning`,
`error`) are true `static const` brand colors that don't change with theme.

**Never mark a widget `const` at its call site if its `build()` (directly or
via a helper it composes, e.g. `AppTypography.*`) reads one of the dynamic
`AppColors` getters.** Because these getters aren't wired through Flutter's
`InheritedWidget` dependency system, a `const` widget instance can be reused
across a theme change without rebuilding, silently freezing it with stale
(wrong-theme) colors. This has caused real bugs (`MBSectionHeader`,
`MBDivider`, the Services "MY SERVICES" card grid, the home header logo were
all called with `const` and stayed dark after switching to light mode).
`prefer_const_constructors` and `prefer_const_literals_to_create_immutables`
are disabled project-wide in `analysis_options.yaml` for exactly this
reason — don't re-enable them without auditing every call site.

The `_VehicleHeroCard` in `home_screen.dart` overlays text on a photo; its
gradient scrim and text intentionally use fixed `Colors.black`/`Colors.white`
rather than `AppColors`, since they must stay legible against the photo
regardless of theme. The dark map styling in `navigation_screen.dart` is the
same kind of intentional, theme-invariant exception. Don't "fix" either of
these to use `AppColors`.
