import '../repositories/vehicle_repository.dart';

class ToggleLock {
  final VehicleRepository _repository;
  ToggleLock(this._repository);

  void call() => _repository.toggleLock();
}
