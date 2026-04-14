class HerdInputModel {
  final String? tagNumber;
  final String? animalId;
  final String? category;
  final String? gender;
  final String? stage;
  final String? breed;
  final double? weight;
  final DateTime? dateOfBirth;
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
  final String? entryType;
  final DateTime? entryDate;
  final double? purchasePrice;

  // ✅ Empty constructor — HerdViewModel() : super(HerdInputModel()) ke liye
  HerdInputModel({
    this.tagNumber,
    this.animalId,
    this.category,
    this.gender,
    this.stage,
    this.breed,
    this.weight,
    this.dateOfBirth,
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
    this.entryType,
    this.entryDate,
    this.purchasePrice,
  });

  // ✅ copyWith — refreshDates() ke liye zaroori
  HerdInputModel copyWith({
    String? tagNumber,
    String? animalId,
    String? category,
    String? gender,
    String? stage,
    String? breed,
    double? weight,
    DateTime? dateOfBirth,
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
    String? entryType,
    DateTime? entryDate,
    double? purchasePrice,
  }) {
    return HerdInputModel(
      tagNumber: tagNumber ?? this.tagNumber,
      animalId: animalId ?? this.animalId,
      category: category ?? this.category,
      gender: gender ?? this.gender,
      stage: stage ?? this.stage,
      breed: breed ?? this.breed,
      weight: weight ?? this.weight,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
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
      entryType: entryType ?? this.entryType,
      entryDate: entryDate ?? this.entryDate,
      purchasePrice: purchasePrice ?? this.purchasePrice,
    );
  }
}
