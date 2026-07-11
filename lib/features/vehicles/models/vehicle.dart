class Vehicle {
  final int? id;
  final String brand;
  final String model;
  final int year;
  final String plate;
  final String color;
  final int mileage;

  const Vehicle({
    this.id,
    required this.brand,
    required this.model,
    required this.year,
    required this.plate,
    required this.color,
    required this.mileage,
  });

  Vehicle copyWith({
    int? id,
    String? brand,
    String? model,
    int? year,
    String? plate,
    String? color,
    int? mileage,
  }) {
    return Vehicle(
      id: id ?? this.id,
      brand: brand ?? this.brand,
      model: model ?? this.model,
      year: year ?? this.year,
      plate: plate ?? this.plate,
      color: color ?? this.color,
      mileage: mileage ?? this.mileage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'brand': brand,
      'model': model,
      'year': year,
      'plate': plate,
      'color': color,
      'mileage': mileage,
    };
  }

  factory Vehicle.fromMap(Map<String, dynamic> map) {
    return Vehicle(
      id: map['id'] as int?,
      brand: map['brand'] as String,
      model: map['model'] as String,
      year: map['year'] as int,
      plate: map['plate'] as String,
      color: map['color'] as String,
      mileage: map['mileage'] as int,
    );
  }
}