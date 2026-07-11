import '../../fuel/repositories/fuel_repository.dart';
import '../../vehicles/repositories/vehicle_repository.dart';
import '../models/dashboard_data.dart';

class DashboardService {
  final VehicleRepository _vehicleRepository = VehicleRepository();
  final FuelRepository _fuelRepository = FuelRepository();

  Future<DashboardData> loadDashboard() async {
    final vehicles = await _vehicleRepository.getAll();

    if (vehicles.isEmpty) {
      return const DashboardData(
        vehicleName: "Nenhum veículo",
        plate: "--",
        monthlyExpense: 0,
        averageConsumption: 0,
        lastFuelDate: "--",
        nextMaintenanceKm: 0,
      );
    }

    final vehicle = vehicles.first;

    final fuels = await _fuelRepository.getByVehicle(vehicle.id!);

    double monthlyExpense = 0;
    double averageConsumption = 0;
    String lastFuelDate = "--";

    if (fuels.isNotEmpty) {
      final now = DateTime.now();

      // Soma dos abastecimentos do mês
      for (final fuel in fuels) {
        if (fuel.date.month == now.month &&
            fuel.date.year == now.year) {
          monthlyExpense += fuel.total;
        }
      }

      // Último abastecimento
      lastFuelDate =
          "${fuels.first.date.day.toString().padLeft(2, '0')}/"
          "${fuels.first.date.month.toString().padLeft(2, '0')}/"
          "${fuels.first.date.year}";

      // Consumo médio (km/L)
      if (fuels.length >= 2) {
        double totalKm = 0;
        double totalLiters = 0;

        for (int i = 0; i < fuels.length - 1; i++) {
          totalKm +=
              (fuels[i].mileage - fuels[i + 1].mileage).abs();

          totalLiters += fuels[i].liters;
        }

        if (totalLiters > 0) {
          averageConsumption = totalKm / totalLiters;
        }
      }
    }

    return DashboardData(
      vehicleName: "${vehicle.brand} ${vehicle.model}",
      plate: vehicle.plate,
      monthlyExpense: monthlyExpense,
      averageConsumption: averageConsumption,
      lastFuelDate: lastFuelDate,
      nextMaintenanceKm: vehicle.mileage + 10000,
    );
  }
}