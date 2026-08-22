import 'package:flutter/material.dart';
import '../../core/di/app_locator.dart';
import '../../domain/entities/brand.dart';

/// Porsche Connect-inspired design language: matte black / crisp white,
/// cool neutral greys (no warm undertone), sharp near-square corners, and a
/// precise, minimal use of color — the accent, not the surface, carries the
/// user's chosen accent theme. Brand-agnostic — no color here is tied to
/// any specific manufacturer.
///
/// Not const-cacheable — [accentBlue]/[accentBlueDim] now vary by
/// [AppBrand] (steel blue / crimson red / champagne gold), on top of the
/// existing dark/light variance. See CLAUDE.md's theming note: never mark a
/// widget `const` at a call site whose build reads these.
class AppColors {
  static bool get _isDark => AppLocator.themeRepository.isDark;
  static AppBrand get _brand => AppLocator.brandRepository.brand;

  // Backgrounds — matte black in dark mode, crisp white/grey in light,
  // neutral regardless of brand.
  static Color get background =>
      _isDark ? const Color(0xFF0A0A0B) : const Color(0xFFF4F4F5);
  static Color get surface =>
      _isDark ? const Color(0xFF17171A) : const Color(0xFFFFFFFF);
  static Color get surfaceRaised =>
      _isDark ? const Color(0xFF212124) : const Color(0xFFECECEE);
  static Color get surfaceHighlight =>
      _isDark ? const Color(0xFF2C2C30) : const Color(0xFFE0E0E3);

  // Text
  static Color get textPrimary =>
      _isDark ? const Color(0xFFFFFFFF) : const Color(0xFF111113);
  static Color get textSecondary =>
      _isDark ? const Color(0xFF97979D) : const Color(0xFF636369);
  static Color get textTertiary =>
      _isDark ? const Color(0xFF5C5C61) : const Color(0xFF9C9CA2);

  // Accent — the app's primary CTA/highlight color, driven by the user's
  // selected accent theme: steel blue, crimson red, champagne gold.
  static Color get accentBlue => switch (_brand) {
        AppBrand.steel => const Color(0xFF5B7A94),
        AppBrand.crimson => const Color(0xFFD5001C),
        AppBrand.champagne => const Color(0xFFB08A45),
      };
  static Color get accentBlueDim => switch (_brand) {
        AppBrand.steel => const Color(0xFF3A4F5F),
        AppBrand.crimson => const Color(0xFF7A0011),
        AppBrand.champagne => const Color(0xFF6B5730),
      };
  static Color get accentSilver =>
      _isDark ? const Color(0xFFB8B8BD) : const Color(0xFF63636A);
  static const Color accentGold = Color(0xFFB8975A);

  // Status
  static const Color success = Color(0xFF2E9245);
  static Color get successDim =>
      _isDark ? const Color(0xFF1A2E1E) : const Color(0xFFE1F0E3);
  static const Color warning = Color(0xFFC98A2E);
  static Color get warningDim =>
      _isDark ? const Color(0xFF332A16) : const Color(0xFFF6EBD9);
  static const Color error = Color(0xFFD5001C);
  static Color get errorDim =>
      _isDark ? const Color(0xFF331116) : const Color(0xFFF8E0E3);

  // Dividers / Borders
  static Color get divider =>
      _isDark ? const Color(0xFF29292D) : const Color(0xFFE1E1E4);
  static Color get border =>
      _isDark ? const Color(0xFF313136) : const Color(0xFFD8D8DC);
}
