import '../repositories/vehicle_repository.dart';

class SetBatteryLevel {
  final VehicleRepository _repository;
  SetBatteryLevel(this._repository);

  void call(double level) => _repository.setBatteryLevel(level);
}
