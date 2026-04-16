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

  String get recordKey {
    final id = animalId?.trim();
    if (id != null && id.isNotEmpty) return id;

    final tag = tagNumber?.trim();
    if (tag != null && tag.isNotEmpty) return tag;

    return '';
  }

  Map<String, Object?> toMap() {
    return {
      'record_key': recordKey,
      'tag_number': _cleanText(tagNumber),
      'animal_id': _cleanText(animalId),
      'category': _cleanText(category),
      'gender': _cleanText(gender),
      'stage': _cleanText(stage),
      'breed': _cleanText(breed),
      'weight': weight,
      'date_of_birth': _dateToIso(dateOfBirth),
      'service_date': _dateToIso(serviceDate),
      'pd_date': _dateToIso(pdDate),
      'calving_date': _dateToIso(calvingDate),
      'avg_milk_per_day': avgMilkPerDay,
      'milk_sale_price': milkSalePrice,
      'milk_sold_percentage': milkSoldPercentage,
      'feed_cost': feedCost,
      'medical_cost': medicalCost,
      'labor_cost': laborCost,
      'expected_sale_animals': expectedSaleAnimals,
      'entry_type': _cleanText(entryType),
      'entry_date': _dateToIso(entryDate),
      'purchase_price': purchasePrice,
    };
  }

  factory HerdInputModel.fromMap(Map<String, Object?> map) {
    return HerdInputModel(
      tagNumber: map['tag_number'] as String?,
      animalId: map['animal_id'] as String?,
      category: map['category'] as String?,
      gender: map['gender'] as String?,
      stage: map['stage'] as String?,
      breed: map['breed'] as String?,
      weight: _toDouble(map['weight']),
      dateOfBirth: _dateFromIso(map['date_of_birth']),
      serviceDate: _dateFromIso(map['service_date']),
      pdDate: _dateFromIso(map['pd_date']),
      calvingDate: _dateFromIso(map['calving_date']),
      avgMilkPerDay: _toDouble(map['avg_milk_per_day']),
      milkSalePrice: _toDouble(map['milk_sale_price']),
      milkSoldPercentage: _toDouble(map['milk_sold_percentage']),
      feedCost: _toDouble(map['feed_cost']),
      medicalCost: _toDouble(map['medical_cost']),
      laborCost: _toDouble(map['labor_cost']),
      expectedSaleAnimals: _toInt(map['expected_sale_animals']),
      entryType: map['entry_type'] as String?,
      entryDate: _dateFromIso(map['entry_date']),
      purchasePrice: _toDouble(map['purchase_price']),
    );
  }
}

String? _cleanText(String? value) {
  final text = value?.trim();
  if (text == null || text.isEmpty) return null;
  return text;
}

String? _dateToIso(DateTime? value) => value?.toIso8601String();

DateTime? _dateFromIso(Object? value) {
  final text = value as String?;
  if (text == null || text.isEmpty) return null;
  return DateTime.tryParse(text);
}

double? _toDouble(Object? value) {
  if (value is num) return value.toDouble();
  if (value is String) return double.tryParse(value);
  return null;
}

int _toInt(Object? value) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  if (value is String) return int.tryParse(value) ?? 0;
  return 0;
}
