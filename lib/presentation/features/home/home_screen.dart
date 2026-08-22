import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../theme/colors.dart';
import '../../theme/typography.dart';
import '../../widgets/mb_card.dart';
import '../../widgets/mb_widgets.dart';
import '../../../domain/entities/vehicle.dart';
import '../../cubits/vehicle_cubit.dart';
import '../../../l10n/generated/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vehicle = context.watch<VehicleCubit>().state;
    final batteryPct = (vehicle.batteryLevel * 100).round();
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 0,
            backgroundColor: AppColors.background,
            leading: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Center(child: _MBLogoSmall(makeName: vehicle.vehicleModel)),
            ),
            leadingWidth: 150,
            actions: [
              IconButton(
                icon: Icon(Icons.notifications_outlined, color: AppColors.textSecondary),
                onPressed: () => context.push('/notifications'),
              ),
              IconButton(
                icon: Icon(Icons.account_circle_outlined, color: AppColors.textSecondary),
                onPressed: () => context.push('/profile'),
              ),
              const SizedBox(width: 8),
            ],
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Vehicle Hero Card
                  _VehicleHeroCard(vehicle: vehicle)
                      .animate()
                      .fadeIn(duration: 500.ms)
                      .slideY(begin: 0.1, curve: Curves.easeOutCubic),

                  const SizedBox(height: 20),

                  // Quick Status Row
                  MBSectionHeader(title: l10n.sectionVehicleStatus),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _QuickStatusCard(
                          icon: Icons.bolt_outlined,
                          label: l10n.statBattery,
                          value: '$batteryPct%',
                          color: _batteryColor(vehicle.batteryLevel),
                          subtitle: '${vehicle.rangeKm} km range',
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _QuickStatusCard(
                          icon: vehicle.isLocked ? Icons.lock : Icons.lock_open,
                          label: l10n.statSecurity,
                          value: vehicle.isLocked ? l10n.statusLocked : l10n.statusUnlocked,
                          color: vehicle.isLocked ? AppColors.success : AppColors.warning,
                          subtitle: l10n.allDoorsClosed,
                        ),
                      ),
                    ],
                  ).animate(delay: 200.ms).fadeIn(duration: 400.ms).slideY(begin: 0.1),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: _QuickStatusCard(
                          icon: Icons.tire_repair_outlined,
                          label: l10n.statTires,
                          value: l10n.tirePressureNormal,
                          color: AppColors.success,
                          subtitle: l10n.allPressuresOk,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _QuickStatusCard(
                          icon: Icons.location_on_outlined,
                          label: l10n.statLocation,
                          value: l10n.vehicleParked,
                          color: AppColors.accentBlue,
                          subtitle: 'Bandra West, Mumbai',
                        ),
                      ),
                    ],
                  ).animate(delay: 300.ms).fadeIn(duration: 400.ms).slideY(begin: 0.1),

                  const SizedBox(height: 24),

                  // Quick Actions
                  MBSectionHeader(title: l10n.sectionQuickActions),
                  const SizedBox(height: 12),
                  _QuickActionsRow(vehicle: vehicle)
                      .animate(delay: 400.ms)
                      .fadeIn(duration: 400.ms)
                      .slideY(begin: 0.1),

                  const SizedBox(height: 24),

                  // Last Journey
                  MBSectionHeader(title: l10n.sectionLastJourney),
                  const SizedBox(height: 12),
                  _LastJourneyCard(vehicle: vehicle)
                      .animate(delay: 500.ms)
                      .fadeIn(duration: 400.ms)
                      .slideY(begin: 0.1),

                  SizedBox(height: 92 + MediaQuery.of(context).padding.bottom),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _batteryColor(double level) {
    if (level > 0.5) return AppColors.success;
    if (level > 0.2) return AppColors.warning;
    return AppColors.error;
  }
}

/// Shows the user's own vehicle make (editable from Profile) rather than
/// any fixed manufacturer name/logo — this app is brand-agnostic and works
/// for any car.
class _MBLogoSmall extends StatelessWidget {
  final String makeName;
  const _MBLogoSmall({required this.makeName});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.directions_car_filled_rounded, size: 22, color: AppColors.accentSilver),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            makeName,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.labelLarge.copyWith(
              fontSize: 12,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ],
    );
  }
}

/// Mirrors the layout of premium EV companion apps' home screens: vehicle
/// name/plate as text above an isolated vehicle image, with battery/range
/// shown as a horizontal progress bar underneath (rather than the previous
/// dark photo-card-with-text-overlay treatment).
class _VehicleHeroCard extends StatelessWidget {
  final Vehicle vehicle;
  const _VehicleHeroCard({required this.vehicle});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final batteryPct = (vehicle.batteryLevel * 100).round();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.surface,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => showVehicleSwitcherSheet(context),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(vehicle.vehicleModel,
                          style: AppTypography.caption.copyWith(
                            color: AppColors.textSecondary,
                            letterSpacing: 1.5,
                          )),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Flexible(
                            child: Text(vehicle.vehicleName,
                                style: AppTypography.headlineLarge,
                                overflow: TextOverflow.ellipsis),
                          ),
                          if (context.watch<VehicleCubit>().vehicles.length > 1) ...[
                            const SizedBox(width: 4),
                            Icon(Icons.unfold_more, size: 18, color: AppColors.textTertiary),
                          ],
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(vehicle.licensePlate,
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                          )),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.successDim,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.circle, size: 8, color: AppColors.success),
                    const SizedBox(width: 5),
                    Text(l10n.onlineStatus,
                        style: AppTypography.caption.copyWith(color: AppColors.success)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: ColorFiltered(
              // Duotones the one shared vehicle photo with the selected
              // sub-brand's accent color (BlendMode.color keeps the
              // photo's original luminance/detail, just re-hues it), since
              // we don't have separate licensed photos per brand.
              colorFilter: ColorFilter.mode(AppColors.accentBlue, BlendMode.color),
              child: Image.asset(
                'assets/images/vehicle_hero.jpg',
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(vehicle.isLocked ? Icons.lock : Icons.lock_open,
                  size: 16, color: AppColors.textSecondary),
              const SizedBox(width: 6),
              Text('$batteryPct%', style: AppTypography.labelLarge),
              const SizedBox(width: 10),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: vehicle.batteryLevel,
                    minHeight: 6,
                    backgroundColor: AppColors.surfaceHighlight,
                    valueColor: AlwaysStoppedAnimation(_batteryColor(vehicle.batteryLevel)),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text('${vehicle.rangeKm} km', style: AppTypography.labelLarge),
            ],
          ),
        ],
      ),
    );
  }

  Color _batteryColor(double level) {
    if (level > 0.5) return AppColors.success;
    if (level > 0.2) return AppColors.warning;
    return AppColors.error;
  }
}

class _QuickStatusCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final String subtitle;

  const _QuickStatusCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return MBCard(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: AppColors.textTertiary),
              const SizedBox(width: 6),
              Text(label.toUpperCase(), style: AppTypography.caption),
            ],
          ),
          const SizedBox(height: 8),
          Text(value, style: AppTypography.headlineSmall.copyWith(color: color)),
          const SizedBox(height: 2),
          Text(subtitle, style: AppTypography.bodySmall),
        ],
      ),
    );
  }
}

class _QuickActionsRow extends StatefulWidget {
  final Vehicle vehicle;
  const _QuickActionsRow({required this.vehicle});

  @override
  State<_QuickActionsRow> createState() => _QuickActionsRowState();
}

class _QuickActionsRowState extends State<_QuickActionsRow> {
  bool _flashActive = false;
  bool _hornActive = false;

  void _momentaryTrigger(void Function(bool) write) async {
    write(true);
    await Future.delayed(const Duration(milliseconds: 600));
    if (mounted) write(false);
  }

  @override
  Widget build(BuildContext context) {
    final vehicle = widget.vehicle;
    final l10n = AppLocalizations.of(context)!;
    return Row(
      children: [
        _ActionChip(
          icon: vehicle.isLocked ? Icons.lock : Icons.lock_open,
          label: vehicle.isLocked ? l10n.actionUnlock : l10n.actionLock,
          onTap: () => context.read<VehicleCubit>().toggleLock(),
        ),
        const SizedBox(width: 10),
        _ActionChip(
          icon: Icons.ac_unit,
          label: l10n.actionClimate,
          onTap: () => context.read<VehicleCubit>().toggleClimate(),
          isActive: vehicle.climateActive,
        ),
        const SizedBox(width: 10),
        _ActionChip(
          icon: Icons.wb_sunny_outlined,
          label: l10n.actionFlash,
          isActive: _flashActive,
          onTap: () => _momentaryTrigger((v) => setState(() => _flashActive = v)),
        ),
        const SizedBox(width: 10),
        _ActionChip(
          icon: Icons.volume_up_outlined,
          label: l10n.actionHorn,
          isActive: _hornActive,
          onTap: () => _momentaryTrigger((v) => setState(() => _hornActive = v)),
        ),
      ],
    );
  }
}

class _ActionChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final bool isActive;

  const _ActionChip({
    required this.icon,
    required this.label,
    this.onTap,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isActive
                ? AppColors.accentBlue.withValues(alpha: 0.15)
                : AppColors.surfaceRaised,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isActive ? AppColors.accentBlue : AppColors.border,
              width: 1,
            ),
          ),
          child: Column(
            children: [
              Icon(icon,
                  size: 20,
                  color: isActive ? AppColors.accentBlue : AppColors.textSecondary),
              const SizedBox(height: 5),
              Text(label,
                  style: AppTypography.caption.copyWith(
                    color: isActive ? AppColors.accentBlue : AppColors.textTertiary,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class _LastJourneyCard extends StatelessWidget {
  final Vehicle vehicle;
  const _LastJourneyCard({required this.vehicle});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final minutes = vehicle.lastJourneyTime.inMinutes;
    return MBCard(
      hasBorder: true,
      padding: const EdgeInsets.all(18),
      child: Row(
        children: [
          _JourneyStat(
            value: '${vehicle.lastJourneyKm} km',
            label: l10n.statDistance,
          ),
          _VerticalDivider(),
          _JourneyStat(
            value: '${minutes}m',
            label: l10n.statDuration,
          ),
          _VerticalDivider(),
          _JourneyStat(
            value: '4.2 mi/kWh',
            label: l10n.statEfficiency,
          ),
          _VerticalDivider(),
          _JourneyStat(
            value: l10n.today,
            label: '10:24 AM',
          ),
        ],
      ),
    );
  }
}

class _JourneyStat extends StatelessWidget {
  final String value;
  final String label;
  const _JourneyStat({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(value, style: AppTypography.headlineSmall.copyWith(fontSize: 14)),
          const SizedBox(height: 3),
          Text(label, style: AppTypography.caption),
        ],
      ),
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      width: 1,
      color: AppColors.divider,
    );
  }
}

/// Quick garage switcher — lets the user jump straight to another vehicle
/// without leaving Home. Full add/edit/remove management lives on Profile.
void showVehicleSwitcherSheet(BuildContext context) {
  final l10n = AppLocalizations.of(context)!;
  final cubit = context.read<VehicleCubit>();
  showModalBottomSheet(
    context: context,
    useRootNavigator: true,
    backgroundColor: AppColors.surfaceRaised,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (sheetContext) => BlocBuilder<VehicleCubit, Vehicle>(
      bloc: cubit,
      builder: (context, active) {
        final vehicles = cubit.vehicles;
        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.profileSectionVehicles, style: AppTypography.headlineMedium),
              const SizedBox(height: 16),
              for (final v in vehicles)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: GestureDetector(
                    onTap: () {
                      cubit.selectVehicle(v.id);
                      Navigator.pop(sheetContext);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: v.id == active.id
                            ? AppColors.accentBlue.withValues(alpha: 0.15)
                            : AppColors.surface,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: v.id == active.id ? AppColors.accentBlue : AppColors.border,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.directions_car_filled_outlined,
                              color: v.id == active.id
                                  ? AppColors.accentBlue
                                  : AppColors.textSecondary),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(v.vehicleName, style: AppTypography.bodyLarge),
                                Text(v.vehicleModel, style: AppTypography.bodySmall),
                              ],
                            ),
                          ),
                          if (v.id == active.id)
                            MBStatusChip.success(l10n.profileActiveVehicle),
                        ],
                      ),
                    ),
                  ),
                ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(sheetContext);
                  context.push('/profile');
                },
                child: Text(l10n.profileAddVehicle, style: AppTypography.labelLarge.copyWith(
                  color: AppColors.accentBlue,
                )),
              ),
            ],
          ),
        );
      },
    ),
  );
}
