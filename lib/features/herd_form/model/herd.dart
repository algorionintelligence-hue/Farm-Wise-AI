class HerdInputModel {
  final String? animalId;
  final String? category;
  final String? stage;
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

  // ✅ Empty constructor — HerdViewModel() : super(HerdInputModel()) ke liye
  HerdInputModel({
    this.animalId,
    this.category,
    this.stage,
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
    this.expectedSaleAnimals = 0,
  });

  // ✅ copyWith — refreshDates() ke liye zaroori
  HerdInputModel copyWith({
    String? animalId,
    String? category,
    String? stage,
    double? weight,
    DateTime? serviceDate,
    DateTime? pdDate,
    DateTime? calvingDate,
    double? avgMilkPerDay,
    double? milkSalePrice,
    double? milkSoldPercentage,
    double? feedCost,
    double? medicalCost,
    double? laborCost,
    int? expectedSaleAnimals,
  }) {
    return HerdInputModel(
      animalId: animalId ?? this.animalId,
      category: category ?? this.category,
      stage: stage ?? this.stage,
      weight: weight ?? this.weight,
      serviceDate: serviceDate ?? this.serviceDate,
      pdDate: pdDate ?? this.pdDate,
      calvingDate: calvingDate ?? this.calvingDate,
      avgMilkPerDay: avgMilkPerDay ?? this.avgMilkPerDay,
      milkSalePrice: milkSalePrice ?? this.milkSalePrice,
      milkSoldPercentage: milkSoldPercentage ?? this.milkSoldPercentage,
      feedCost: feedCost ?? this.feedCost,
      medicalCost: medicalCost ?? this.medicalCost,
      laborCost: laborCost ?? this.laborCost,
      expectedSaleAnimals: expectedSaleAnimals ?? this.expectedSaleAnimals,
    );
  }
}