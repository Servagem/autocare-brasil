class DashboardData {
  final int totalVehicles;
  final int totalRefuels;
  final double totalSpent;
  final double averageConsumption;

  final String vehicleName;
  final String plate;

  final String lastFuelDate;
  final int nextMaintenanceKm;

  const DashboardData({
    required this.totalVehicles,
    required this.totalRefuels,
    required this.totalSpent,
    required this.averageConsumption,
    required this.vehicleName,
    required this.plate,
    required this.lastFuelDate,
    required this.nextMaintenanceKm,
  });
}