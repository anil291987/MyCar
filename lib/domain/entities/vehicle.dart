/// The vehicle being monitored/controlled by the app. A straight
/// extraction of the app's mocked vehicle data into the domain layer —
/// fields mirror what the UI already displays, not a redesign.
///
/// Immutable ([copyWith] produces a new instance for each mutation) so
/// that [VehicleCubit] emits a distinct object every time — Cubit/Bloc
/// skip an `emit` when the new state is `==` to the current one, which
/// for a plain class means reference identity.
class Vehicle {
  // Identity — stable across edits, used to pick the active vehicle out of
  // [VehicleRepository.vehicles].
  final String id;

  // Vehicle info
  final String vehicleName;
  final String vehicleModel;
  final String licensePlate;
  final String vehicleVin;

  // Battery / Range
  final double batteryLevel;
  final int rangeKm;

  // Door & Lock Status
  final bool isLocked;
  final bool doorFrontLeft;
  final bool doorFrontRight;
  final bool doorRearLeft;
  final bool doorRearRight;
  final bool sunroof;
  final bool trunk;

  // Climate
  final double targetTemp;
  final bool climateActive;

  // Tire pressure (psi)
  final Map<String, double> tirePressure;

  // Mileage
  final int totalMileage;
  final double lastJourneyKm;
  final Duration lastJourneyTime;

  // Service appointments (title/date/dealer/status)
  final List<Map<String, dynamic>> serviceAppointments;

  Vehicle({
    required this.id,
    required this.vehicleName,
    required this.vehicleModel,
    required this.licensePlate,
    required this.vehicleVin,
    required this.batteryLevel,
    required this.rangeKm,
    required this.isLocked,
    required this.doorFrontLeft,
    required this.doorFrontRight,
    required this.doorRearLeft,
    required this.doorRearRight,
    required this.sunroof,
    required this.trunk,
    required this.targetTemp,
    required this.climateActive,
    required this.tirePressure,
    required this.totalMileage,
    required this.lastJourneyKm,
    required this.lastJourneyTime,
    required this.serviceAppointments,
  });

  Vehicle copyWith({
    String? vehicleName,
    String? vehicleModel,
    String? licensePlate,
    String? vehicleVin,
    double? batteryLevel,
    int? rangeKm,
    bool? isLocked,
    double? targetTemp,
    bool? climateActive,
    bool? sunroof,
    List<Map<String, dynamic>>? serviceAppointments,
  }) {
    return Vehicle(
      id: id,
      vehicleName: vehicleName ?? this.vehicleName,
      vehicleModel: vehicleModel ?? this.vehicleModel,
      licensePlate: licensePlate ?? this.licensePlate,
      vehicleVin: vehicleVin ?? this.vehicleVin,
      batteryLevel: batteryLevel ?? this.batteryLevel,
      rangeKm: rangeKm ?? this.rangeKm,
      isLocked: isLocked ?? this.isLocked,
      doorFrontLeft: doorFrontLeft,
      doorFrontRight: doorFrontRight,
      doorRearLeft: doorRearLeft,
      doorRearRight: doorRearRight,
      sunroof: sunroof ?? this.sunroof,
      trunk: trunk,
      targetTemp: targetTemp ?? this.targetTemp,
      climateActive: climateActive ?? this.climateActive,
      tirePressure: tirePressure,
      totalMileage: totalMileage,
      lastJourneyKm: lastJourneyKm,
      lastJourneyTime: lastJourneyTime,
      serviceAppointments: serviceAppointments ?? this.serviceAppointments,
    );
  }

  factory Vehicle.mock({String id = 'v1'}) => Vehicle(
        id: id,
        vehicleName: 'EQS 580 4MATIC',
        vehicleModel: 'Mercedes-Benz',
        licensePlate: 'MH 02 AB 1234',
        vehicleVin: 'W1K2976231A123456',
        batteryLevel: 0.78,
        rangeKm: 420,
        isLocked: true,
        doorFrontLeft: false,
        doorFrontRight: false,
        doorRearLeft: false,
        doorRearRight: false,
        sunroof: false,
        trunk: false,
        targetTemp: 22.0,
        climateActive: false,
        tirePressure: {
          'frontLeft': 34.2,
          'frontRight': 33.8,
          'rearLeft': 34.0,
          'rearRight': 33.5,
        },
        totalMileage: 12450,
        lastJourneyKm: 28.4,
        lastJourneyTime: const Duration(minutes: 42),
        serviceAppointments: [
          {
            'title': 'Annual Service',
            'date': '2026-09-15',
            'dealer': 'Westside Auto Care, Mumbai',
            'status': 'upcoming',
          },
          {
            'title': 'Tire Rotation',
            'date': '2026-10-01',
            'dealer': 'City Auto Service Center, Thane',
            'status': 'upcoming',
          },
        ],
      );

  /// A second seed vehicle so multi-vehicle switching has something to
  /// demonstrate out of the box.
  factory Vehicle.mockSecondary({String id = 'v2'}) => Vehicle(
        id: id,
        vehicleName: 'Model 3',
        vehicleModel: 'Tesla',
        licensePlate: 'MH 04 CD 5678',
        vehicleVin: '5YJ3E1EA0PF000001',
        batteryLevel: 0.62,
        rangeKm: 340,
        isLocked: true,
        doorFrontLeft: false,
        doorFrontRight: false,
        doorRearLeft: false,
        doorRearRight: false,
        sunroof: false,
        trunk: false,
        targetTemp: 21.0,
        climateActive: false,
        tirePressure: {
          'frontLeft': 42.0,
          'frontRight': 42.0,
          'rearLeft': 42.0,
          'rearRight': 42.0,
        },
        totalMileage: 5310,
        lastJourneyKm: 14.2,
        lastJourneyTime: const Duration(minutes: 22),
        serviceAppointments: const [],
      );
}
