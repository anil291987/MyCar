import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../theme/colors.dart';
import '../../theme/typography.dart';
import '../../cubits/vehicle_cubit.dart';
import '../../widgets/mb_card.dart';
import '../../widgets/mb_widgets.dart';
import '../../../l10n/generated/app_localizations.dart';

class WorkshopScreen extends StatelessWidget {
  const WorkshopScreen({super.key});

  void _showBookingSheet(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cubit = context.read<VehicleCubit>();
    final services = [
      (l10n.workshopServiceGeneral, 'Westside Auto Care, Mumbai'),
      (l10n.workshopServiceTireRotation, 'City Auto Service Center, Thane'),
      (l10n.workshopServiceBrakeCheck, 'Westside Auto Care, Mumbai'),
      (l10n.workshopServiceBattery, 'Andheri Motor Works'),
    ];

    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      backgroundColor: AppColors.surfaceRaised,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) => SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(24, 24, 24, 40 + MediaQuery.of(sheetContext).viewInsets.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.workshopSelectService, style: AppTypography.headlineMedium),
            const SizedBox(height: 16),
            for (final (title, dealer) in services)
              _ServiceOption(
                title: title,
                dealer: dealer,
                onTap: () {
                  cubit.bookServiceAppointment({
                    'title': title,
                    'date': '2026-11-04',
                    'dealer': dealer,
                    'status': 'upcoming',
                  });
                  Navigator.pop(sheetContext);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(l10n.workshopBooked)),
                  );
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
    final vehicle = context.watch<VehicleCubit>().state;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.workshopTitle),
        backgroundColor: AppColors.background,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.fromLTRB(20, 8, 20, 24 + MediaQuery.of(context).padding.bottom),
          children: [
            MBSectionHeader(title: l10n.workshopUpcoming, action: l10n.bookNew,
                onActionTap: () => _showBookingSheet(context)),
            const SizedBox(height: 12),
            if (vehicle.serviceAppointments.isEmpty)
              MBCard(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(l10n.workshopNoAppointments, style: AppTypography.bodyMedium),
                  ),
                ),
              )
            else
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
                        if (i < vehicle.serviceAppointments.length - 1) const MBDivider(),
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

class _ServiceOption extends StatelessWidget {
  final String title;
  final String dealer;
  final VoidCallback onTap;
  const _ServiceOption({required this.title, required this.dealer, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTypography.bodyLarge),
                  const SizedBox(height: 2),
                  Text(dealer, style: AppTypography.bodySmall),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: AppColors.textTertiary),
          ],
        ),
      ),
    );
  }
}
