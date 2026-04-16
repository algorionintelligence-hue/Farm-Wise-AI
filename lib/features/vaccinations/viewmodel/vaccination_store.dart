import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../model/vaccination_record.dart';

class VaccinationStore extends StateNotifier<List<VaccinationRecord>> {
  VaccinationStore() : super(const []) {
    _load();
  }

  final Completer<void> _readyCompleter = Completer<void>();

  Future<void> get ready => _readyCompleter.future;

  Future<void> _load() async {
    try {
      state = await AppDatabase.instance.fetchVaccinations();
    } finally {
      if (!_readyCompleter.isCompleted) {
        _readyCompleter.complete();
      }
    }
  }

  Future<void> add(VaccinationRecord record) async {
    state = [record, ...state];
    await AppDatabase.instance.insertVaccination(record);
  }
}

final vaccinationStoreProvider =
    StateNotifierProvider<VaccinationStore, List<VaccinationRecord>>(
  (ref) => VaccinationStore(),
);

final vaccinationStoreReadyProvider = FutureProvider<void>((ref) async {
  await ref.watch(vaccinationStoreProvider.notifier).ready;
});
