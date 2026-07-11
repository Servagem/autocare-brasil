import '../../fuel/repositories/fuel_repository.dart';
import '../../vehicles/repositories/vehicle_repository.dart';

class DashboardRepository {
  DashboardRepository();

  final VehicleRepository vehicleRepository =
      VehicleRepository();

  final FuelRepository fuelRepository =
      FuelRepository();
}