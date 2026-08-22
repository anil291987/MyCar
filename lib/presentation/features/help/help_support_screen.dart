import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../theme/colors.dart';
import '../../theme/typography.dart';
import '../../widgets/mb_card.dart';
import '../../widgets/mb_widgets.dart';
import '../../../l10n/generated/app_localizations.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final contactOptions = [
      (Icons.call_outlined, l10n.helpCallSupport, l10n.helpCallSupportDesc),
      (Icons.mail_outline, l10n.helpEmailSupport, l10n.helpEmailSupportDesc),
      (Icons.chat_bubble_outline, l10n.helpLiveChat, l10n.helpLiveChatDesc),
    ];

    final faqs = [
      (l10n.helpFaq1Q, l10n.helpFaq1A),
      (l10n.helpFaq2Q, l10n.helpFaq2A),
      (l10n.helpFaq3Q, l10n.helpFaq3A),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.helpTitle),
        backgroundColor: AppColors.background,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.fromLTRB(20, 8, 20, 24 + MediaQuery.of(context).padding.bottom),
          children: [
            MBCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: List.generate(contactOptions.length, (i) {
                  final (icon, title, desc) = contactOptions[i];
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(title)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: AppColors.accentBlue.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(icon, color: AppColors.accentBlue, size: 18),
                              ),
                              const SizedBox(width: 14),
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
                              Icon(Icons.chevron_right, color: AppColors.textTertiary, size: 18),
                            ],
                          ),
                        ),
                      ),
                      if (i < contactOptions.length - 1) const MBDivider(),
                    ],
                  );
                }),
              ),
            ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.08),
            const SizedBox(height: 24),
            MBSectionHeader(title: l10n.helpFaqSection),
            const SizedBox(height: 12),
            MBCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: List.generate(faqs.length, (i) {
                  final (q, a) = faqs[i];
                  return Column(
                    children: [
                      Theme(
                        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          title: Text(q, style: AppTypography.bodyLarge),
                          iconColor: AppColors.textSecondary,
                          collapsedIconColor: AppColors.textSecondary,
                          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          tilePadding: const EdgeInsets.symmetric(horizontal: 16),
                          expandedAlignment: Alignment.centerLeft,
                          children: [
                            Text(a, style: AppTypography.bodyMedium),
                          ],
                        ),
                      ),
                      if (i < faqs.length - 1) const MBDivider(),
                    ],
                  );
                }),
              ),
            ).animate(delay: 100.ms).fadeIn(duration: 400.ms).slideY(begin: 0.08),
          ],
        ),
      ),
    );
  }
}
