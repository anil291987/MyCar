import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../theme/colors.dart';
import '../../theme/typography.dart';
import '../../widgets/mb_card.dart';
import '../../widgets/mb_widgets.dart';
import '../../../domain/entities/vehicle.dart';
import '../../cubits/vehicle_cubit.dart';
import '../../../l10n/generated/app_localizations.dart';

class RemoteControlScreen extends StatefulWidget {
  const RemoteControlScreen({super.key});

  @override
  State<RemoteControlScreen> createState() => _RemoteControlScreenState();
}

class _RemoteControlScreenState extends State<RemoteControlScreen> {
  bool _startLoading = false;
  bool _lightsActive = false;
  bool _hornActive = false;

  void _confirmAction(String title, String message, VoidCallback onConfirm) {
    final l10n = AppLocalizations.of(context)!;
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surfaceRaised,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppTypography.headlineMedium),
            const SizedBox(height: 8),
            Text(message, style: AppTypography.bodyMedium),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceHighlight,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(child: Text(l10n.cancel, style: AppTypography.labelLarge)),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      onConfirm();
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.accentBlue,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(child: Text(l10n.confirm, style: AppTypography.labelLarge)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vehicle = context.watch<VehicleCubit>().state;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.remoteControlTitle),
        backgroundColor: AppColors.background,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 92 + MediaQuery.of(context).padding.bottom),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Last updated
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.surfaceRaised,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.sync, size: 16, color: AppColors.accentBlue),
                  const SizedBox(width: 8),
                  Text(l10n.lastSynced,
                      style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary)),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(l10n.dataSynced)),
                    ),
                    child: Text(l10n.refresh, style: AppTypography.bodySmall.copyWith(
                      color: AppColors.accentBlue,
                    )),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 400.ms),

            const SizedBox(height: 24),
            MBSectionHeader(title: l10n.sectionSecurity).animate(delay: 100.ms).fadeIn(duration: 300.ms),
            const SizedBox(height: 12),

            // Lock / Unlock
            _LockUnlockCard(
              isLocked: vehicle.isLocked,
              onToggle: () => _confirmAction(
                vehicle.isLocked ? l10n.unlockVehicleTitle : l10n.lockVehicleTitle,
                vehicle.isLocked
                    ? l10n.unlockVehicleMessage
                    : l10n.lockVehicleMessage,
                () => context.read<VehicleCubit>().toggleLock(),
              ),
            ).animate(delay: 150.ms).fadeIn(duration: 400.ms).slideY(begin: 0.1),

            const SizedBox(height: 24),
            MBSectionHeader(title: l10n.sectionClimate).animate(delay: 200.ms).fadeIn(duration: 300.ms),
            const SizedBox(height: 12),

            _ClimateCard(vehicle: vehicle)
                .animate(delay: 250.ms)
                .fadeIn(duration: 400.ms)
                .slideY(begin: 0.1),

            const SizedBox(height: 24),
            MBSectionHeader(title: l10n.sectionControls).animate(delay: 300.ms).fadeIn(duration: 300.ms),
            const SizedBox(height: 12),

            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.3,
              children: [
                MBControlButton(
                  icon: Icons.wb_sunny_outlined,
                  label: l10n.flashLights,
                  isActive: _lightsActive,
                  onTap: () => setState(() => _lightsActive = !_lightsActive),
                ),
                MBControlButton(
                  icon: Icons.volume_up_outlined,
                  label: l10n.soundHorn,
                  isActive: _hornActive,
                  onTap: () => setState(() => _hornActive = !_hornActive),
                  activeColor: AppColors.warning,
                ),
                MBControlButton(
                  icon: Icons.roofing_outlined,
                  label: vehicle.sunroof ? l10n.closeSunroof : l10n.openSunroof,
                  isActive: vehicle.sunroof,
                  onTap: () => context.read<VehicleCubit>().toggleSunroof(),
                ),
                MBControlButton(
                  icon: Icons.directions_car_filled_outlined,
                  label: _startLoading ? l10n.starting : l10n.remoteStart,
                  isActive: _startLoading,
                  activeColor: AppColors.success,
                  onTap: () async {
                    setState(() => _startLoading = true);
                    await Future.delayed(const Duration(seconds: 2));
                    if (mounted) setState(() => _startLoading = false);
                  },
                ),
              ],
            ).animate(delay: 350.ms).fadeIn(duration: 400.ms),
          ],
        ),
      ),
    );
  }
}

class _LockUnlockCard extends StatelessWidget {
  final bool isLocked;
  final VoidCallback onToggle;

  const _LockUnlockCard({required this.isLocked, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return MBCard(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: isLocked
                  ? AppColors.successDim
                  : AppColors.errorDim,
              shape: BoxShape.circle,
            ),
            child: Icon(
              isLocked ? Icons.lock : Icons.lock_open,
              color: isLocked ? AppColors.success : AppColors.error,
              size: 26,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isLocked ? l10n.statusLocked : l10n.statusUnlocked,
                  style: AppTypography.headlineSmall,
                ),
                const SizedBox(height: 2),
                Text(
                  isLocked ? l10n.allDoorsAreLocked : l10n.vehicleIsUnlocked,
                  style: AppTypography.bodyMedium,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onToggle,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: isLocked ? AppColors.surfaceHighlight : AppColors.accentBlue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                isLocked ? l10n.actionUnlock : l10n.actionLock,
                style: AppTypography.labelLarge,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Mirrors premium EV companion apps' Pre-Entry Climate Control screens:
/// a centered circular status badge, an on/off status line, a temperature
/// row, and full-width Activate/Deactivate buttons — rather than the
/// previous inline icon-row-with-switch treatment.
class _ClimateCard extends StatelessWidget {
  final Vehicle vehicle;
  const _ClimateCard({required this.vehicle});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final active = vehicle.climateActive;
    return MBCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: active ? AppColors.accentBlueDim : AppColors.surfaceHighlight,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.ac_unit,
              size: 32,
              color: active ? AppColors.accentBlue : AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 12),
          Text(l10n.preEntryClimateControl, style: AppTypography.headlineSmall),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.circle,
                  size: 8, color: active ? AppColors.success : AppColors.textTertiary),
              const SizedBox(width: 5),
              Text(
                active ? l10n.climateOn : l10n.climateOff,
                style: AppTypography.caption,
              ),
            ],
          ),
          if (active) ...[
            const SizedBox(height: 4),
            Text(
              l10n.climateActivatingSoon,
              style: AppTypography.caption.copyWith(color: AppColors.accentBlue),
            ),
          ],
          const SizedBox(height: 20),
          MBDivider(),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(l10n.temperature, style: AppTypography.bodyLarge),
              Text('${vehicle.targetTemp.round()}°C',
                  style: AppTypography.headlineSmall.copyWith(
                    color: active ? AppColors.accentBlue : AppColors.textSecondary,
                  )),
            ],
          ),
          Slider(
            value: vehicle.targetTemp,
            min: 16,
            max: 30,
            divisions: 14,
            onChanged: active
                ? (v) => context.read<VehicleCubit>().setTargetTemp(v)
                : null,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('16°C', style: AppTypography.caption),
              Text('30°C', style: AppTypography.caption),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: active
                      ? () => context.read<VehicleCubit>().toggleClimate()
                      : null,
                  child: Text(l10n.deactivate),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: active
                      ? null
                      : () => context.read<VehicleCubit>().toggleClimate(),
                  child: Text(l10n.activate),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
