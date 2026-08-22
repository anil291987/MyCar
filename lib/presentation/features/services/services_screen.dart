import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../theme/colors.dart';
import '../../theme/typography.dart';
import '../../cubits/brand_cubit.dart';
import '../../cubits/locale_cubit.dart';
import '../../cubits/theme_cubit.dart';
import '../../cubits/vehicle_cubit.dart';
import '../../widgets/mb_card.dart';
import '../../widgets/mb_widgets.dart';
import '../../../domain/entities/brand.dart';
import '../../../l10n/generated/app_localizations.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vehicle = context.watch<VehicleCubit>().state;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.servicesTitle),
        backgroundColor: AppColors.background,
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle_outlined, color: AppColors.textSecondary),
            onPressed: () => context.push('/profile'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 92 + MediaQuery.of(context).padding.bottom),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile card
            _ProfileCard().animate().fadeIn(duration: 400.ms),
            const SizedBox(height: 24),

            // Services grid
            MBSectionHeader(title: l10n.sectionMyServices),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.4,
              children: [
                _ServiceCard(
                  icon: Icons.build_circle_outlined,
                  title: l10n.serviceWorkshop,
                  subtitle: l10n.serviceWorkshopSubtitle,
                  color: AppColors.accentBlue,
                  onTap: () => context.push('/workshop'),
                ),
                _ServiceCard(
                  icon: Icons.store_outlined,
                  title: l10n.serviceDigitalStore,
                  subtitle: l10n.serviceDigitalStoreSubtitle,
                  color: AppColors.accentGold,
                  onTap: () => context.push('/digital-store'),
                ),
                _ServiceCard(
                  icon: Icons.location_city_outlined,
                  title: l10n.serviceFindDealer,
                  subtitle: l10n.serviceFindDealerSubtitle,
                  color: AppColors.success,
                  onTap: () => context.push('/find-dealer'),
                ),
                _ServiceCard(
                  icon: Icons.shield_outlined,
                  title: l10n.serviceGeofencing,
                  subtitle: l10n.serviceGeofencingSubtitle,
                  color: AppColors.warning,
                  onTap: () => context.push('/geofencing'),
                ),
              ],
            )
            .animate(delay: 100.ms).fadeIn(duration: 400.ms).slideY(begin: 0.1),

            // const SizedBox(height: 24),

            // Service Appointments
            MBSectionHeader(
              title: l10n.sectionUpcomingAppointments,
              action: l10n.bookNew,
              onActionTap: () => context.push('/workshop'),
            ),
            const SizedBox(height: 12),
            MBCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: List.generate(vehicle.serviceAppointments.length, (i) {
                  final appt = vehicle.serviceAppointments[i];
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: AppColors.accentBlueDim,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(Icons.calendar_today_outlined,
                                  size: 18, color: AppColors.accentBlue),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(appt['title'] as String,
                                      style: AppTypography.headlineSmall.copyWith(fontSize: 14)),
                                  const SizedBox(height: 2),
                                  Text(appt['dealer'] as String,
                                      style: AppTypography.bodySmall,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(appt['date'] as String,
                                    style: AppTypography.bodyMedium.copyWith(
                                      color: AppColors.accentBlue,
                                      fontSize: 12,
                                    )),
                                const SizedBox(height: 3),
                                MBStatusChip.success(l10n.confirmed),
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (i < vehicle.serviceAppointments.length - 1) MBDivider(),
                    ],
                  );
                }),
              ),
            ).animate(delay: 200.ms).fadeIn(duration: 400.ms).slideY(begin: 0.1),

            const SizedBox(height: 24),

            // ECO Stats
            MBSectionHeader(title: l10n.sectionEcoDisplay),
            const SizedBox(height: 12),
            _EcoCard().animate(delay: 300.ms).fadeIn(duration: 400.ms).slideY(begin: 0.1),

            const SizedBox(height: 24),

            // Digital Extras
            MBSectionHeader(title: l10n.sectionDigitalExtras, action: l10n.viewAll),
            const SizedBox(height: 12),
            _DigitalExtrasSection().animate(delay: 400.ms).fadeIn(duration: 400.ms).slideY(begin: 0.1),

            const SizedBox(height: 24),

            // Appearance
            MBSectionHeader(title: l10n.sectionAppearance),
            const SizedBox(height: 12),
            _AppearanceSection().animate(delay: 450.ms).fadeIn(duration: 400.ms),

            const SizedBox(height: 24),

            // Brand
            MBSectionHeader(title: l10n.sectionBrand),
            const SizedBox(height: 12),
            _BrandSection().animate(delay: 470.ms).fadeIn(duration: 400.ms),

            const SizedBox(height: 24),

            // Settings
            _SettingsSection().animate(delay: 500.ms).fadeIn(duration: 400.ms),
          ],
        ),
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return MBCard(
      padding: const EdgeInsets.all(20),
      onTap: () => context.push('/profile'),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: AppColors.surfaceHighlight,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.border),
            ),
            child: Icon(Icons.person_outline, color: AppColors.textSecondary, size: 26),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.welcomeBack, style: AppTypography.bodyMedium),
                Text('Arjun Sharma', style: AppTypography.headlineMedium),
                const SizedBox(height: 2),
                Text('${l10n.profileMercedesMeId}: a.sharma@email.com',
                    style: AppTypography.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: AppColors.textTertiary),
        ],
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback? onTap;

  const _ServiceCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.border),
        ),
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 16),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title, style: AppTypography.headlineSmall.copyWith(fontSize: 14)),
                const SizedBox(height: 2),
                Text(subtitle, style: AppTypography.bodySmall),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _EcoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return MBCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.eco_outlined, color: AppColors.success, size: 18),
              const SizedBox(width: 8),
              Text(l10n.ecoScore, style: AppTypography.headlineSmall),
              const Spacer(),
              Text('4.2 / 5.0', style: AppTypography.headlineMedium.copyWith(
                color: AppColors.success,
              )),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: 4.2 / 5.0,
              minHeight: 6,
              backgroundColor: AppColors.surfaceHighlight,
              valueColor: const AlwaysStoppedAnimation(AppColors.success),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _EcoStat('28.4 km', l10n.ecoAvgRange),
              _EcoStat('4.1 mi/kWh', l10n.ecoEfficiency),
              _EcoStat('92%', l10n.ecoRegenBrake),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            l10n.ecoEncouragement,
            style: AppTypography.bodySmall.copyWith(color: AppColors.success),
          ),
        ],
      ),
    );
  }
}

class _EcoStat extends StatelessWidget {
  final String value;
  final String label;
  const _EcoStat(this.value, this.label);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(value, style: AppTypography.headlineSmall.copyWith(fontSize: 13)),
          const SizedBox(height: 2),
          Text(label, style: AppTypography.caption, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class _DigitalExtrasSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final extras = [
      {'title': 'Parking Package', 'desc': 'Advanced parking assist features', 'price': '₹4,999/yr', 'active': true},
      {'title': 'Sport Suspension', 'desc': 'Dynamic driving mode unlocked', 'price': '₹8,999/yr', 'active': false},
      {'title': 'Remote Park Pilot', 'desc': 'Park via smartphone remotely', 'price': '₹6,499/yr', 'active': false},
    ];

    return MBCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: List.generate(extras.length, (i) {
          final e = extras[i];
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
                          Text(e['title'] as String, style: AppTypography.headlineSmall.copyWith(fontSize: 13)),
                          const SizedBox(height: 2),
                          Text(e['desc'] as String, style: AppTypography.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(e['price'] as String, style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.accentBlue,
                          fontSize: 11,
                        )),
                        const SizedBox(height: 3),
                        if (e['active'] as bool)
                          MBStatusChip.success(l10n.active)
                        else
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceHighlight,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(l10n.get, style: AppTypography.caption.copyWith(
                              color: AppColors.accentBlue,
                              fontWeight: FontWeight.w600,
                            )),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              if (i < extras.length - 1) MBDivider(),
            ],
          );
        }),
      ),
    );
  }
}

class _AppearanceSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeCubit = context.watch<ThemeCubit>();
    final mode = themeCubit.state;
    final l10n = AppLocalizations.of(context)!;
    return MBCard(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          _AppearanceOption(
            label: l10n.appearanceSystem,
            icon: Icons.brightness_auto_outlined,
            selected: mode == ThemeMode.system,
            onTap: () => context.read<ThemeCubit>().setMode(ThemeMode.system),
          ),
          _AppearanceOption(
            label: l10n.appearanceLight,
            icon: Icons.light_mode_outlined,
            selected: mode == ThemeMode.light,
            onTap: () => context.read<ThemeCubit>().setMode(ThemeMode.light),
          ),
          _AppearanceOption(
            label: l10n.appearanceDark,
            icon: Icons.dark_mode_outlined,
            selected: mode == ThemeMode.dark,
            onTap: () => context.read<ThemeCubit>().setMode(ThemeMode.dark),
          ),
        ],
      ),
    );
  }
}

class _AppearanceOption extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _AppearanceOption({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.all(4),
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: selected ? AppColors.accentBlueDim : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected ? AppColors.accentBlue : AppColors.border,
            ),
          ),
          child: Column(
            children: [
              Icon(icon, size: 20,
                  color: selected ? AppColors.accentBlue : AppColors.textSecondary),
              const SizedBox(height: 6),
              Text(label, style: AppTypography.bodySmall.copyWith(
                color: selected ? AppColors.accentBlue : AppColors.textSecondary,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
              )),
            ],
          ),
        ),
      ),
    );
  }
}

class _BrandSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final brandCubit = context.watch<BrandCubit>();
    final brand = brandCubit.state;
    return MBCard(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          for (final b in AppBrand.values)
            _BrandOption(
              label: b.displayName,
              selected: brand == b,
              onTap: () => context.read<BrandCubit>().setBrand(b),
            ),
        ],
      ),
    );
  }
}

class _BrandOption extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _BrandOption({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.all(4),
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: selected ? AppColors.accentBlueDim : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected ? AppColors.accentBlue : AppColors.border,
            ),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: AppTypography.bodySmall.copyWith(
              color: selected ? AppColors.accentBlue : AppColors.textSecondary,
              fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  static const _notificationsIndex = 0;
  static const _languageIndex = 1;
  static const _privacyIndex = 2;
  static const _helpIndex = 3;
  static const _signOutIndex = 4;

  void _showLanguagePicker(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final localeCubit = context.read<LocaleCubit>();
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      backgroundColor: AppColors.surfaceRaised,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => BlocBuilder<LocaleCubit, Locale?>(
        bloc: localeCubit,
        builder: (context, current) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.chooseLanguage, style: AppTypography.headlineMedium),
                const SizedBox(height: 16),
                _LanguageOption(
                  label: l10n.languageEnglish,
                  selected: current == null || current.languageCode == 'en',
                  onTap: () {
                    localeCubit.setLocale(const Locale('en'));
                    Navigator.pop(context);
                  },
                ),
                _LanguageOption(
                  label: l10n.languageGerman,
                  selected: current?.languageCode == 'de',
                  onTap: () {
                    localeCubit.setLocale(const Locale('de'));
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(l10n.cancel),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final items = [
      (Icons.notifications_outlined, l10n.settingsNotifications),
      (Icons.language_outlined, l10n.settingsLanguageRegion),
      (Icons.privacy_tip_outlined, l10n.settingsPrivacy),
      (Icons.help_outline, l10n.settingsHelp),
      (Icons.logout, l10n.settingsSignOut),
    ];

    return MBCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: List.generate(items.length, (i) {
          final (icon, label) = items[i];
          final isSignOut = i == _signOutIndex;
          return Column(
            children: [
              GestureDetector(
                onTap: switch (i) {
                  _notificationsIndex => () => context.push('/notifications'),
                  _languageIndex => () => _showLanguagePicker(context),
                  _privacyIndex => () => context.push('/privacy'),
                  _helpIndex => () => context.push('/help'),
                  _ => () {},
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  child: Row(
                    children: [
                      Icon(icon, size: 20,
                          color: isSignOut ? AppColors.error : AppColors.textSecondary),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(label, style: AppTypography.bodyLarge.copyWith(
                          color: isSignOut ? AppColors.error : AppColors.textPrimary,
                        )),
                      ),
                      if (!isSignOut)
                        Icon(Icons.chevron_right, color: AppColors.textTertiary, size: 18),
                    ],
                  ),
                ),
              ),
              if (i < items.length - 1) MBDivider(),
            ],
          );
        }),
      ),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _LanguageOption({required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: Text(label, style: AppTypography.bodyLarge.copyWith(
                color: selected ? AppColors.accentBlue : AppColors.textPrimary,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
              )),
            ),
            if (selected) Icon(Icons.check, color: AppColors.accentBlue, size: 20),
          ],
        ),
      ),
    );
  }
}
