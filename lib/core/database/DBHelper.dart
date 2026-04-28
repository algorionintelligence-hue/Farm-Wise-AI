import '../../features/HealthEvents/model/health_event_record.dart';
import '../../features/HerdForm/model/herd.dart';
import '../../features/RevenueForm/model/RevenueRecord.dart';
import '../../features/Vaccinations/model/vaccination_record.dart';

import 'AppDatabase.dart';

class DBHelper {
  DBHelper._();

  static final DBHelper instance = DBHelper._();

  Future<List<HerdInputModel>> getHerdRecords() {
    return AppDatabase.instance.fetchHerdRecords();
  }

  Future<void> saveHerdRecord(HerdInputModel animal) {
    return AppDatabase.instance.upsertHerdRecord(animal);
  }

  Future<List<HealthEventRecord>> getHealthEvents() {
    return AppDatabase.instance.fetchHealthEvents();
  }

  Future<void> saveHealthEvent(HealthEventRecord record) {
    return AppDatabase.instance.insertHealthEvent(record);
  }

  Future<List<VaccinationRecord>> getVaccinations() {
    return AppDatabase.instance.fetchVaccinations();
  }

  Future<void> saveVaccination(VaccinationRecord record) {
    return AppDatabase.instance.insertVaccination(record);
  }

  Future<List<RevenueRecord>?> getRevenues() {
    return AppDatabase.instance.fetchRevenues();
  }

  Future<void> saveRevenue(RevenueRecord record) {
    return AppDatabase.instance.insertRevenue(record);
  }

  Future<void> updateRevenue(RevenueRecord record) {
    return AppDatabase.instance.updateRevenue(record);
  }

  Future<void> deleteRevenue(String id) {
    return AppDatabase.instance.deleteRevenue(id);
  }
}
