import 'package:flutter/material.dart';

/// Rounded tile displaying the app's generated launcher icon
/// (assets/icons/app_icon.png) for use as an in-app brand mark.
class AppIconMark extends StatelessWidget {
  final double size;
  final double borderRadius;

  const AppIconMark({super.key, this.size = 64, this.borderRadius = 18});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.asset(
        'assets/icons/app_icon.png',
        width: size,
        height: size,
        fit: BoxFit.cover,
      ),
    );
  }
}
