import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/AppDatabase.dart';
import '../model/RevenueRecord.dart';

class RevenueStore extends StateNotifier<List<RevenueRecord>> {
  RevenueStore() : super(const []) {
    ready = _initializeAsync();
  }

  late Future<void> ready;

  Future<void> _initializeAsync() async {
    final data = await AppDatabase.instance.fetchRevenues();
    state = data ?? [];
  }

  Future<void> add(RevenueRecord record) async {
    await AppDatabase.instance.insertRevenue(record);
    final updated = await AppDatabase.instance.fetchRevenues();
    state = updated ?? [];
  }

  Future<void> update(RevenueRecord record) async {
    await AppDatabase.instance.updateRevenue(record);
    final updated = await AppDatabase.instance.fetchRevenues();
    state = updated ?? [];
  }

  Future<void> delete(String id) async {
    await AppDatabase.instance.deleteRevenue(id);
    final updated = await AppDatabase.instance.fetchRevenues();
    state = updated ?? [];
  }

  List<RevenueRecord> getByAnimal(String animalRef) {
    return state.where((r) => _matchesAnimalRef(animalRef, r.animalRef)).toList();
  }

  double getTotalByAnimal(String animalRef) {
    return getByAnimal(animalRef).fold<double>(0, (sum, r) => sum + r.netAmount);
  }

  bool _matchesAnimalRef(String animal, String rawRef) {
    final ref = rawRef.trim().toLowerCase();
    if (ref.isEmpty) return false;
    return animal.trim().toLowerCase().contains(ref) || ref.contains(animal.trim().toLowerCase());
  }
}

final revenueStoreProvider = StateNotifierProvider<RevenueStore, List<RevenueRecord>>(
  (ref) => RevenueStore(),
);

final revenueStoreReadyProvider = FutureProvider<void>((ref) async {
  await ref.watch(revenueStoreProvider.notifier).ready;
});
