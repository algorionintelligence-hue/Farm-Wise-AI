class HerdInputModel {
  final String animalId;
  final String category;
  final String stage;

  final double? weight;

  final DateTime? serviceDate;
  final DateTime? pdDate;
  final DateTime? calvingDate;

  final double? avgMilkPerDay;
  final double? milkSalePrice;
  final double? milkSoldPercentage;

  final double? feedCost;
  final double? medicalCost;
  final double? laborCost;

  final int expectedSaleAnimals;

  HerdInputModel({
    required this.animalId,
    required this.category,
    required this.stage,
    this.weight,
    this.serviceDate,
    this.pdDate,
    this.calvingDate,
    this.avgMilkPerDay,
    this.milkSalePrice,
    this.milkSoldPercentage,
    this.feedCost,
    this.medicalCost,
    this.laborCost,
    required this.expectedSaleAnimals,
  });
}