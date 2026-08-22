import '../repositories/vehicle_repository.dart';

class SetTargetTemp {
  final VehicleRepository _repository;
  SetTargetTemp(this._repository);

  void call(double temp) => _repository.setTargetTemp(temp);
}
