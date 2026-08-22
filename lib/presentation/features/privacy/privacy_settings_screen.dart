import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../theme/colors.dart';
import '../../theme/typography.dart';
import '../../widgets/mb_card.dart';
import '../../widgets/mb_widgets.dart';
import '../../../l10n/generated/app_localizations.dart';

class PrivacySettingsScreen extends StatefulWidget {
  const PrivacySettingsScreen({super.key});

  @override
  State<PrivacySettingsScreen> createState() => _PrivacySettingsScreenState();
}

class _PrivacySettingsScreenState extends State<PrivacySettingsScreen> {
  bool _locationSharing = true;
  bool _usageAnalytics = true;
  bool _marketing = false;
  bool _diagnostics = true;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final items = [
      (
        l10n.privacyLocationSharing,
        l10n.privacyLocationSharingDesc,
        _locationSharing,
        (bool v) => setState(() => _locationSharing = v),
      ),
      (
        l10n.privacyUsageAnalytics,
        l10n.privacyUsageAnalyticsDesc,
        _usageAnalytics,
        (bool v) => setState(() => _usageAnalytics = v),
      ),
      (
        l10n.privacyMarketing,
        l10n.privacyMarketingDesc,
        _marketing,
        (bool v) => setState(() => _marketing = v),
      ),
      (
        l10n.privacyDiagnostics,
        l10n.privacyDiagnosticsDesc,
        _diagnostics,
        (bool v) => setState(() => _diagnostics = v),
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.privacyTitle),
        backgroundColor: AppColors.background,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.fromLTRB(20, 8, 20, 24 + MediaQuery.of(context).padding.bottom),
          children: [
            MBCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: List.generate(items.length, (i) {
                  final (title, desc, value, onChanged) = items[i];
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(title, style: AppTypography.bodyLarge),
                                  const SizedBox(height: 2),
                                  Text(desc, style: AppTypography.bodySmall),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Switch(
                              value: value,
                              onChanged: onChanged,
                              activeThumbColor: AppColors.accentBlue,
                            ),
                          ],
                        ),
                      ),
                      if (i < items.length - 1) const MBDivider(),
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
