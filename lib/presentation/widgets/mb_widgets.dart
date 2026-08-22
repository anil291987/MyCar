import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/typography.dart';

class MBStatusChip extends StatelessWidget {
  final String label;
  final Color color;
  final Color backgroundColor;

  const MBStatusChip({
    super.key,
    required this.label,
    required this.color,
    required this.backgroundColor,
  });

  factory MBStatusChip.success(String label) => MBStatusChip(
        label: label,
        color: AppColors.success,
        backgroundColor: AppColors.successDim,
      );

  factory MBStatusChip.warning(String label) => MBStatusChip(
        label: label,
        color: AppColors.warning,
        backgroundColor: AppColors.warningDim,
      );

  factory MBStatusChip.error(String label) => MBStatusChip(
        label: label,
        color: AppColors.error,
        backgroundColor: AppColors.errorDim,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: AppTypography.caption.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class MBDivider extends StatelessWidget {
  const MBDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(color: AppColors.divider, thickness: 1, height: 1);
  }
}

class MBControlButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback? onTap;
  final Color? activeColor;

  const MBControlButton({
    super.key,
    required this.icon,
    required this.label,
    this.isActive = false,
    this.onTap,
    this.activeColor,
  });

  @override
  State<MBControlButton> createState() => _MBControlButtonState();
}

class _MBControlButtonState extends State<MBControlButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
      lowerBound: 0.9,
      upperBound: 1.0,
    )..value = 1.0;
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final activeColor = widget.activeColor ?? AppColors.accentBlue;
    return GestureDetector(
      onTapDown: (_) => _ctrl.reverse(),
      onTapUp: (_) {
        _ctrl.forward();
        widget.onTap?.call();
      },
      onTapCancel: () => _ctrl.forward(),
      child: ScaleTransition(
        scale: CurvedAnimation(parent: _ctrl, curve: Curves.easeOut),
        child: Container(
          decoration: BoxDecoration(
            color: widget.isActive
                ? activeColor.withValues(alpha: 0.15)
                : AppColors.surfaceRaised,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: widget.isActive ? activeColor : AppColors.border,
              width: 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.icon,
                size: 28,
                color: widget.isActive ? activeColor : AppColors.textSecondary,
              ),
              const SizedBox(height: 8),
              // Fixed 2-line height so the icon stays vertically aligned
              // across tiles regardless of whether a given locale's label
              // wraps to one line or two (e.g. German "Fernstart" vs.
              // English "Remote\nStart").
              SizedBox(
                height: 32,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    widget.label,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: AppTypography.bodySmall.copyWith(
                      color: widget.isActive ? activeColor : AppColors.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
