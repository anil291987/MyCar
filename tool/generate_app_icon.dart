// One-off generator: renders the app's launcher icon (dark gradient +
// accent-blue glow + three-pointed star mark, matching the in-app
// MBStarLogo/_MBLogoSmall branding) to assets/icons/app_icon.png.
//
// Run with: flutter test tool/generate_app_icon.dart
import 'dart:io';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

const double _kIconSize = 1024;

class _IconArt extends StatelessWidget {
  const _IconArt();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(_kIconSize, _kIconSize),
      painter: _IconPainter(),
    );
  }
}

class _IconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final cx = size.width / 2;
    final cy = size.height / 2;

    // Base gradient: near-black to deep navy, matching AppColors.background
    // (dark) with an accent-blue undertone.
    final bgPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF14161C), Color(0xFF0A0A0A)],
      ).createShader(rect);
    canvas.drawRect(rect, bgPaint);

    // Soft accent-blue glow behind the mark, echoing the app's accentBlue.
    final glowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFF0073E6).withValues(alpha: 0.35),
          const Color(0xFF0073E6).withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromCircle(center: Offset(cx, cy), radius: size.width * 0.55));
    canvas.drawRect(rect, glowPaint);

    // Glass specular highlight across the top, matching MBGlassSurface.
    final highlightPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.center,
        colors: [
          Colors.white.withValues(alpha: 0.10),
          Colors.white.withValues(alpha: 0.0),
        ],
      ).createShader(rect);
    canvas.drawRect(rect, highlightPaint);

    // Three-pointed star mark (same geometry as MBStarLogo).
    final r = size.width * 0.30;
    final circlePaint = Paint()
      ..color = const Color(0xFFE8E8EA)
      ..style = PaintingStyle.stroke
      ..strokeWidth = r * 0.075;
    canvas.drawCircle(Offset(cx, cy), r * 0.96, circlePaint);

    final starPaint = Paint()
      ..color = const Color(0xFFE8E8EA)
      ..style = PaintingStyle.fill;
    for (int i = 0; i < 3; i++) {
      final angle = -math.pi / 2 + i * 2 * math.pi / 3;
      _drawStar(canvas, cx, cy, r, angle, starPaint);
    }
  }

  void _drawStar(
      Canvas canvas, double cx, double cy, double r, double angle, Paint paint) {
    final tipX = cx + r * 0.82 * math.cos(angle);
    final tipY = cy + r * 0.82 * math.sin(angle);
    final leftAngle = angle + math.pi / 2;
    final rightAngle = angle - math.pi / 2;
    final lx = cx + r * 0.18 * math.cos(leftAngle);
    final ly = cy + r * 0.18 * math.sin(leftAngle);
    final rx = cx + r * 0.18 * math.cos(rightAngle);
    final ry = cy + r * 0.18 * math.sin(rightAngle);

    final path = Path()
      ..moveTo(tipX, tipY)
      ..lineTo(lx, ly)
      ..lineTo(cx, cy)
      ..lineTo(rx, ry)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

void main() {
  testWidgets('generate app icon PNG', (tester) async {
    tester.view.physicalSize = const Size(_kIconSize, _kIconSize);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    final key = GlobalKey();
    await tester.pumpWidget(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: RepaintBoundary(
          key: key,
          child: const _IconArt(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final boundary =
        key.currentContext!.findRenderObject() as RenderRepaintBoundary;
    final image = await boundary.toImage(pixelRatio: 1.0);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final bytes = byteData!.buffer.asUint8List();

    await tester.runAsync(() async {
      final file = File('assets/icons/app_icon.png');
      await file.parent.create(recursive: true);
      await file.writeAsBytes(bytes);
      // ignore: avoid_print
      print('Wrote ${file.path} (${bytes.length} bytes)');
    });
  });
}
