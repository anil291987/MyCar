import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../theme/colors.dart';
import '../../theme/typography.dart';
import '../../widgets/mb_card.dart';
import '../../widgets/mb_widgets.dart';
import '../../../l10n/generated/app_localizations.dart';

class _NotificationItem {
  final IconData icon;
  final Color color;
  final String title;
  final String message;
  final String time;
  const _NotificationItem({
    required this.icon,
    required this.color,
    required this.title,
    required this.message,
    required this.time,
  });
}

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final today = [
      _NotificationItem(
        icon: Icons.lock_outlined,
        color: AppColors.success,
        title: l10n.statusLocked,
        message: l10n.allDoorsAreLocked,
        time: '08:12',
      ),
      _NotificationItem(
        icon: Icons.battery_charging_full_outlined,
        color: AppColors.accentBlue,
        title: 'Charging complete',
        message: 'Your EQS 580 reached 78% charge.',
        time: '06:40',
      ),
    ];
    final earlier = [
      _NotificationItem(
        icon: Icons.build_circle_outlined,
        color: AppColors.warning,
        title: 'Service reminder',
        message: 'Annual Service is scheduled for 2026-09-15.',
        time: 'Yesterday',
      ),
      _NotificationItem(
        icon: Icons.shield_outlined,
        color: AppColors.accentGold,
        title: 'Geofence alert',
        message: 'Vehicle left the "Home" zone.',
        time: '2 days ago',
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.notificationsTitle),
        backgroundColor: AppColors.background,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.fromLTRB(20, 8, 20, 24 + MediaQuery.of(context).padding.bottom),
          children: [
            MBSectionHeader(title: l10n.notifSectionToday),
            const SizedBox(height: 12),
            _NotificationList(items: today).animate().fadeIn(duration: 400.ms).slideY(begin: 0.08),
            const SizedBox(height: 24),
            MBSectionHeader(title: l10n.notifSectionEarlier),
            const SizedBox(height: 12),
            _NotificationList(items: earlier)
                .animate(delay: 100.ms)
                .fadeIn(duration: 400.ms)
                .slideY(begin: 0.08),
          ],
        ),
      ),
    );
  }
}

class _NotificationList extends StatelessWidget {
  final List<_NotificationItem> items;
  const _NotificationList({required this.items});

  @override
  Widget build(BuildContext context) {
    return MBCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: List.generate(items.length, (i) {
          final item = items[i];
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: item.color.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(item.icon, color: item.color, size: 18),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.title, style: AppTypography.headlineSmall.copyWith(fontSize: 14)),
                          const SizedBox(height: 2),
                          Text(item.message, style: AppTypography.bodySmall),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(item.time, style: AppTypography.caption),
                  ],
                ),
              ),
              if (i < items.length - 1) const MBDivider(),
            ],
          );
        }),
      ),
    );
  }
}
