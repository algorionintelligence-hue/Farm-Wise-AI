import 'BreedDetailModel.dart';

class FarmRegistrationModel {
  final String farmName;
  final String city;
  final String area;
  final int businessType;
  final int maxBreed;
  final int currency;
  final int monthStartDay;
  final List<BreedDetailModel>? breeds;

  const FarmRegistrationModel({
    required this.farmName,
    required this.city,
    required this.area,
    required this.businessType,
    required this.maxBreed,
    required this.currency,
    required this.monthStartDay,
     this.breeds,
  });

  // ─────────────────────────────
  // COPY WITH (IMPORTANT FIX)
  // ─────────────────────────────
  FarmRegistrationModel copyWith({
    String? farmName,
    String? city,
    String? area,
    int? businessType,
    int? maxBreed,
    int? currency,
    int? monthStartDay,
    List<BreedDetailModel>? breeds,
  }) {
    return FarmRegistrationModel(
      farmName: farmName ?? this.farmName,
      city: city ?? this.city,
      area: area ?? this.area,
      businessType: businessType ?? this.businessType,
      maxBreed: maxBreed ?? this.maxBreed,
      currency: currency ?? this.currency,
      monthStartDay: monthStartDay ?? this.monthStartDay,
      breeds: breeds ?? this.breeds,
    );
  }

  // TO JSON (API REQUEST)
  // ─────────────────────────────
  Map<String, dynamic> toJson() {
    return {
      "farmName": farmName,
      "city": city,
      "area": area,
      "businessType": businessType,
      "maxBreed": maxBreed,
      "currency": currency,
      "monthStartDay": monthStartDay,
      "breeds": breeds?.map((e) => e.toJson()).toList(),
    };
  }

<<<<<<< Updated upstream:lib/features/farm_registration/model/farm_registration_model.dart
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
=======
  // ─────────────────────────────
  // FROM JSON (API RESPONSE)
  // ─────────────────────────────
  factory FarmRegistrationModel.fromJson(Map<String, dynamic> json) {
    return FarmRegistrationModel(
      farmName: json["farmName"] ?? '',
      city: json["city"] ?? '',
      area: json["area"] ?? '',
      businessType: json["businessType"],
      maxBreed: json["maxBreed"],
      currency: json["currency"],
      monthStartDay: json["monthStartDay"],
      breeds: (json["breeds"] as List<dynamic>? ?? [])
          .map((e) => BreedDetailModel.fromJson(e))
          .toList(),
    );
  }
>>>>>>> Stashed changes:lib/features/FarmRegistration/model/FarmRegistrationModel.dart
}