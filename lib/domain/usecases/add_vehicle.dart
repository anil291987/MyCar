import '../entities/vehicle.dart';
import '../repositories/vehicle_repository.dart';

class AddVehicle {
  final VehicleRepository _repository;
  AddVehicle(this._repository);

  void call(Vehicle vehicle) => _repository.addVehicle(vehicle);
}
