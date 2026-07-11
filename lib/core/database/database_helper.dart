import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._();

  DatabaseHelper._();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();

    return openDatabase(
      join(dbPath, 'autocare_brasil.db'),
      version: 2,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await _createVehiclesTable(db);
    await _createFuelTable(db);
  }

  Future<void> _onUpgrade(
    Database db,
    int oldVersion,
    int newVersion,
  ) async {
    if (oldVersion < 2) {
      await _createFuelTable(db);
    }
  }

  Future<void> _createVehiclesTable(Database db) async {
    await db.execute('''
      CREATE TABLE vehicles(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        brand TEXT NOT NULL,
        model TEXT NOT NULL,
        year INTEGER NOT NULL,
        plate TEXT NOT NULL,
        color TEXT NOT NULL,
        mileage INTEGER NOT NULL
      )
    ''');
  }

  Future<void> _createFuelTable(Database db) async {
    await db.execute('''
      CREATE TABLE fuel_records(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        vehicle_id INTEGER NOT NULL,
        date TEXT NOT NULL,
        fuel_type TEXT NOT NULL,
        liters REAL NOT NULL,
        total_value REAL NOT NULL,
        odometer INTEGER NOT NULL,
        station TEXT,
        notes TEXT,
        FOREIGN KEY(vehicle_id) REFERENCES vehicles(id)
      )
    ''');
  }
}