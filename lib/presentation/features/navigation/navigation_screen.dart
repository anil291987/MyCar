import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../theme/colors.dart';
import '../../theme/typography.dart';
import '../../widgets/mb_card.dart';
import '../../widgets/mb_widgets.dart';
import '../../../l10n/generated/app_localizations.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  final _searchCtrl = TextEditingController();
  bool _sendSuccess = false;

  final List<Map<String, dynamic>> _savedPlaces = [
    {'icon': Icons.home_outlined, 'name': 'Home', 'address': 'Bandra West, Mumbai 400050'},
    {'icon': Icons.work_outline, 'name': 'Office', 'address': 'BKC, Bandra Kurla Complex, Mumbai'},
    {'icon': Icons.local_parking_outlined, 'name': 'Vehicle Location', 'address': 'Parked – Linking Road, Mumbai'},
  ];

  final List<Map<String, dynamic>> _recent = [
    {'address': 'Juhu Beach, Mumbai', 'time': '2 days ago'},
    {'address': 'Nariman Point, Mumbai', 'time': '3 days ago'},
    {'address': 'Chhatrapati Shivaji Terminal', 'time': '1 week ago'},
  ];

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  void _sendToVehicle() async {
    setState(() => _sendSuccess = true);
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) setState(() => _sendSuccess = false);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.navigationTitle),
        backgroundColor: AppColors.background,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 92 + MediaQuery.of(context).padding.bottom),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Map Placeholder (static visual)
            _MapCard().animate().fadeIn(duration: 500.ms),

            const SizedBox(height: 20),

            // Search bar
            TextField(
              controller: _searchCtrl,
              style: AppTypography.bodyLarge,
              decoration: InputDecoration(
                hintText: l10n.searchForDestination,
                prefixIcon: Icon(Icons.search, color: AppColors.textTertiary, size: 20),
                suffixIcon: _searchCtrl.text.isNotEmpty
                    ? GestureDetector(
                        onTap: () => setState(() => _searchCtrl.clear()),
                        child: Icon(Icons.close, color: AppColors.textTertiary, size: 18),
                      )
                    : null,
              ),
              onChanged: (_) => setState(() {}),
            ).animate(delay: 100.ms).fadeIn(duration: 400.ms),

            if (_searchCtrl.text.isNotEmpty) ...[
              const SizedBox(height: 12),
              MBCard(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    _DestinationRow(
                      icon: Icons.location_on,
                      title: l10n.searchResultSuffix(_searchCtrl.text),
                      subtitle: l10n.tapToSendToVehicle,
                      onTap: _sendToVehicle,
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 24),

            // Send to Vehicle CTA
            if (_sendSuccess)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.successDim,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.success, width: 1),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle, color: AppColors.success, size: 20),
                    const SizedBox(width: 10),
                    Text(l10n.routeSentToVehicle,
                        style: AppTypography.bodyMedium.copyWith(color: AppColors.success)),
                  ],
                ),
              ).animate().fadeIn(duration: 300.ms).slideY(begin: -0.2)
            else
              GestureDetector(
                onTap: _sendToVehicle,
                child: Container(
                  height: 52,
                  decoration: BoxDecoration(
                    color: AppColors.accentBlue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.navigation_outlined, size: 18, color: AppColors.textPrimary),
                      const SizedBox(width: 8),
                      Text(l10n.sendToVehicle, style: AppTypography.labelLarge),
                    ],
                  ),
                ),
              ).animate(delay: 150.ms).fadeIn(duration: 400.ms),

            const SizedBox(height: 24),

            // Saved Places
            MBSectionHeader(title: l10n.sectionSavedPlaces, action: l10n.edit),
            const SizedBox(height: 12),
            MBCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: List.generate(_savedPlaces.length, (i) {
                  final place = _savedPlaces[i];
                  return Column(
                    children: [
                      _DestinationRow(
                        icon: place['icon'] as IconData,
                        title: place['name'] as String,
                        subtitle: place['address'] as String,
                        onTap: _sendToVehicle,
                      ),
                      if (i < _savedPlaces.length - 1) MBDivider(),
                    ],
                  );
                }),
              ),
            ).animate(delay: 200.ms).fadeIn(duration: 400.ms).slideY(begin: 0.1),

            const SizedBox(height: 24),

            // Recent
            MBSectionHeader(title: l10n.sectionRecentDestinations),
            const SizedBox(height: 12),
            MBCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: List.generate(_recent.length, (i) {
                  final item = _recent[i];
                  return Column(
                    children: [
                      _DestinationRow(
                        icon: Icons.history,
                        title: item['address'] as String,
                        subtitle: item['time'] as String,
                        iconColor: AppColors.textTertiary,
                        onTap: _sendToVehicle,
                      ),
                      if (i < _recent.length - 1) MBDivider(),
                    ],
                  );
                }),
              ),
            ).animate(delay: 300.ms).fadeIn(duration: 400.ms).slideY(begin: 0.1),
          ],
        ),
      ),
    );
  }
}

class _MapCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: const Color(0xFF1A2235),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          // Simulated map grid
          Positioned.fill(
            child: CustomPaint(painter: _MapPainter()),
          ),
          // Vehicle pin
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.accentBlue,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.directions_car, size: 20, color: Colors.white),
                ),
                Container(
                  width: 2,
                  height: 8,
                  color: AppColors.accentBlue,
                ),
              ],
            ),
          ),
          // Location label
          Positioned(
            bottom: 12,
            left: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.background.withValues(alpha: 0.85),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.location_pin, size: 14, color: AppColors.accentBlue),
                  const SizedBox(width: 4),
                  Text('Bandra West, Mumbai', style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textPrimary,
                  )),
                ],
              ),
            ),
          ),
          // Expand icon
          Positioned(
            top: 12,
            right: 12,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.background.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.open_in_full, size: 14, color: AppColors.textSecondary),
            ),
          ),
        ],
      ),
    );
  }
}

class _MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF243048)
      ..strokeWidth = 1;

    // Roads
    for (int i = 0; i < 6; i++) {
      canvas.drawLine(
        Offset(0, size.height * 0.2 * (i + 0.5)),
        Offset(size.width, size.height * 0.2 * (i + 0.3)),
        paint,
      );
    }
    for (int i = 0; i < 5; i++) {
      canvas.drawLine(
        Offset(size.width * 0.2 * i, 0),
        Offset(size.width * 0.2 * i + 20, size.height),
        paint,
      );
    }

    // Blocks
    final blockPaint = Paint()..color = const Color(0xFF1E2D45);
    final blocks = [
      Rect.fromLTWH(20, 20, 80, 50),
      Rect.fromLTWH(120, 30, 60, 40),
      Rect.fromLTWH(20, 90, 50, 70),
      Rect.fromLTWH(200, 60, 70, 60),
      Rect.fromLTWH(280, 20, 55, 45),
    ];
    for (final b in blocks) {
      canvas.drawRRect(RRect.fromRectAndRadius(b, const Radius.circular(4)), blockPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _DestinationRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final Color? iconColor;

  const _DestinationRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        child: Row(
          children: [
            Icon(icon, size: 20, color: iconColor ?? AppColors.accentBlue),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTypography.bodyLarge, maxLines: 1, overflow: TextOverflow.ellipsis),
                  Text(subtitle, style: AppTypography.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            Icon(Icons.send_outlined, size: 16, color: AppColors.textTertiary),
          ],
        ),
      ),
    );
  }
}
