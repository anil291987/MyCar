import '../repositories/vehicle_repository.dart';

class SelectVehicle {
  final VehicleRepository _repository;
  SelectVehicle(this._repository);

  void call(String id) => _repository.selectVehicle(id);
}
