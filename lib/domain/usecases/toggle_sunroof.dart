import '../repositories/vehicle_repository.dart';

class ToggleSunroof {
  final VehicleRepository _repository;
  ToggleSunroof(this._repository);

  void call() => _repository.toggleSunroof();
}
