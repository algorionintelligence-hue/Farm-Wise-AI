import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

import '../../features/HealthEvents/model/health_event_record.dart';
import '../../features/HerdForm/model/herd.dart';
import '../../features/RevenueForm/model/revenue_record.dart';
import '../../features/Vaccinations/model/vaccination_record.dart';

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
      version: 4,
      onCreate: (db, version) async {
        await _createSchema(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await createHealthEventsTable(db);
          await createVaccinationsTable(db);
        }
        if (oldVersion < 3) {
          await createRevenuesTable(db);
        }
        if (oldVersion < 4) {
          await addHerdRecordColumnsV4(db);
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
        animal_name TEXT,
        animal_image_path TEXT,
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
    await createHealthEventsTable(db);
    await createVaccinationsTable(db);
    await createRevenuesTable(db);
  }

  Future<void> createHealthEventsTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS HealthEvents (
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

  Future<void> createVaccinationsTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS Vaccinations (
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

  Future<void> createRevenuesTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS revenues (
        id TEXT PRIMARY KEY,
        animal_ref TEXT NOT NULL,
        revenue_date TEXT NOT NULL,
        revenue_type TEXT NOT NULL,
        quantity REAL NOT NULL,
        unit_price REAL NOT NULL,
        commission REAL NOT NULL DEFAULT 0,
        net_amount REAL NOT NULL,
        notes TEXT
      )
    ''');
  }

  Future<void> addHerdRecordColumnsV4(Database db) async {
    await db.execute('ALTER TABLE herd_records ADD COLUMN animal_name TEXT');
    await db.execute('ALTER TABLE herd_records ADD COLUMN animal_image_path TEXT');
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
      'HealthEvents',
      orderBy: 'event_date DESC',
    );
    return rows.map(HealthEventRecord.fromMap).toList();
  }

  Future<void> insertHealthEvent(HealthEventRecord record) async {
    final db = await database;
    await db.insert(
      'HealthEvents',
      record.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<VaccinationRecord>> fetchVaccinations() async {
    final db = await database;
    final rows = await db.query(
      'Vaccinations',
      orderBy: 'date_given DESC',
    );
    return rows.map(VaccinationRecord.fromMap).toList();
  }

  Future<void> insertVaccination(VaccinationRecord record) async {
    final db = await database;
    await db.insert(
      'Vaccinations',
      record.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<RevenueRecord>?> fetchRevenues() async {
    try {
      final db = await database;
      final rows = await db.query(
        'revenues',
        orderBy: 'revenue_date DESC',
      );
      return rows.map(RevenueRecord.fromMap).toList();
    } catch (e) {
      return null;
    }
  }

  Future<void> insertRevenue(RevenueRecord record) async {
    final db = await database;
    await db.insert(
      'revenues',
      record.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateRevenue(RevenueRecord record) async {
    final db = await database;
    await db.update(
      'revenues',
      record.toMap(),
      where: 'id = ?',
      whereArgs: [record.id],
    );
  }

  Future<void> deleteRevenue(String id) async {
    final db = await database;
    await db.delete(
      'revenues',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
