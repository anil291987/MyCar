import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/vehicle.dart';
import '../../domain/repositories/vehicle_repository.dart';
import '../../domain/usecases/set_battery_level.dart';
import '../../domain/usecases/set_target_temp.dart';
import '../../domain/usecases/toggle_climate.dart';
import '../../domain/usecases/toggle_lock.dart';
import '../../domain/usecases/toggle_sunroof.dart';
import '../../domain/usecases/book_service_appointment.dart';
import '../../domain/usecases/update_vehicle_profile.dart';
import '../../domain/usecases/select_vehicle.dart';
import '../../domain/usecases/add_vehicle.dart';
import '../../domain/usecases/remove_vehicle.dart';

/// Cubit state is the *active* [Vehicle] entity — each mutation forwards to
/// a single use case, and the repository's own [Vehicle.copyWith] produces
/// a fresh instance so `emit` always registers as a change. [vehicles]
/// exposes the whole garage; it's a plain getter (not part of `state`)
/// since it's always read during a `build()` that's already watching this
/// cubit, so it's current whenever the widget rebuilds.
class VehicleCubit extends Cubit<Vehicle> {
  final VehicleRepository _repository;
  late final ToggleLock _toggleLock;
  late final SetTargetTemp _setTargetTemp;
  late final ToggleClimate _toggleClimate;
  late final SetBatteryLevel _setBatteryLevel;
  late final ToggleSunroof _toggleSunroof;
  late final BookServiceAppointment _bookServiceAppointment;
  late final UpdateVehicleProfile _updateVehicleProfile;
  late final SelectVehicle _selectVehicle;
  late final AddVehicle _addVehicle;
  late final RemoveVehicle _removeVehicle;

  VehicleCubit(this._repository) : super(_repository.vehicle) {
    _toggleLock = ToggleLock(_repository);
    _setTargetTemp = SetTargetTemp(_repository);
    _toggleClimate = ToggleClimate(_repository);
    _setBatteryLevel = SetBatteryLevel(_repository);
    _toggleSunroof = ToggleSunroof(_repository);
    _bookServiceAppointment = BookServiceAppointment(_repository);
    _updateVehicleProfile = UpdateVehicleProfile(_repository);
    _selectVehicle = SelectVehicle(_repository);
    _addVehicle = AddVehicle(_repository);
    _removeVehicle = RemoveVehicle(_repository);
    _repository.addListener(_onRepositoryChanged);
  }

  void _onRepositoryChanged() => emit(_repository.vehicle);

  List<Vehicle> get vehicles => _repository.vehicles;

  void toggleLock() => _toggleLock();
  void setTargetTemp(double temp) => _setTargetTemp(temp);
  void toggleClimate() => _toggleClimate();
  void setBatteryLevel(double level) => _setBatteryLevel(level);
  void toggleSunroof() => _toggleSunroof();
  void bookServiceAppointment(Map<String, dynamic> appointment) =>
      _bookServiceAppointment(appointment);
  void updateVehicleProfile({
    String? vehicleName,
    String? vehicleModel,
    String? licensePlate,
    String? vehicleVin,
  }) =>
      _updateVehicleProfile(
        vehicleName: vehicleName,
        vehicleModel: vehicleModel,
        licensePlate: licensePlate,
        vehicleVin: vehicleVin,
      );
  void selectVehicle(String id) => _selectVehicle(id);
  void addVehicle(Vehicle vehicle) => _addVehicle(vehicle);
  void removeVehicle(String id) => _removeVehicle(id);

  @override
  Future<void> close() {
    _repository.removeListener(_onRepositoryChanged);
    return super.close();
  }
}
