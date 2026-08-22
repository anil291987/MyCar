import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../theme/colors.dart';
import '../../theme/typography.dart';
import '../../widgets/app_icon_mark.dart';
import '../../../l10n/generated/app_localizations.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..forward();

    Future.delayed(const Duration(milliseconds: 2800), () {
      if (mounted) context.go('/login');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, _) {
                final value = CurvedAnimation(
                  parent: _controller,
                  curve: const Interval(0.0, 0.7, curve: Curves.easeOutCubic),
                ).value;
                final rotate = CurvedAnimation(
                  parent: _controller,
                  curve: const Interval(0.0, 0.5, curve: Curves.easeOutBack),
                ).value;
                return Opacity(
                  opacity: value,
                  child: Transform.rotate(
                    angle: (1 - rotate) * math.pi * 0.5,
                    child: const AppIconMark(size: 80),
                  ),
                );
              },
            ),
            const SizedBox(height: 28),
            Text(AppLocalizations.of(context)!.brandName, style: AppTypography.displayMedium)
                .animate(delay: 400.ms)
                .fadeIn(duration: 600.ms, curve: Curves.easeOut),
            const SizedBox(height: 8),
            Text(
              AppLocalizations.of(context)!.splashTagline,
              style: AppTypography.caption.copyWith(
                color: AppColors.textTertiary,
                letterSpacing: 2.0,
              ),
            )
                .animate(delay: 700.ms)
                .fadeIn(duration: 600.ms, curve: Curves.easeOut),
          ],
        ),
      ),
    );
  }
}
