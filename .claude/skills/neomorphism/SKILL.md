---
name: neomorphism
description: Re-skin this app's design system into neomorphism ("soft UI") — flat monochrome surfaces extruded from the background using a paired light/dark shadow instead of borders or contrasting fills. Use when asked for a "neomorphism", "neumorphism", or "soft UI" redesign.
---

# Neomorphism ("soft UI") redesign

Every surface is the *same flat color* as the page behind it. Depth comes
only from a synthetic light/dark shadow pair — a highlight as if lit from
the top-left, a shade as if cast toward the bottom-right — never from a
border or a lighter/darker fill. Elements read as either **extruded**
(raised out of the surface, dual drop-shadow) or **engraved** (pressed/
active, shadow suppressed or inverted). Keep saturation low outside of
accent colors — neomorphism reads as calm and monochrome, not colorful.

## Files to touch

### `lib/presentation/theme/colors.dart`
Make `background`, `surface`, `surfaceRaised`, and `surfaceHighlight` all
near-identical tints of one base color (small lightness steps only, e.g.
2–4% apart) — resist the urge to give `surface` real contrast against
`background`; the shadow pair does all the depth work instead.

Add two new getters for the shadow pair:
```dart
static Color get shadowLight =>
    _isDark ? const Color(0xFF383C43) : const Color(0xFFFFFFFF);
static Color get shadowDark =>
    _isDark ? const Color(0xFF1C1E22) : const Color(0xFFBEC3CE);
```
Pick values close in lightness to `background` — a soft effect, not a hard
drop shadow. Also flatten `border`/`divider` toward near-background (they
should only ever appear as faint hairlines inside an already-raised card,
never as a shape-defining edge).

### `lib/presentation/widgets/mb_card.dart` and `mb_glass.dart`
Remove the `border` entirely. Replace the single ambient `boxShadow` with
**two** shadows:
```dart
boxShadow: [
  BoxShadow(color: AppColors.shadowDark, blurRadius: 16, offset: const Offset(6, 6)),
  BoxShadow(color: AppColors.shadowLight, blurRadius: 16, offset: const Offset(-6, -6)),
],
```
Corner radius: soft and generous, 18–24px. `color: AppColors.surface` (not
`surfaceRaised` — keep it flush with the page).

### Pressed / active states (`mb_widgets.dart`'s `MBControlButton`, toggle
rows, selected tabs)
Flutter can't do a true inset `box-shadow`. Fake the "engraved" look for an
active/pressed state by **dropping the shadow list entirely** and nudging
the fill very slightly darker (or lighter, in dark mode) than
`AppColors.surface` — the absence of the raised shadow reads as "pressed"
once the raised sibling elements are visibly extruded for contrast.

### `lib/presentation/theme/app_theme.dart` and `mb_button.dart`
Radii up to 16–24px to match the softer card corners. Buttons: keep the
brand `accentBlue` fill for primary CTAs (neomorphism still needs a clear
affordance for the main action), but drop `elevation`/hard shadows on
`OutlinedButton`/`TextButton` — let the extruded-card shadow pair be the
only depth cue elsewhere.

## Constraints (from `CLAUDE.md` — do not skip)

- **Never mark a widget `const` at a call site whose `build()` reads a
  dynamic `AppColors` getter** — `shadowLight`/`shadowDark` are exactly this
  kind of getter, same as `background`/`surface`. `prefer_const_constructors`
  is already disabled project-wide for this reason.
- Keep per-brand `accentBlue`/`accentBlueDim` for CTAs/highlights so brand
  switching (`AppBrand.mercedes/amg/maybach`) keeps working — neomorphism's
  monochrome base makes the accent color do more visual work than usual, so
  don't drop it in favor of an all-grey palette.
- `main_shell.dart`'s floating nav bar currently layers an extra
  `DecoratedBox` shadow *outside* `MBGlassSurface` — once `MBGlassSurface`
  has its own dual shadow, that outer wrapper becomes redundant (double
  shadow) and should be removed, not just left in place.

## Verify

There's no git repo in this project, so there's no cheap way to diff or
revert a broad re-skin — read each file back after editing rather than
assuming the edit landed as intended.

1. Run the `flutter-run` skill and screenshot `/home` and `/services` in
   both themes — check that raised cards are actually visible against the
   near-identical background (a shadow pair that's too subtle just
   disappears).
2. Run the `theme-audit` skill afterward — the very low surface/background
   contrast this style relies on is also exactly the condition that makes
   text-contrast bugs hardest to spot by eye.
