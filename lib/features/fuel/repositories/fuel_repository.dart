import 'package:autocare_brasil/core/database/database_helper.dart';
import '../models/fuel_record.dart';

class FuelRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  Future<int> insert(FuelRecord record) async {
    final db = await _databaseHelper.database;

    return await db.insert(
      'fuel_records',
      record.toMap(),
    );
  }

  Future<List<FuelRecord>> getAll() async {
    final db = await _databaseHelper.database;

    final result = await db.query(
      'fuel_records',
      orderBy: 'date DESC',
    );

    return result.map((e) => FuelRecord.fromMap(e)).toList();
  }

  Future<List<FuelRecord>> getByVehicle(int vehicleId) async {
    final db = await _databaseHelper.database;

    final result = await db.query(
      'fuel_records',
      where: 'vehicle_id = ?',
      whereArgs: [vehicleId],
      orderBy: 'date DESC',
    );

    return result.map((e) => FuelRecord.fromMap(e)).toList();
  }

  Future<FuelRecord?> getLastFuel(int vehicleId) async {
    final db = await _databaseHelper.database;

    final result = await db.query(
      'fuel_records',
      where: 'vehicle_id = ?',
      whereArgs: [vehicleId],
      orderBy: 'date DESC',
      limit: 1,
    );

    if (result.isEmpty) return null;

    return FuelRecord.fromMap(result.first);
  }

  Future<int> update(FuelRecord record) async {
    final db = await _databaseHelper.database;

    return await db.update(
      'fuel_records',
      record.toMap(),
      where: 'id = ?',
      whereArgs: [record.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await _databaseHelper.database;

    return await db.delete(
      'fuel_records',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}