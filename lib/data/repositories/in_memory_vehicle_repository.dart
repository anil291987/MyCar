import 'package:flutter/foundation.dart';
import '../../domain/entities/vehicle.dart';
import '../../domain/repositories/vehicle_repository.dart';

/// In-memory mock implementation — mirrors the app's original mocked
/// data exactly, just moved behind the [VehicleRepository] interface.
///
/// Seeded with two vehicles so garage-switching has something to
/// demonstrate; every mutation method targets whichever vehicle is
/// currently selected ([_selectedId]), replacing it in [_vehicles] by id.
class InMemoryVehicleRepository extends ChangeNotifier
    implements VehicleRepository {
  List<Vehicle> _vehicles = [Vehicle.mock(), Vehicle.mockSecondary()];
  String _selectedId = 'v1';

  @override
  Vehicle get vehicle =>
      _vehicles.firstWhere((v) => v.id == _selectedId, orElse: () => _vehicles.first);

  @override
  List<Vehicle> get vehicles => _vehicles;

  void _updateSelected(Vehicle Function(Vehicle current) update) {
    _vehicles = [
      for (final v in _vehicles)
        if (v.id == _selectedId) update(v) else v,
    ];
    notifyListeners();
  }

  @override
  void selectVehicle(String id) {
    if (_selectedId == id || !_vehicles.any((v) => v.id == id)) return;
    _selectedId = id;
    notifyListeners();
  }

  @override
  void addVehicle(Vehicle vehicle) {
    _vehicles = [..._vehicles, vehicle];
    _selectedId = vehicle.id;
    notifyListeners();
  }

  @override
  void removeVehicle(String id) {
    if (_vehicles.length <= 1) return;
    _vehicles = _vehicles.where((v) => v.id != id).toList();
    if (_selectedId == id) _selectedId = _vehicles.first.id;
    notifyListeners();
  }

  @override
  void toggleLock() {
    _updateSelected((v) => v.copyWith(isLocked: !v.isLocked));
  }

  @override
  void setTargetTemp(double temp) {
    _updateSelected((v) => v.copyWith(targetTemp: temp));
  }

  @override
  void toggleClimate() {
    _updateSelected((v) => v.copyWith(climateActive: !v.climateActive));
  }

  @override
  void setBatteryLevel(double level) {
    _updateSelected((v) => v.copyWith(
          batteryLevel: level,
          rangeKm: (level * 540).round(),
        ));
  }

  @override
  void toggleSunroof() {
    _updateSelected((v) => v.copyWith(sunroof: !v.sunroof));
  }

  @override
  void bookServiceAppointment(Map<String, dynamic> appointment) {
    _updateSelected((v) => v.copyWith(
          serviceAppointments: [...v.serviceAppointments, appointment],
        ));
  }

  @override
  void updateVehicleProfile({
    String? vehicleName,
    String? vehicleModel,
    String? licensePlate,
    String? vehicleVin,
  }) {
    _updateSelected((v) => v.copyWith(
          vehicleName: vehicleName,
          vehicleModel: vehicleModel,
          licensePlate: licensePlate,
          vehicleVin: vehicleVin,
        ));
  }
}
