import '../models/dashboard_data.dart';
import '../repositories/dashboard_repository.dart';

class DashboardService {
  DashboardService(this.repository);

  final DashboardRepository repository;

  Future<DashboardData> loadDashboard() async {
    final vehicles = await repository.vehicleRepository.getAll();

    if (vehicles.isEmpty) {
      return const DashboardData(
        totalVehicles: 0,
        totalRefuels: 0,
        totalSpent: 0,
        averageConsumption: 0,
        vehicleName: "Nenhum veículo",
        plate: "--",
        lastFuelDate: "--",
        nextMaintenanceKm: 0,
      );
    }

    final vehicle = vehicles.first;

    final fuels =
        await repository.fuelRepository.getByVehicle(vehicle.id!);

    double totalSpent = 0;
    double averageConsumption = 0;

    String lastFuelDate = "--";

    for (final fuel in fuels) {
      totalSpent += fuel.total;
    }

    if (fuels.isNotEmpty) {
      final last = fuels.first;

      lastFuelDate =
          "${last.date.day.toString().padLeft(2, '0')}/"
          "${last.date.month.toString().padLeft(2, '0')}/"
          "${last.date.year}";
    }

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

    return DashboardData(
      totalVehicles: vehicles.length,
      totalRefuels: fuels.length,
      totalSpent: totalSpent,
      averageConsumption: averageConsumption,
      vehicleName: "${vehicle.brand} ${vehicle.model}",
      plate: vehicle.plate,
      lastFuelDate: lastFuelDate,
      nextMaintenanceKm: vehicle.mileage + 10000,
    );
  }
}