# MyCar

[![CI](https://github.com/anil291987/MyCar/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/anil291987/MyCar/actions/workflows/ci.yml)

A Flutter car companion app for managing a vehicle — lock/unlock, climate control, remote start, vehicle status, navigation, and service booking — built with clean architecture (domain → data → presentation).

## Features

- **Home** — vehicle overview, quick actions, last journey
- **Vehicle Status** — battery, lock state, climate, tire pressure
- **Remote Control** — lock/unlock, climate, sunroof, remote start
- **Navigation** — map view with saved destinations
- **Services** — appointment booking, dealer finder, digital store, settings (theme, locale, brand)
- Light/dark theme and multiple selectable visual brands
- English and German localization

## Getting started

```bash
flutter pub get
flutter run -d chrome --web-port=8765   # fastest inner loop for UI iteration
```

## Commands

| Task | Command |
| --- | --- |
| Install dependencies | `flutter pub get` |
| Static analysis | `flutter analyze --no-pub` |
| Run all tests | `flutter test` |
| Run a single test file | `flutter test test/widget_test.dart` |
| Regenerate localizations | `flutter gen-l10n` |
| List available devices | `flutter devices` |
| Run on a specific device | `flutter run -d <device-id>` |

## Architecture

```
lib/
  domain/          entities, repository interfaces, use cases (one class per mutation)
  data/             in-memory repository implementations (no backend, mocked data)
  presentation/     cubits, theme, router, shared widgets, feature screens
  core/di/          tiny manual service locator
```

Each bottom-nav destination lives in its own folder under `lib/presentation/features/`. State is managed with `flutter_bloc` Cubits, and navigation uses `go_router`.

## CI

GitHub Actions runs `flutter analyze` and `flutter test` on every push and pull request to `main` and `develop` (see `.github/workflows/ci.yml`).

## Branching

- `main` — release-ready
- `develop` — integration branch
- `feature/*`, `release/*`, `hotfix/*` — cut from and merged back via PR
