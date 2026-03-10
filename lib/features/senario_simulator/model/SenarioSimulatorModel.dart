class ScenarioSimulatorModel {
  final double feedPrice;
  final double milkPrice;
  final double pregnancyRate;

  ScenarioSimulatorModel({
    this.feedPrice = 10,
    this.milkPrice = -5,
    this.pregnancyRate = 10,
  });

  ScenarioSimulatorModel copyWith({
    double? feedPrice,
    double? milkPrice,
    double? pregnancyRate,
  }) {
    return ScenarioSimulatorModel(
      feedPrice: feedPrice ?? this.feedPrice,
      milkPrice: milkPrice ?? this.milkPrice,
      pregnancyRate: pregnancyRate ?? this.pregnancyRate,
    );
  }
}
