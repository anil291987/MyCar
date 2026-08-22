import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../theme/colors.dart';
import '../../theme/typography.dart';
import '../../widgets/mb_button.dart';
import '../../widgets/mb_card.dart';
import '../../widgets/mb_widgets.dart';
import '../../../l10n/generated/app_localizations.dart';

class _Zone {
  final String name;
  bool enabled;
  _Zone({required this.name, this.enabled = true});
}

class GeofencingScreen extends StatefulWidget {
  const GeofencingScreen({super.key});

  @override
  State<GeofencingScreen> createState() => _GeofencingScreenState();
}

class _GeofencingScreenState extends State<GeofencingScreen> {
  final List<_Zone> _zones = [
    _Zone(name: 'Home', enabled: true),
    _Zone(name: 'Office'),
  ];

  void _addZone() {
    final l10n = AppLocalizations.of(context)!;
    final controller = TextEditingController();
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      backgroundColor: AppColors.surfaceRaised,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) => Padding(
        padding: EdgeInsets.fromLTRB(24, 24, 24, 24 + MediaQuery.of(sheetContext).viewInsets.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.geofencingAddZone, style: AppTypography.headlineMedium),
            const SizedBox(height: 16),
            Text(l10n.geofencingNewZoneName, style: AppTypography.labelMedium),
            const SizedBox(height: 8),
            TextField(
              controller: controller,
              autofocus: true,
              decoration: InputDecoration(hintText: l10n.geofencingNewZoneHint),
            ),
            const SizedBox(height: 20),
            MBButton(
              label: l10n.geofencingAddZone,
              onPressed: () {
                final name = controller.text.trim();
                if (name.isEmpty) return;
                setState(() => _zones.add(_Zone(name: name)));
                Navigator.pop(sheetContext);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.geofencingTitle),
        backgroundColor: AppColors.background,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.fromLTRB(20, 8, 20, 24 + MediaQuery.of(context).padding.bottom),
          children: [
            Text(l10n.geofencingSubtitle, style: AppTypography.bodyMedium),
            const SizedBox(height: 16),
            MBCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: List.generate(_zones.length, (i) {
                  final zone = _zones[i];
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: AppColors.accentGold.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(Icons.shield_outlined, color: AppColors.accentGold, size: 18),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Text(zone.name, style: AppTypography.bodyLarge),
                            ),
                            Switch(
                              value: zone.enabled,
                              onChanged: (v) => setState(() => zone.enabled = v),
                              activeThumbColor: AppColors.accentBlue,
                            ),
                          ],
                        ),
                      ),
                      if (i < _zones.length - 1) const MBDivider(),
                    ],
                  );
                }),
              ),
            ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.08),
            const SizedBox(height: 16),
            MBButton(
              label: l10n.geofencingAddZone,
              isOutlined: true,
              icon: Icons.add,
              onPressed: _addZone,
            ),
          ],
        ),
      ),
    );
  }
}
