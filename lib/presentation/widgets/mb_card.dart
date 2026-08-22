import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../../core/di/app_locator.dart';
import '../theme/typography.dart';

/// A sharp, precise card: solid surface color, a crisp hairline border, and
/// a tight, near-flat contact shadow — no blur, no glass, no soft glow.
/// This is the base building block of the app's instrument-panel design
/// language: matte surfaces, square-cut corners, restrained color.
///
/// Not const-cacheable across a theme switch — see CLAUDE.md's theming
/// note. Never mark call sites `const`.
class MBCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final double borderRadius;
  final VoidCallback? onTap;
  final bool hasBorder;

  MBCard({
    super.key,
    required this.child,
    this.padding,
    this.color,
    this.borderRadius = 10,
    this.onTap,
    this.hasBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = AppLocator.themeRepository.isDark;
    final radius = BorderRadius.circular(borderRadius);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding ?? const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color ?? AppColors.surface,
          borderRadius: radius,
          border: Border.all(
            color: AppColors.border,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.4 : 0.06),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}

class MBSectionHeader extends StatelessWidget {
  final String title;
  final String? action;
  final VoidCallback? onActionTap;

  const MBSectionHeader({
    super.key,
    required this.title,
    this.action,
    this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTypography.labelMedium.copyWith(
          color: AppColors.textSecondary,
          letterSpacing: 1.2,
        )),
        if (action != null)
          GestureDetector(
            onTap: onActionTap,
            child: Text(action!, style: AppTypography.labelMedium.copyWith(
              color: AppColors.accentBlue,
            )),
          ),
      ],
    );
  }
}
