class FuelRecord {
  final int? id;
  final int vehicleId;
  final DateTime date;
  final String station;
  final String fuelType;
  final int mileage;
  final double liters;
  final double pricePerLiter;
  final double total;

  FuelRecord({
    this.id,
    required this.vehicleId,
    required this.date,
    required this.station,
    required this.fuelType,
    required this.mileage,
    required this.liters,
    required this.pricePerLiter,
    required this.total,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'vehicle_id': vehicleId,
      'date': date.toIso8601String(),
      'station': station,
      'fuel_type': fuelType,
      'mileage': mileage,
      'liters': liters,
      'price_per_liter': pricePerLiter,
      'total': total,
    };
  }

  factory FuelRecord.fromMap(Map<String, dynamic> map) {
    return FuelRecord(
      id: map['id'],
      vehicleId: map['vehicle_id'],
      date: DateTime.parse(map['date']),
      station: map['station'],
      fuelType: map['fuel_type'],
      mileage: map['mileage'],
      liters: (map['liters'] as num).toDouble(),
      pricePerLiter: (map['price_per_liter'] as num).toDouble(),
      total: (map['total'] as num).toDouble(),
    );
  }
}