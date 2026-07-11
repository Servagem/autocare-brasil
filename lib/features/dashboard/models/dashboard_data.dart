class DashboardData {
  final String vehicleName;
  final String plate;
  final double monthlyExpense;
  final double averageConsumption;
  final String lastFuelDate;
  final int nextMaintenanceKm;

  const DashboardData({
    required this.vehicleName,
    required this.plate,
    required this.monthlyExpense,
    required this.averageConsumption,
    required this.lastFuelDate,
    required this.nextMaintenanceKm,
  });
}