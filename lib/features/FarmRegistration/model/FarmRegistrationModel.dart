class Breed {
  final String name;
  final int quantity;

  const Breed({
    required this.name,
    required this.quantity,
  });

  Breed copyWith({
    String? name,
    int? quantity,
  }) {
    return Breed(
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'quantity': quantity,
  };

  factory Breed.fromJson(Map<String, dynamic> json) => Breed(
    name: json['name'] ?? '',
    quantity: json['quantity'] ?? 0,
  );
}

class FarmRegistrationModel {
  final String farmName;
  final String location;
  final String businessType;
  final int animalCount;
  final String currency;
  final DateTime? registrationDate;
  final List<Breed> breeds;

  const FarmRegistrationModel({
    this.farmName = '',
    this.location = '',
    this.businessType = '',
    this.animalCount = 0,
    this.currency = '',
    this.registrationDate,
    this.breeds = const [],
  });

  FarmRegistrationModel copyWith({
    String? farmName,
    String? location,
    String? businessType,
    int? animalCount,
    String? currency,
    DateTime? registrationDate,
    List<Breed>? breeds,
  }) {
    return FarmRegistrationModel(
      farmName: farmName ?? this.farmName,
      location: location ?? this.location,
      businessType: businessType ?? this.businessType,
      animalCount: animalCount ?? this.animalCount,
      currency: currency ?? this.currency,
      registrationDate: registrationDate ?? this.registrationDate,
      breeds: breeds ?? this.breeds,
    );
  }

  Map<String, dynamic> toJson() => {
    'farmName': farmName,
    'location': location,
    'businessType': businessType,
    'animalCount': animalCount,
    'currency': currency,
    'registrationDate': registrationDate?.toIso8601String(),
    'breeds': breeds.map((b) => b.toJson()).toList(),
  };

  factory FarmRegistrationModel.fromJson(Map<String, dynamic> json) => FarmRegistrationModel(
    farmName: json['farmName'] ?? '',
    location: json['location'] ?? '',
    businessType: json['businessType'] ?? '',
    animalCount: json['animalCount'] ?? 0,
    currency: json['currency'] ?? '',
    registrationDate: json['registrationDate'] != null
        ? DateTime.parse(json['registrationDate'])
        : null,
    breeds: json['breeds'] != null
        ? List<Breed>.from(
        (json['breeds'] as List).map((b) => Breed.fromJson(b)))
        : [],
  );
}
