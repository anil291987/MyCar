import '../repositories/vehicle_repository.dart';

class ToggleClimate {
  final VehicleRepository _repository;
  ToggleClimate(this._repository);

  void call() => _repository.toggleClimate();
}
