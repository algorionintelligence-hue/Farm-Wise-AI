import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/AppDatabase.dart';
import '../model/vaccination_record.dart';

class VaccinationRecordsNotifier
    extends StateNotifier<List<VaccinationRecord>> {
  VaccinationRecordsNotifier() : super(const []) {
    _loadVaccinationRecords();
  }

  final Completer<void> _recordsLoadedCompleter = Completer<void>();

  Future<void> get recordsLoaded => _recordsLoadedCompleter.future;

  Future<void> _loadVaccinationRecords() async {
    try {
      state = await AppDatabase.instance.fetchVaccinations();
    } finally {
      if (!_recordsLoadedCompleter.isCompleted) {
        _recordsLoadedCompleter.complete();
      }
    }
  }

  Future<void> addVaccinationRecord(VaccinationRecord vaccinationRecord) async {
    state = [vaccinationRecord, ...state];
    await AppDatabase.instance.insertVaccination(vaccinationRecord);
  }
}

final vaccinationRecordsProvider = StateNotifierProvider<
  VaccinationRecordsNotifier,
  List<VaccinationRecord>
>(
  (ref) => VaccinationRecordsNotifier(),
);

final vaccinationRecordsLoadedProvider = FutureProvider<void>((ref) async {
  await ref.watch(vaccinationRecordsProvider.notifier).recordsLoaded;
});
