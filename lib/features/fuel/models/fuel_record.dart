class FuelRecord {
  final int? id;
  final int vehicleId;
  final String date;
  final String fuelType;
  final double liters;
  final double totalValue;
  final int odometer;
  final String? station;
  final String? notes;

  FuelRecord({
    this.id,
    required this.vehicleId,
    required this.date,
    required this.fuelType,
    required this.liters,
    required this.totalValue,
    required this.odometer,
    this.station,
    this.notes,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'vehicle_id': vehicleId,
      'date': date,
      'fuel_type': fuelType,
      'liters': liters,
      'total_value': totalValue,
      'odometer': odometer,
      'station': station,
      'notes': notes,
    };
  }

  factory FuelRecord.fromMap(Map<String, dynamic> map) {
    return FuelRecord(
      id: map['id'],
      vehicleId: map['vehicle_id'],
      date: map['date'],
      fuelType: map['fuel_type'],
      liters: map['liters'].toDouble(),
      totalValue: map['total_value'].toDouble(),
      odometer: map['odometer'],
      station: map['station'],
      notes: map['notes'],
    );
  }
}