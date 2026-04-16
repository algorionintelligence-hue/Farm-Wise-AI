import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../model/health_event_record.dart';

class HealthEventStore extends StateNotifier<List<HealthEventRecord>> {
  HealthEventStore() : super(const []) {
    _load();
  }

  final Completer<void> _readyCompleter = Completer<void>();

  Future<void> get ready => _readyCompleter.future;

  Future<void> _load() async {
    try {
      state = await AppDatabase.instance.fetchHealthEvents();
    } finally {
      if (!_readyCompleter.isCompleted) {
        _readyCompleter.complete();
      }
    }
  }

  Future<void> add(HealthEventRecord record) async {
    state = [record, ...state];
    await AppDatabase.instance.insertHealthEvent(record);
  }
}

final healthEventStoreProvider =
    StateNotifierProvider<HealthEventStore, List<HealthEventRecord>>(
  (ref) => HealthEventStore(),
);

final healthEventStoreReadyProvider = FutureProvider<void>((ref) async {
  await ref.watch(healthEventStoreProvider.notifier).ready;
});
