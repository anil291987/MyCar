import '../repositories/vehicle_repository.dart';

class UpdateVehicleProfile {
  final VehicleRepository _repository;
  UpdateVehicleProfile(this._repository);

  void call({
    String? vehicleName,
    String? vehicleModel,
    String? licensePlate,
    String? vehicleVin,
  }) =>
      _repository.updateVehicleProfile(
        vehicleName: vehicleName,
        vehicleModel: vehicleModel,
        licensePlate: licensePlate,
        vehicleVin: vehicleVin,
      );
}
