import 'package:autocare_brasil/core/database/database_helper.dart';
import 'package:autocare_brasil/features/vehicles/models/vehicle.dart';

class VehicleRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  Future<int> insert(Vehicle vehicle) async {
    final db = await _databaseHelper.database;

    return await db.insert(
      'vehicles',
      vehicle.toMap(),
    );
  }

  Future<List<Vehicle>> getAll() async {
    final db = await _databaseHelper.database;

    final result = await db.query('vehicles');

    return result.map((e) => Vehicle.fromMap(e)).toList();
  }

  Future<int> update(Vehicle vehicle) async {
    final db = await _databaseHelper.database;

    return await db.update(
      'vehicles',
      vehicle.toMap(),
      where: 'id = ?',
      whereArgs: [vehicle.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await _databaseHelper.database;

    return await db.delete(
      'vehicles',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}