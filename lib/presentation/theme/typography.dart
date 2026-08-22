import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/di/app_locator.dart';
import '../../domain/entities/brand.dart';
import 'colors.dart';

typedef _FontFn = TextStyle Function({
  TextStyle? textStyle,
  Color? color,
  Color? backgroundColor,
  double? fontSize,
  FontWeight? fontWeight,
  FontStyle? fontStyle,
  double? letterSpacing,
  double? wordSpacing,
  TextBaseline? textBaseline,
  double? height,
  Locale? locale,
  Paint? foreground,
  Paint? background,
  List<Shadow>? shadows,
  List<FontFeature>? fontFeatures,
  TextDecoration? decoration,
  Color? decorationColor,
  TextDecorationStyle? decorationStyle,
  double? decorationThickness,
});

/// Not const-cacheable — font family now varies by [AppBrand]'s accent
/// theme (steel: friendly geometric sans / crimson: bold technical grotesk
/// / champagne: warm serif), on top of the existing theme-driven text
/// colors. See CLAUDE.md's theming note.
class AppTypography {
  static _FontFn get _font => switch (AppLocator.brandRepository.brand) {
        AppBrand.steel => GoogleFonts.plusJakartaSans,
        AppBrand.crimson => GoogleFonts.spaceGrotesk,
        AppBrand.champagne => GoogleFonts.fraunces,
      };

  // The crimson theme's technical grotesk and champagne's warm serif both
  // read best with a touch more letter-spacing than steel's default.
  static double get _trackingBoost => switch (AppLocator.brandRepository.brand) {
        AppBrand.steel => 0,
        AppBrand.crimson => 0.3,
        AppBrand.champagne => 0.4,
      };

  static TextStyle get displayLarge => _font(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: -0.8 + _trackingBoost,
        height: 1.15,
      );

  static TextStyle get displayMedium => _font(
        fontSize: 26,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: -0.5 + _trackingBoost,
        height: 1.2,
      );

  static TextStyle get headlineLarge => _font(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        letterSpacing: -0.2 + _trackingBoost,
        height: 1.3,
      );

  static TextStyle get headlineMedium => _font(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
        letterSpacing: -0.1 + _trackingBoost,
        height: 1.35,
      );

  static TextStyle get headlineSmall => _font(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
        letterSpacing: _trackingBoost,
        height: 1.4,
      );

  static TextStyle get bodyLarge => _font(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
        letterSpacing: _trackingBoost,
        height: 1.5,
      );

  static TextStyle get bodyMedium => _font(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
        letterSpacing: _trackingBoost,
        height: 1.5,
      );

  static TextStyle get bodySmall => _font(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        color: AppColors.textTertiary,
        letterSpacing: 0.2 + _trackingBoost,
        height: 1.4,
      );

  static TextStyle get labelLarge => _font(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        letterSpacing: 0.5 + _trackingBoost,
        height: 1.2,
      );

  static TextStyle get labelMedium => _font(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: AppColors.textSecondary,
        letterSpacing: 0.8 + _trackingBoost,
        height: 1.2,
      );

  static TextStyle get caption => _font(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: AppColors.textTertiary,
        letterSpacing: 1.0 + _trackingBoost,
        height: 1.2,
      );
}
