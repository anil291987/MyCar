---
name: claymorphism
description: Re-skin this app's design system into claymorphism — puffy, inflated 3D shapes in saturated pastel colors with a bold offset drop shadow and an inner highlight. Use when asked for a "claymorphism", "clay", or "puffy/3D UI" redesign.
---

# Claymorphism redesign

Shapes read like soft inflated clay or rubber: **saturated pastel** fills
(not the muted monochrome of neomorphism, not the translucent panels of
glassmorphism), very large soft-rounded corners, a bold single drop shadow
offset toward one corner for a "lifted off the page" feel, and — the detail
that sells the effect — a soft **inner highlight** near the top-left edge
that fakes a rounded, puffy bevel. A lighter-tinted border of the same hue
as the fill often outlines the shape too, reinforcing the molded-plastic
look.

## Files to touch

### `lib/presentation/theme/colors.dart`
Move away from the app's current neutral/matte palette toward **saturated
pastels**, still varied per sub-brand:
- `background`: a soft pastel (e.g. lavender-white in light, deep
  desaturated plum in dark) — clay needs a colored backdrop, not stark
  black/white.
- `surface`/`surfaceRaised`: pastel tints in the brand's hue family (blue-
  ish for `mercedes`, warm coral/red for `amg`, champagne for `maybach`),
  each noticeably lighter/more saturated than the current sharp-mode
  neutrals.
- Add two new getters used by the puff effect:
  ```dart
  static Color get clayShadow =>
      _isDark ? const Color(0xFF15121F) : const Color(0xFFB9A9D9);
  static Color get clayHighlight =>
      _isDark ? const Color(0xFF3A3350) : const Color(0xFFFFFFFF);
  ```
  (tune the hue toward whatever pastel `background` you pick — the shadow
  should read as a darker, more saturated version of the fill, not neutral
  grey).

### `lib/presentation/widgets/mb_card.dart` and `mb_glass.dart`
- Corner radius: large, 28–32px — claymorphism should look almost blobby,
  noticeably rounder than the app's other modes.
- Fill: `AppColors.surface` (the pastel tint), with a thin **lighter**
  border in the same hue: `Border.all(color: Color.lerp(surface, Colors.white, 0.35)!, width: 1.5)`.
- Shadow: one bold offset shadow, not the soft multi-layer stack used
  elsewhere —
  `BoxShadow(color: AppColors.clayShadow, blurRadius: 24, offset: const Offset(10, 10))`.
- Inner highlight (the part that makes it look "puffy," not just shadowed):
  overlay a `Container` inset by a few pixels along the top-left with a
  `RadialGradient` or `LinearGradient` fading `AppColors.clayHighlight` at
  low alpha into transparent — or simplest, a `BoxShadow` with a **negative
  offset and `blurStyle: BlurStyle.inner`** using `AppColors.clayHighlight`.

### `lib/presentation/theme/app_theme.dart`
Bump every radius (`cardTheme`, buttons, inputs) up to the 24–32px range to
match. Buttons should look like clay too: solid pastel/brand fill, bold
offset shadow, no flat/sharp edges anywhere.

### `lib/presentation/theme/typography.dart`
Claymorphism pairs well with a rounder, friendlier display face and bolder
weights than the app's current per-brand fonts — consider bumping
`displayLarge`/`headlineLarge` weight up and easing letter-spacing toward 0
or slightly positive for a softer, more playful feel, while keeping the
existing per-brand font-family switch (`GoogleFonts.plusJakartaSans` /
`spaceGrotesk` / `fraunces`) so brand identity doesn't disappear.

## Constraints (from `CLAUDE.md` — do not skip)

- **Never mark a widget `const` at a call site whose `build()` reads a
  dynamic `AppColors` getter** — `clayShadow`/`clayHighlight` are exactly
  this kind of getter. `prefer_const_constructors` is already disabled
  project-wide for this reason.
- Keep per-brand `accentBlue`/`accentBlueDim` distinct pastel/saturated
  hues per `AppBrand` (mercedes/amg/maybach) rather than collapsing them
  toward one shared pastel — the whole point of claymorphism here is bold,
  differentiated color, so this is a chance to lean into brand distinction,
  not flatten it.
- Watch contrast: saturated pastel fills plus light-mode's white-ish text
  fallback can go invisible fast — check `textPrimary`/`textSecondary`
  against the new pastel surfaces explicitly, don't assume the existing
  values still pass.

## Verify

There's no git repo in this project, so there's no cheap way to diff or
revert a broad re-skin — read each file back after editing rather than
assuming the edit landed as intended.

1. Run the `flutter-run` skill and screenshot `/home` and `/services` in
   both themes and across all three brands (Services → Appearance → Brand)
   — claymorphism's per-brand pastel hues are the main way brand identity
   shows up in this style, so all three need checking, not just one.
2. Run the `theme-audit` skill afterward — saturated pastel surfaces are a
   new source of low-contrast text that the app's existing screens haven't
   been checked against.
