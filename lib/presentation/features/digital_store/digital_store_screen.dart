import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../theme/colors.dart';
import '../../theme/typography.dart';
import '../../widgets/mb_card.dart';
import '../../widgets/mb_widgets.dart';
import '../../../l10n/generated/app_localizations.dart';

class _StoreItem {
  final String title;
  final String desc;
  final String price;
  bool active;
  _StoreItem({required this.title, required this.desc, required this.price, this.active = false});
}

class DigitalStoreScreen extends StatefulWidget {
  const DigitalStoreScreen({super.key});

  @override
  State<DigitalStoreScreen> createState() => _DigitalStoreScreenState();
}

class _DigitalStoreScreenState extends State<DigitalStoreScreen> {
  late final List<_StoreItem> _items = [
    _StoreItem(title: 'Parking Package', desc: 'Advanced parking assist features', price: '₹4,999/yr', active: true),
    _StoreItem(title: 'Sport Suspension', desc: 'Dynamic driving mode unlocked', price: '₹8,999/yr'),
    _StoreItem(title: 'Remote Park Pilot', desc: 'Park via smartphone remotely', price: '₹6,499/yr'),
    _StoreItem(title: 'Premium Sound', desc: 'Burmester® high-end 3D surround sound', price: '₹12,999/yr'),
    _StoreItem(title: 'Ambient Lighting Plus', desc: '64-color interior lighting themes', price: '₹2,999/yr'),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.digitalStoreTitle),
        backgroundColor: AppColors.background,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.fromLTRB(20, 8, 20, 24 + MediaQuery.of(context).padding.bottom),
          children: [
            Text(l10n.digitalStoreSubtitle, style: AppTypography.bodyMedium),
            const SizedBox(height: 16),
            MBCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: List.generate(_items.length, (i) {
                  final item = _items[i];
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: AppColors.accentGold.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(Icons.stars_outlined, color: AppColors.accentGold, size: 18),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.title, style: AppTypography.headlineSmall.copyWith(fontSize: 13)),
                                  const SizedBox(height: 2),
                                  Text(item.desc, style: AppTypography.bodySmall),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(item.price, style: AppTypography.bodyMedium.copyWith(
                                  color: AppColors.accentBlue,
                                  fontSize: 11,
                                )),
                                const SizedBox(height: 5),
                                if (item.active)
                                  MBStatusChip.success(l10n.active)
                                else
                                  GestureDetector(
                                    onTap: () {
                                      setState(() => item.active = true);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(l10n.digitalStorePurchased)),
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: AppColors.accentBlue,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(l10n.get, style: AppTypography.caption.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      )),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (i < _items.length - 1) const MBDivider(),
                    ],
                  );
                }),
              ),
            ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.08),
          ],
        ),
      ),
    );
  }
}
