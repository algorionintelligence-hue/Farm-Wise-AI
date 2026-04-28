import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/database/AppDatabase.dart';
import '../HerdForm/model/herd.dart';
import '../HerdForm/viewmodel/HerdViewmodel.dart';


class HerdStore extends StateNotifier<List<HerdInputModel>> {
  HerdStore() : super(const []) {
    _loadFromDatabase();
  }

  final Completer<void> _readyCompleter = Completer<void>();

  Future<void> get ready => _readyCompleter.future;

  Future<void> _loadFromDatabase() async {
    try {
      state = await AppDatabase.instance.fetchHerdRecords();
    } finally {
      if (!_readyCompleter.isCompleted) {
        _readyCompleter.complete();
      }
    }
  }

  Future<void> upsert(HerdInputModel animal) async {
    final key = animal.recordKey;
    if (key.isEmpty) return;

    state = [
      for (final a in state)
        if (a.recordKey != key) a,
      animal,
    ]..sort((a, b) => _sortValue(a).compareTo(_sortValue(b)));

    await AppDatabase.instance.upsertHerdRecord(animal);
  }

  List<HerdInputModel> females() {
    return [
      for (final a in state)
        if (a.gender == GenderKey.female &&
            a.recordKey.isNotEmpty)
          a,
    ];
  }
}

final herdStoreProvider =
    StateNotifierProvider<HerdStore, List<HerdInputModel>>((ref) => HerdStore());

final herdStoreReadyProvider = FutureProvider<void>((ref) async {
  await ref.watch(herdStoreProvider.notifier).ready;
});

String _sortValue(HerdInputModel animal) {
  final tag = animal.tagNumber?.trim();
  if (tag != null && tag.isNotEmpty) return tag.toLowerCase();

  final id = animal.animalId?.trim();
  if (id != null && id.isNotEmpty) return id.toLowerCase();

  return '';
}

