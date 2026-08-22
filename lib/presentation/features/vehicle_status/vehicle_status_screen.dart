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

class VehicleStatusScreen extends StatelessWidget {
  const VehicleStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vehicle = context.watch<VehicleCubit>().state;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.vehicleStatusTitle),
        backgroundColor: AppColors.background,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh_outlined, color: AppColors.textSecondary),
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(l10n.dataSynced)),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 88 + MediaQuery.of(context).padding.bottom),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Car Silhouette with door indicators
            _CarStatusVisual(vehicle: vehicle)
                .animate()
                .fadeIn(duration: 500.ms),

            const SizedBox(height: 20),

            // Battery / Range
            MBSectionHeader(title: l10n.sectionBatteryRange),
            const SizedBox(height: 12),
            _BatteryCard(vehicle: vehicle)
                .animate(delay: 100.ms)
                .fadeIn(duration: 400.ms)
                .slideY(begin: 0.1),

            const SizedBox(height: 20),

            // Doors & Security
            MBSectionHeader(title: l10n.sectionDoorsSecurity),
            const SizedBox(height: 12),
            _DoorsCard(vehicle: vehicle)
                .animate(delay: 200.ms)
                .fadeIn(duration: 400.ms)
                .slideY(begin: 0.1),

            const SizedBox(height: 20),

            // Tire Pressure
            MBSectionHeader(title: l10n.sectionTirePressure),
            const SizedBox(height: 12),
            _TirePressureCard(vehicle: vehicle)
                .animate(delay: 300.ms)
                .fadeIn(duration: 400.ms)
                .slideY(begin: 0.1),

            const SizedBox(height: 20),

            // Mileage
            MBSectionHeader(title: l10n.sectionMileage),
            const SizedBox(height: 12),
            _MileageCard(vehicle: vehicle)
                .animate(delay: 400.ms)
                .fadeIn(duration: 400.ms)
                .slideY(begin: 0.1),
          ],
        ),
      ),
    );
  }
}

class _CarStatusVisual extends StatelessWidget {
  final Vehicle vehicle;
  const _CarStatusVisual({required this.vehicle});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return MBCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            vehicle.vehicleName,
            style: AppTypography.headlineSmall,
          ),
          const SizedBox(height: 4),
          MBStatusChip.success(vehicle.isLocked ? l10n.allSecured : l10n.statusUnlocked),
          const SizedBox(height: 20),
          SizedBox(
            height: 120,
            child: CustomPaint(
              size: const Size(double.infinity, 120),
              painter: _CarTopViewPainter(
                locked: vehicle.isLocked,
                sunroofOpen: vehicle.sunroof,
                trunkOpen: vehicle.trunk,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _DoorIndicator('FL', vehicle.doorFrontLeft),
              _DoorIndicator('FR', vehicle.doorFrontRight),
              _DoorIndicator('RL', vehicle.doorRearLeft),
              _DoorIndicator('RR', vehicle.doorRearRight),
              _DoorIndicator(l10n.trunk, vehicle.trunk),
              _DoorIndicator(l10n.sunroof, vehicle.sunroof),
            ],
          ),
        ],
      ),
    );
  }
}

class _DoorIndicator extends StatelessWidget {
  final String label;
  final bool isOpen;
  const _DoorIndicator(this.label, this.isOpen);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          isOpen ? Icons.radio_button_off : Icons.check_circle,
          size: 16,
          color: isOpen ? AppColors.error : AppColors.success,
        ),
        const SizedBox(height: 3),
        Text(label, style: AppTypography.caption),
      ],
    );
  }
}

class _CarTopViewPainter extends CustomPainter {
  final bool locked;
  final bool sunroofOpen;
  final bool trunkOpen;

  _CarTopViewPainter({
    required this.locked,
    required this.sunroofOpen,
    required this.trunkOpen,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.surfaceRaised
      ..style = PaintingStyle.fill;

    final strokePaint = Paint()
      ..color = AppColors.border
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final cx = size.width / 2;
    final carW = size.width * 0.35;
    final carH = size.height * 0.88;
    final carLeft = cx - carW / 2;
    final carTop = size.height * 0.06;

    // Car body
    final bodyPath = Path();
    bodyPath.addRRect(RRect.fromLTRBR(
      carLeft, carTop, carLeft + carW, carTop + carH,
      const Radius.circular(16),
    ));
    canvas.drawPath(bodyPath, paint);
    canvas.drawPath(bodyPath, strokePaint);

    // Windshield
    final wshield = Paint()
      ..color = AppColors.accentBlue.withValues(alpha: 0.15)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromLTRBR(carLeft + 6, carTop + 8, carLeft + carW - 6, carTop + 30, const Radius.circular(6)),
      wshield,
    );

    // Sunroof
    if (!sunroofOpen) {
      canvas.drawRRect(
        RRect.fromLTRBR(
          carLeft + 8, carTop + 34, carLeft + carW - 8, carTop + 68,
          const Radius.circular(4),
        ),
        Paint()
          ..color = AppColors.surfaceHighlight
          ..style = PaintingStyle.fill,
      );
    }

    // Rear windshield
    canvas.drawRRect(
      RRect.fromLTRBR(
        carLeft + 6, carTop + carH - 28, carLeft + carW - 6, carTop + carH - 8,
        const Radius.circular(6),
      ),
      wshield,
    );

    // Center line
    canvas.drawLine(
      Offset(cx, carTop + 30),
      Offset(cx, carTop + carH - 30),
      Paint()
        ..color = AppColors.border
        ..strokeWidth = 0.5,
    );

    // Wheel arches
    final wheelPaint = Paint()
      ..color = AppColors.textTertiary
      ..style = PaintingStyle.fill;

    for (final (x, y) in [
      (carLeft - 5.0, carTop + 22.0),
      (carLeft + carW - 5.0, carTop + 22.0),
      (carLeft - 5.0, carTop + carH - 40.0),
      (carLeft + carW - 5.0, carTop + carH - 40.0),
    ]) {
      canvas.drawRRect(
        RRect.fromLTRBR(x, y, x + 10, y + 22, const Radius.circular(4)),
        wheelPaint,
      );
    }

    // Lock indicator
    if (locked) {
      final iconPaint = Paint()
        ..color = AppColors.success.withValues(alpha: 0.8)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5;
      canvas.drawCircle(
        Offset(cx, carTop + carH / 2),
        10,
        iconPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _BatteryCard extends StatelessWidget {
  final Vehicle vehicle;
  const _BatteryCard({required this.vehicle});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final pct = vehicle.batteryLevel;
    final color = pct > 0.5 ? AppColors.success : pct > 0.2 ? AppColors.warning : AppColors.error;

    return MBCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${(pct * 100).round()}%',
                        style: AppTypography.displayMedium.copyWith(color: color)),
                    Text(l10n.batteryLevel, style: AppTypography.bodyMedium),
                    const SizedBox(height: 4),
                    Text('${vehicle.rangeKm} km remaining range',
                        style: AppTypography.bodySmall),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Icon(Icons.ev_station, color: AppColors.textTertiary, size: 32),
                  const SizedBox(height: 4),
                  Text(l10n.notCharging, style: AppTypography.bodySmall),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: pct,
              minHeight: 6,
              backgroundColor: AppColors.surfaceHighlight,
              valueColor: AlwaysStoppedAnimation(color),
            ),
          ),
        ],
      ),
    );
  }
}

class _DoorsCard extends StatelessWidget {
  final Vehicle vehicle;
  const _DoorsCard({required this.vehicle});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final items = [
      (l10n.doorFrontLeft, vehicle.doorFrontLeft, Icons.door_front_door_outlined),
      (l10n.doorFrontRight, vehicle.doorFrontRight, Icons.door_front_door_outlined),
      (l10n.doorRearLeft, vehicle.doorRearLeft, Icons.door_sliding_outlined),
      (l10n.doorRearRight, vehicle.doorRearRight, Icons.door_sliding_outlined),
      (l10n.trunk, vehicle.trunk, Icons.drive_eta_outlined),
      (l10n.sunroof, vehicle.sunroof, Icons.wb_sunny_outlined),
    ];

    return MBCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: List.generate(items.length, (i) {
          final (label, isOpen, icon) = items[i];
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
                child: Row(
                  children: [
                    Icon(icon, size: 18, color: AppColors.textTertiary),
                    const SizedBox(width: 12),
                    Expanded(child: Text(label, style: AppTypography.bodyLarge)),
                    MBStatusChip(
                      label: isOpen ? l10n.doorOpen : l10n.doorClosed,
                      color: isOpen ? AppColors.error : AppColors.success,
                      backgroundColor: isOpen ? AppColors.errorDim : AppColors.successDim,
                    ),
                  ],
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

class _TirePressureCard extends StatelessWidget {
  final Vehicle vehicle;
  const _TirePressureCard({required this.vehicle});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return MBCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              _TireCell('FL', vehicle.tirePressure['frontLeft']!),
              const SizedBox(width: 16),
              _TireCell('FR', vehicle.tirePressure['frontRight']!),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _TireCell('RL', vehicle.tirePressure['rearLeft']!),
              const SizedBox(width: 16),
              _TireCell('RR', vehicle.tirePressure['rearRight']!),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.info_outline, size: 12, color: AppColors.textTertiary),
              const SizedBox(width: 6),
              Text(l10n.tirePressureRecommended, style: AppTypography.caption),
            ],
          ),
        ],
      ),
    );
  }
}

class _TireCell extends StatelessWidget {
  final String label;
  final double psi;
  const _TireCell(this.label, this.psi);

  @override
  Widget build(BuildContext context) {
    final isOk = psi >= 32 && psi <= 36;
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.surfaceRaised,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: AppTypography.labelLarge.copyWith(color: AppColors.textSecondary)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('${psi.toStringAsFixed(1)} psi',
                    style: AppTypography.headlineSmall.copyWith(fontSize: 15)),
                const SizedBox(height: 2),
                Icon(
                  isOk ? Icons.check_circle : Icons.warning_amber_outlined,
                  size: 12,
                  color: isOk ? AppColors.success : AppColors.warning,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MileageCard extends StatelessWidget {
  final Vehicle vehicle;
  const _MileageCard({required this.vehicle});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return MBCard(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _StatColumn(
            value: '${(vehicle.totalMileage / 1000).toStringAsFixed(1)}k km',
            label: l10n.totalMileage,
            icon: Icons.speed,
          ),
          Container(width: 1, height: 48, color: AppColors.divider),
          _StatColumn(
            value: '${vehicle.lastJourneyKm} km',
            label: l10n.lastJourney,
            icon: Icons.route_outlined,
          ),
          Container(width: 1, height: 48, color: AppColors.divider),
          _StatColumn(
            value: '${vehicle.lastJourneyTime.inMinutes}m',
            label: l10n.journeyTime,
            icon: Icons.timer_outlined,
          ),
        ],
      ),
    );
  }
}

class _StatColumn extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  const _StatColumn({required this.value, required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, size: 18, color: AppColors.textTertiary),
          const SizedBox(height: 6),
          Text(value, style: AppTypography.headlineSmall.copyWith(fontSize: 14)),
          const SizedBox(height: 2),
          Text(label, style: AppTypography.caption, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
