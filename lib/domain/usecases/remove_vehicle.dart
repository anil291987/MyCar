import '../repositories/vehicle_repository.dart';

class RemoveVehicle {
  final VehicleRepository _repository;
  RemoveVehicle(this._repository);

  void call(String id) => _repository.removeVehicle(id);
}
