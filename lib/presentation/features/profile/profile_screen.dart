import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../theme/colors.dart';
import '../../theme/typography.dart';
import '../../cubits/vehicle_cubit.dart';
import '../../widgets/mb_button.dart';
import '../../widgets/mb_card.dart';
import '../../widgets/mb_widgets.dart';
import '../../../domain/entities/vehicle.dart';
import '../../../l10n/generated/app_localizations.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cubit = context.watch<VehicleCubit>();
    final vehicles = cubit.vehicles;
    final activeId = cubit.state.id;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.profileTitle),
        backgroundColor: AppColors.background,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20, 8, 20, 24 + MediaQuery.of(context).padding.bottom),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _ProfileHero()
                  .animate()
                  .fadeIn(duration: 400.ms)
                  .slideY(begin: 0.08),
              const SizedBox(height: 24),
              MBSectionHeader(
                title: l10n.profileSectionVehicles,
                action: l10n.profileAddVehicle,
                onActionTap: () => showVehicleEditSheet(context),
              ),
              const SizedBox(height: 12),
              _VehicleListSection(vehicles: vehicles, activeId: activeId)
                  .animate(delay: 80.ms)
                  .fadeIn(duration: 400.ms)
                  .slideY(begin: 0.08),
              const SizedBox(height: 24),
              MBSectionHeader(title: l10n.profileSectionAccount),
              const SizedBox(height: 12),
              _AccountDetailsCard(l10n: l10n)
                  .animate(delay: 140.ms)
                  .fadeIn(duration: 400.ms)
                  .slideY(begin: 0.08),
              const SizedBox(height: 28),
              MBButton(
                label: l10n.settingsSignOut,
                isOutlined: true,
                icon: Icons.logout,
                onPressed: () {},
              ).animate(delay: 200.ms).fadeIn(duration: 400.ms),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileHero extends StatelessWidget {
  const _ProfileHero();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return MBCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: AppColors.surfaceHighlight,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.border),
                ),
                child: Icon(Icons.person_outline, color: AppColors.textSecondary, size: 30),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Arjun Sharma', style: AppTypography.headlineLarge),
                    const SizedBox(height: 2),
                    Text('a.sharma@email.com',
                        style: AppTypography.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: MBButton(
              label: l10n.profileEditProfile,
              isOutlined: true,
              icon: Icons.edit_outlined,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}

/// One entry per vehicle in the user's garage. Tapping an inactive entry
/// selects it; the active one shows its full detail rows (plate/VIN) plus
/// edit/remove actions.
class _VehicleListSection extends StatelessWidget {
  final List<Vehicle> vehicles;
  final String activeId;
  const _VehicleListSection({required this.vehicles, required this.activeId});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < vehicles.length; i++) ...[
          if (i > 0) const SizedBox(height: 12),
          _VehicleTile(vehicle: vehicles[i], isActive: vehicles[i].id == activeId,
              canRemove: vehicles.length > 1),
        ],
      ],
    );
  }
}

class _VehicleTile extends StatelessWidget {
  final Vehicle vehicle;
  final bool isActive;
  final bool canRemove;
  const _VehicleTile({required this.vehicle, required this.isActive, required this.canRemove});

  void _confirmRemove(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cubit = context.read<VehicleCubit>();
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.surfaceRaised,
        title: Text(l10n.profileRemoveVehicle, style: AppTypography.headlineSmall),
        content: Text(l10n.profileRemoveVehicleConfirm, style: AppTypography.bodyMedium),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () {
              cubit.removeVehicle(vehicle.id);
              Navigator.pop(dialogContext);
            },
            child: Text(l10n.remove, style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cubit = context.read<VehicleCubit>();
    return MBCard(
      padding: EdgeInsets.zero,
      onTap: isActive ? null : () => cubit.selectVehicle(vehicle.id),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: isActive
                        ? AppColors.accentBlue.withValues(alpha: 0.15)
                        : AppColors.surfaceHighlight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.directions_car_filled_outlined,
                      color: isActive ? AppColors.accentBlue : AppColors.textSecondary, size: 22),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(vehicle.vehicleName, style: AppTypography.headlineSmall),
                      const SizedBox(height: 2),
                      Text(vehicle.vehicleModel, style: AppTypography.bodySmall),
                    ],
                  ),
                ),
                if (isActive)
                  MBStatusChip.success(l10n.profileActiveVehicle)
                else
                  Text(l10n.profileSwitchToVehicle, style: AppTypography.labelMedium.copyWith(
                    color: AppColors.accentBlue,
                  )),
                if (isActive) ...[
                  IconButton(
                    icon: Icon(Icons.edit_outlined, color: AppColors.textSecondary, size: 20),
                    onPressed: () => showVehicleEditSheet(context, existing: vehicle),
                  ),
                  if (canRemove)
                    IconButton(
                      icon: Icon(Icons.delete_outline, color: AppColors.error, size: 20),
                      onPressed: () => _confirmRemove(context),
                    ),
                ],
              ],
            ),
          ),
          if (isActive) ...[
            const MBDivider(),
            _DetailRow(label: l10n.profileLicensePlate, value: vehicle.licensePlate),
            const MBDivider(),
            _DetailRow(label: l10n.profileVin, value: vehicle.vehicleVin),
          ],
        ],
      ),
    );
  }
}

/// Shared add/edit form. Pass [existing] to edit that vehicle in place;
/// omit it to create and select a brand-new vehicle with sensible defaults.
void showVehicleEditSheet(BuildContext context, {Vehicle? existing}) {
  final l10n = AppLocalizations.of(context)!;
  final cubit = context.read<VehicleCubit>();
  final makeCtrl = TextEditingController(text: existing?.vehicleModel);
  final nameCtrl = TextEditingController(text: existing?.vehicleName);
  final plateCtrl = TextEditingController(text: existing?.licensePlate);
  final vinCtrl = TextEditingController(text: existing?.vehicleVin);

  showModalBottomSheet(
    context: context,
    useRootNavigator: true,
    isScrollControlled: true,
    backgroundColor: AppColors.surfaceRaised,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (sheetContext) => Padding(
      padding: EdgeInsets.fromLTRB(24, 24, 24, 24 + MediaQuery.of(sheetContext).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(existing == null ? l10n.profileAddVehicle : l10n.profileEditVehicle,
                style: AppTypography.headlineMedium),
            const SizedBox(height: 20),
            Text(l10n.profileVehicleMake, style: AppTypography.labelMedium),
            const SizedBox(height: 8),
            TextField(controller: makeCtrl),
            const SizedBox(height: 16),
            Text(l10n.profileVehicleModel, style: AppTypography.labelMedium),
            const SizedBox(height: 8),
            TextField(controller: nameCtrl),
            const SizedBox(height: 16),
            Text(l10n.profileVehiclePlate, style: AppTypography.labelMedium),
            const SizedBox(height: 8),
            TextField(controller: plateCtrl),
            const SizedBox(height: 16),
            Text(l10n.profileVehicleVin, style: AppTypography.labelMedium),
            const SizedBox(height: 8),
            TextField(controller: vinCtrl),
            const SizedBox(height: 24),
            MBButton(
              label: l10n.save,
              onPressed: () {
                if (existing != null) {
                  cubit.updateVehicleProfile(
                    vehicleModel: makeCtrl.text.trim(),
                    vehicleName: nameCtrl.text.trim(),
                    licensePlate: plateCtrl.text.trim(),
                    vehicleVin: vinCtrl.text.trim(),
                  );
                } else {
                  cubit.addVehicle(Vehicle(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    vehicleModel: makeCtrl.text.trim(),
                    vehicleName: nameCtrl.text.trim(),
                    licensePlate: plateCtrl.text.trim(),
                    vehicleVin: vinCtrl.text.trim(),
                    batteryLevel: 1.0,
                    rangeKm: 400,
                    isLocked: true,
                    doorFrontLeft: false,
                    doorFrontRight: false,
                    doorRearLeft: false,
                    doorRearRight: false,
                    sunroof: false,
                    trunk: false,
                    targetTemp: 21.0,
                    climateActive: false,
                    tirePressure: const {
                      'frontLeft': 33.0,
                      'frontRight': 33.0,
                      'rearLeft': 33.0,
                      'rearRight': 33.0,
                    },
                    totalMileage: 0,
                    lastJourneyKm: 0,
                    lastJourneyTime: Duration.zero,
                    serviceAppointments: const [],
                  ));
                }
                Navigator.pop(sheetContext);
              },
            ),
          ],
        ),
      ),
    ),
  );
}

class _AccountDetailsCard extends StatelessWidget {
  final AppLocalizations l10n;
  const _AccountDetailsCard({required this.l10n});

  @override
  Widget build(BuildContext context) {
    return MBCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          _DetailRow(label: l10n.profileMercedesMeId, value: 'a.sharma@email.com'),
          const MBDivider(),
          _DetailRow(label: l10n.profilePhone, value: '+91 98765 43210'),
          const MBDivider(),
          _DetailRow(label: l10n.profileMemberSince, value: 'Jan 2023'),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTypography.bodyMedium),
          Flexible(
            child: Text(
              value,
              style: AppTypography.bodyLarge,
              textAlign: TextAlign.end,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
