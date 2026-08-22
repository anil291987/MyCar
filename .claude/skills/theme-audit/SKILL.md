---
name: theme-audit
description: Walk every screen of this app in both Light and Dark mode looking for text/background contrast bugs. Use after any change to lib/core/theme/, lib/core/widgets/, or a feature screen's styling, or whenever asked to check for theme/contrast issues.
---

# Theme contrast audit

This app has a real architectural landmine (see `CLAUDE.md`'s "Theming"
section): `AppColors`/`AppTypography` read a live `ThemeController` getter
instead of `Theme.of(context)`, so any custom widget instantiated with
`const` at its call site can freeze at the wrong theme's colors after a
Light/Dark switch, without throwing or otherwise being obvious from the code.
This has caused multiple real bugs (the "Mercedes-Benz" header logo, the
Services "MY SERVICES" card grid, `MBSectionHeader`, `MBDivider`).

## How to audit

1. Launch the app per the `flutter-run` skill.
2. Go to Services → scroll to "APPEARANCE" → switch to Light.
3. Visit every route and screenshot each, looking specifically for:
   - Text that's the same or a similar color to its background (not just
     "hard to read" — literally invisible is the failure mode this bug
     produces).
   - Cards/containers that stayed the dark-mode surface color while
     everything else around them went light (the tell-tale sign of a frozen
     `const` widget).
   - Routes: `/home`, `/status`, `/remote`, `/navigation`, `/services`.
4. Repeat switching back to Dark and to System, since a widget frozen from
   an *earlier* session state can look fine in whichever mode it happened to
   last actually build in and only break on the *next* switch — toggle
   Light → Dark → Light at least once on any screen you're checking, not
   just a single switch.
5. Two screens have **intentional** fixed (non-theme) colors — don't flag
   these: the vehicle hero photo overlay in `home_screen.dart`
   (`_VehicleHeroCard`, white text over a dark scrim so it reads over the
   photo in any theme) and the navigation map styling in
   `navigation_screen.dart` (deliberately always dark, like a night map).

## If you find a frozen widget

Grep for how it's called: a bare `const Widget(...)` call site, or a
`children: const [...]` list literal containing it (which implicitly
const-ifies every element). Remove the `const`. Do not "fix" it by adding
`const` to satisfy `flutter analyze` — `prefer_const_constructors` and
`prefer_const_literals_to_create_immutables` are disabled project-wide in
`analysis_options.yaml` specifically because that lint's suggestions are
frequently unsafe here (a widget can be const-eligible by Dart's rules while
still reading theme-dependent colors internally via `AppTypography`).

Verify the fix using the `flutter-run` skill's relaunch step — edits to a
widget's `const`-ness at a call site require a real rebuild to observe, and a
stale hot-reload session can make a fix look like it didn't work (or make a
bug look like it isn't there).
