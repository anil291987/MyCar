---
name: glassmorphism
description: Re-skin this app's design system into glassmorphism — frosted, translucent panels with backdrop blur floating over a colorful background. Use when asked for a "glassmorphism", "glass", "frosted glass", or "liquid glass" redesign, or to bring back the app's original glass look.
---

# Glassmorphism redesign

Frosted, translucent surfaces that blur whatever's behind them, with a
bright specular edge along the top border and a soft ambient shadow lifting
the panel off the page. Depth comes from **layering and blur**, not from
color contrast — which means, unlike the app's other design modes, the
*background* has to carry real color/imagery for the glass to read as glass.
A frosted panel over a flat single-color background just looks like a
slightly-lighter flat panel.

This app already had a "Liquid Glass" implementation once (see the note in
`CLAUDE.md`'s theming section and `mb_glass.dart`'s docstring history) —
this skill is that same recipe, formalized so it's reproducible on demand
rather than something to reconstruct from memory each time.

## Files to touch

### `lib/presentation/theme/colors.dart`
Glass only reads as glass against a background with some visual interest.
Give `background` real hue and a touch of gradient-friendly contrast instead
of a flat matte tone — e.g. a deep indigo-to-navy in dark mode, a soft
sky-to-lavender in light mode. If `AppColors.background` must stay a single
flat `Color` (it's a getter, not a widget), apply the actual gradient in
`app.dart` or per-`Scaffold` via a `Container` with `BoxDecoration.gradient`
behind the body, and keep `AppColors.background` as the gradient's dominant
stop so anything reading it as a plain color still looks reasonable.

Keep `surface`/`surfaceRaised`/`surfaceHighlight` — glass panels tint these
with alpha rather than replacing them outright.

### `lib/presentation/widgets/mb_card.dart` and `mb_glass.dart`
This is the core of the effect. For both:
- Wrap the `Container` in `ClipRRect` + `BackdropFilter` with
  `ImageFilter.blur(sigmaX: 18–24, sigmaY: 18–24)`.
- Fill with a `LinearGradient` (top → bottom) blending translucent white
  into the tinted surface color, e.g.
  `[Colors.white.withValues(alpha: 0.14), Colors.white.withValues(alpha: 0.06), baseTint.withValues(alpha: 0.55)]`
  in dark mode, brighter alphas in light mode.
- Border: `Border.all(color: isDark ? Colors.white.withValues(alpha: 0.16) : Colors.black.withValues(alpha: 0.10), width: 1)`.
- Two-layer shadow: a soft wide ambient shadow (`blurRadius: 24, offset: (0,12)`)
  plus a tight contact shadow (`blurRadius: 4, offset: (0,2)`) — both
  `Colors.black` at low alpha (higher alpha in dark mode).
- Corner radius: generous, 20–24px — glass reads best rounded, never sharp.

`isDark` comes from `AppLocator.themeRepository.isDark` (not
`Theme.of(context)` — see the theming note below).

### `lib/presentation/theme/app_theme.dart`
Bump card/button/input radii to 16–24px to match the rounder glass panels.
`elevatedButtonTheme`/`outlinedButtonTheme` can adopt the same translucent
treatment (semi-transparent fill + light border) rather than a solid fill.

### `lib/presentation/widgets/mb_button.dart`
Filled buttons: keep the accent-color fill but drop its opacity slightly
(alpha ~0.85) and add a subtle white top-highlight border so it reads as
glass too, not just the cards.

### `lib/presentation/widgets/mb_widgets.dart`
`MBControlButton` and `MBStatusChip` should also blur/tint rather than use
flat `surfaceRaised`/`surfaceHighlight` fills, for consistency.

## Constraints (from `CLAUDE.md` — do not skip)

- **Never mark a widget `const` at a call site whose `build()` reads a
  dynamic `AppColors` getter** (all of the above do). These getters aren't
  wired through `InheritedWidget`, so a `const` instance can freeze at a
  stale theme/brand after a switch. `prefer_const_constructors` is already
  disabled project-wide for this reason — don't re-enable it.
- Three sub-brands (`AppBrand.mercedes/amg/maybach`) each have their own
  `accentBlue`/`accentBlueDim` — keep using those getters for CTAs/borders
  rather than hardcoding a color, so brand-switching keeps working.
- `MainShell`'s bottom nav (`main_shell.dart`) uses `extendBody: true`, so
  any `showModalBottomSheet` near the bottom of the screen needs
  `useRootNavigator: true` or the glass nav bar will sit on top of it.

## Verify

There's no git repo in this project, so there's no cheap way to diff or
revert a broad re-skin — read each file back after editing rather than
assuming the edit landed as intended.

1. Run the `flutter-run` skill and screenshot `/home` and `/services` in
   both themes.
2. Run the `theme-audit` skill afterward — blur + translucency makes
   text-over-background contrast bugs easy to introduce and easy to miss in
   a single screenshot.
