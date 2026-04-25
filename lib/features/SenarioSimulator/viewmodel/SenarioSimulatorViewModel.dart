import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Model/SenarioSimulatorModel.dart';


final scenarioProvider =
StateNotifierProvider<ScenarioSimulatorViewModel, ScenarioSimulatorModel>(
      (ref) => ScenarioSimulatorViewModel(),
);

class ScenarioSimulatorViewModel extends StateNotifier<ScenarioSimulatorModel> {
  ScenarioSimulatorViewModel() : super(ScenarioSimulatorModel());

  void updateFeed(double value) {
    state = state.copyWith(feedPrice: value);
  }

  void updateMilk(double value) {
    state = state.copyWith(milkPrice: value);
  }

  void updatePregnancy(double value) {
    state = state.copyWith(pregnancyRate: value);
  }

  double get calculatedProfit {
    double baseProfit = 300000;

    return baseProfit +
        (state.milkPrice * 2000) +
        (state.pregnancyRate * 1500) -
        (state.feedPrice * 1000);
  }
}
