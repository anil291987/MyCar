import 'package:flutter/foundation.dart';
import '../entities/vehicle.dart';

/// Source of truth for vehicle data and the mutations the app can perform
/// on it. `Listenable` so the presentation layer can react to changes
/// without depending on a concrete implementation.
///
/// A user can own more than one vehicle: [vehicles] is the full garage,
/// [vehicle] is whichever one is currently selected, and every mutation
/// method (toggleLock, setTargetTemp, ...) applies only to that selected
/// vehicle.
abstract class VehicleRepository implements Listenable {
  Vehicle get vehicle;
  List<Vehicle> get vehicles;

  void selectVehicle(String id);
  void addVehicle(Vehicle vehicle);
  void removeVehicle(String id);

  void toggleLock();
  void setTargetTemp(double temp);
  void toggleClimate();
  void setBatteryLevel(double level);
  void toggleSunroof();
  void bookServiceAppointment(Map<String, dynamic> appointment);
  void updateVehicleProfile({
    String? vehicleName,
    String? vehicleModel,
    String? licensePlate,
    String? vehicleVin,
  });
}
