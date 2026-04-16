import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

import '../../features/herd_form/model/herd.dart';
import '../../features/health_events/model/health_event_record.dart';
import '../../features/vaccinations/model/vaccination_record.dart';

class AppDatabase {
  AppDatabase._();

  static final AppDatabase instance = AppDatabase._();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _openDatabase();
    return _database!;
  }

  Future<Database> _openDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = p.join(databasesPath, 'farm_wise_ai.db');

    return openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await _createSchema(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await _createHealthEventsTable(db);
          await _createVaccinationsTable(db);
        }
      },
    );
  }

  Future<void> _createSchema(Database db) async {
    await db.execute('''
      CREATE TABLE herd_records (
        record_key TEXT PRIMARY KEY,
        tag_number TEXT,
        animal_id TEXT,
        category TEXT,
        gender TEXT,
        stage TEXT,
        breed TEXT,
        weight REAL,
        date_of_birth TEXT,
        service_date TEXT,
        pd_date TEXT,
        calving_date TEXT,
        avg_milk_per_day REAL,
        milk_sale_price REAL,
        milk_sold_percentage REAL,
        feed_cost REAL,
        medical_cost REAL,
        labor_cost REAL,
        expected_sale_animals INTEGER NOT NULL DEFAULT 0,
        entry_type TEXT,
        entry_date TEXT,
        purchase_price REAL
      )
    ''');
    await _createHealthEventsTable(db);
    await _createVaccinationsTable(db);
  }

  Future<void> _createHealthEventsTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS health_events (
        id TEXT PRIMARY KEY,
        animal_ref TEXT NOT NULL,
        event_date TEXT NOT NULL,
        event_type TEXT NOT NULL,
        diagnosis TEXT,
        vet_name TEXT,
        vet_fee REAL NOT NULL DEFAULT 0,
        medicine_cost REAL NOT NULL DEFAULT 0,
        notes TEXT
      )
    ''');
  }

  Future<void> _createVaccinationsTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS vaccinations (
        id TEXT PRIMARY KEY,
        animal_ref TEXT NOT NULL,
        vaccine_name TEXT NOT NULL,
        date_given TEXT NOT NULL,
        next_due_date TEXT,
        cost REAL NOT NULL DEFAULT 0,
        batch_number TEXT
      )
    ''');
  }

  Future<List<HerdInputModel>> fetchHerdRecords() async {
    final db = await database;
    final rows = await db.query(
      'herd_records',
      orderBy: 'tag_number COLLATE NOCASE ASC, animal_id COLLATE NOCASE ASC',
    );
    return rows.map(HerdInputModel.fromMap).toList();
  }

  Future<void> upsertHerdRecord(HerdInputModel animal) async {
    final key = animal.recordKey;
    if (key.isEmpty) return;

    final db = await database;
    await db.insert(
      'herd_records',
      animal.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<HealthEventRecord>> fetchHealthEvents() async {
    final db = await database;
    final rows = await db.query(
      'health_events',
      orderBy: 'event_date DESC',
    );
    return rows.map(HealthEventRecord.fromMap).toList();
  }

  Future<void> insertHealthEvent(HealthEventRecord record) async {
    final db = await database;
    await db.insert(
      'health_events',
      record.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<VaccinationRecord>> fetchVaccinations() async {
    final db = await database;
    final rows = await db.query(
      'vaccinations',
      orderBy: 'date_given DESC',
    );
    return rows.map(VaccinationRecord.fromMap).toList();
  }

  Future<void> insertVaccination(VaccinationRecord record) async {
    final db = await database;
    await db.insert(
      'vaccinations',
      record.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
