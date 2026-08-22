import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../theme/colors.dart';
import '../../theme/typography.dart';
import '../../widgets/mb_card.dart';
import '../../../l10n/generated/app_localizations.dart';

class _Dealer {
  final String name;
  final String address;
  final String distance;
  final double rating;
  const _Dealer({
    required this.name,
    required this.address,
    required this.distance,
    required this.rating,
  });
}

class FindDealerScreen extends StatelessWidget {
  const FindDealerScreen({super.key});

  static const _dealers = [
    _Dealer(name: 'Westside Auto Care', address: 'Linking Road, Bandra West', distance: '2.4 km', rating: 4.6),
    _Dealer(name: 'City Auto Service Center', address: 'Ghodbunder Road, Thane West', distance: '18.1 km', rating: 4.4),
    _Dealer(name: 'Andheri Motor Works', address: 'Western Express Highway, Andheri East', distance: '9.7 km', rating: 4.5),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.findDealerTitle),
        backgroundColor: AppColors.background,
      ),
      body: SafeArea(
        child: ListView.separated(
          padding: EdgeInsets.fromLTRB(20, 8, 20, 24 + MediaQuery.of(context).padding.bottom),
          itemCount: _dealers.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, i) {
            final dealer = _dealers[i];
            return MBCard(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: AppColors.accentBlueDim,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(Icons.location_city_outlined, color: AppColors.accentBlue, size: 20),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(dealer.name, style: AppTypography.headlineSmall.copyWith(fontSize: 14)),
                            const SizedBox(height: 2),
                            Text(dealer.address, style: AppTypography.bodySmall),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.star, size: 14, color: AppColors.warning),
                      const SizedBox(width: 4),
                      Text('${dealer.rating}', style: AppTypography.bodySmall),
                      const SizedBox(width: 12),
                      Icon(Icons.near_me_outlined, size: 14, color: AppColors.textTertiary),
                      const SizedBox(width: 4),
                      Text(dealer.distance, style: AppTypography.bodySmall),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          icon: const Icon(Icons.call_outlined, size: 16),
                          label: Text(l10n.findDealerCall),
                          onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(l10n.findDealerCalling)),
                          ),
                          style: OutlinedButton.styleFrom(minimumSize: const Size(0, 40)),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.directions_outlined, size: 16),
                          label: Text(l10n.findDealerDirections),
                          onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(l10n.findDealerOpeningMaps)),
                          ),
                          style: ElevatedButton.styleFrom(minimumSize: const Size(0, 40)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ).animate(delay: (i * 60).ms).fadeIn(duration: 400.ms).slideY(begin: 0.08);
          },
        ),
      ),
    );
  }
}
