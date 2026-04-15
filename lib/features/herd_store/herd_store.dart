import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../herd_form/model/herd.dart';
import '../herd_form/viewmodel/herd_viewmodel.dart';

class HerdStore extends StateNotifier<List<HerdInputModel>> {
  HerdStore() : super(const []);

  void upsert(HerdInputModel animal) {
    final id = animal.animalId?.trim();
    if (id == null || id.isEmpty) return;

    // Keep only one record per animalId (uuid).
    state = [
      for (final a in state)
        if (a.animalId?.trim() != id) a,
      animal,
    ];
  }

  List<HerdInputModel> females() {
    return [
      for (final a in state)
        if (a.gender == GenderKey.female &&
            (a.animalId?.trim().isNotEmpty ?? false))
          a,
    ];
  }
}

final herdStoreProvider =
    StateNotifierProvider<HerdStore, List<HerdInputModel>>((ref) => HerdStore());

