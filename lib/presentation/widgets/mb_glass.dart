import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../../core/di/app_locator.dart';

/// Flat, opaque surface used for chrome like the floating nav bar: solid
/// color, a hairline border, and a soft ambient shadow — no blur or glass.
///
/// Not const-cacheable across a theme switch — see CLAUDE.md's theming
/// note. Never mark call sites `const`.
class MBGlassSurface extends StatelessWidget {
  final Widget child;
  final BorderRadius borderRadius;
  final double blurSigma;
  final EdgeInsetsGeometry? padding;
  final Border? border;

  MBGlassSurface({
    super.key,
    required this.child,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.blurSigma = 24,
    this.padding,
  }) : border = _defaultBorder();

  static Border _defaultBorder() {
    return Border.all(
      color: AppColors.border,
      width: 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = AppLocator.themeRepository.isDark;
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: borderRadius,
        border: border,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.08),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: child,
    );
  }
}
