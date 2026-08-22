import '../repositories/vehicle_repository.dart';

class BookServiceAppointment {
  final VehicleRepository _repository;
  BookServiceAppointment(this._repository);

  void call(Map<String, dynamic> appointment) =>
      _repository.bookServiceAppointment(appointment);
}
