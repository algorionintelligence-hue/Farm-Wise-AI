import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/herd.dart';

class StageKey {
  static const maleCalf = 'male_calf';
  static const femaleCalf = 'female_calf';
  static const heifer = 'heifer';
  static const lactating = 'lactating';
  static const pregnant = 'pregnant';
  static const dry = 'dry';
  static const open = 'open';
  static const youngBull = 'young_bull';
  static const bull = 'bull';
}

class GenderKey {
  static const male = 'male';
  static const female = 'female';
}

class HerdViewModel extends StateNotifier<HerdInputModel> {
  HerdViewModel() : super(HerdInputModel());

  final tagNumberController = TextEditingController();
  final animalIdController = TextEditingController();
  final weightController = TextEditingController();
  final avgMilkController = TextEditingController();
  final milkPriceController = TextEditingController();
  final milkSoldController = TextEditingController();
  final feedCostController = TextEditingController();
  final medicalCostController = TextEditingController();
  final laborCostController = TextEditingController();
  final expectedSaleController = TextEditingController();
  final purchasePriceController = TextEditingController();

  String? category;
  String? gender;
  String? stage;
  String? breed;
  String? entryType;

  DateTime? dateOfBirth;
  DateTime? serviceDate;
  DateTime? pdDate;
  DateTime? calvingDate;
  DateTime? entryDate;

  bool get isCalfStage =>
      stage == StageKey.maleCalf || stage == StageKey.femaleCalf;

  // 1. Lactating Female (Doodh dene wali aur Breedable dono)
  bool get isLactatingFemale =>
      gender == GenderKey.female && stage == StageKey.lactating;

  // 2. Breedable Female (Heifer, Open, ya Dry - Pregnant included)
  // Not lactating, but eligible for breeding record
  bool get isBreedableFemaleOnly =>
      gender == GenderKey.female &&
      (stage == StageKey.heifer ||
          stage == StageKey.open ||
          stage == StageKey.dry ||
          stage == StageKey.pregnant);

  // Helper for navigation: Does it need BOTH production and breeding?
  bool get isEligibleForBoth => isLactatingFemale;

  bool get isNonBreedable =>
      gender == GenderKey.male || isCalfStage;

  bool get hasBreedingDates =>
      serviceDate != null || pdDate != null || calvingDate != null;

  int expectedCalves() {
    if (serviceDate == null) return 0;
    final diff = DateTime.now().difference(serviceDate!).inDays;
    return diff <= 280 ? 1 : 0;
  }

  void setCategory(String value) {
    category = value;
    state = state.copyWith(category: category);
  }

  void setGender(String value) {
    gender = value;
    stage = null;
    serviceDate = null;
    pdDate = null;
    calvingDate = null;
    avgMilkController.clear();
    milkPriceController.clear();
    milkSoldController.clear();
    state = state.copyWith(
      gender: gender,
      stage: stage,
      serviceDate: serviceDate,
      pdDate: pdDate,
      calvingDate: calvingDate,
    );
  }

  void setStage(String value) {
    stage = value;
    final bool showMilk = value == StageKey.lactating;
    final bool showPregnancy =
        value == StageKey.pregnant || value == StageKey.dry;
    
    final bool showBreeding = value == StageKey.youngBull ||
        value == StageKey.bull ||
        value == StageKey.heifer ||
        value == StageKey.lactating ||
        value == StageKey.pregnant ||
        value == StageKey.dry ||
        value == StageKey.open;

    if (!showBreeding) {
      serviceDate = null;
      pdDate = null;
      calvingDate = null;
    } else if (!showPregnancy) {
      pdDate = null;
      calvingDate = null;
    }

    if (!showMilk) {
      avgMilkController.clear();
      milkPriceController.clear();
      milkSoldController.clear();
    }

    state = state.copyWith(
      gender: gender,
      stage: stage,
      serviceDate: serviceDate,
      pdDate: pdDate,
      calvingDate: calvingDate,
    );
  }

  void setBreed(String value) {
    breed = value;
    state = state.copyWith(breed: breed);
  }

  void setEntryType(String value) {
    if (entryType != value) {
      entryDate = null;
    }
    entryType = value;
    if (value != 'purchased') {
      purchasePriceController.clear();
    }
    state = state.copyWith(entryType: entryType);
  }

  void setEntryDate(DateTime value) {
    entryDate = value;
    state = state.copyWith(entryDate: entryDate);
  }

  void setDateOfBirth(DateTime value) {
    dateOfBirth = value;
    state = state.copyWith(dateOfBirth: dateOfBirth);
  }

  void save() {
    state = HerdInputModel(
      tagNumber: tagNumberController.text,
      animalId: animalIdController.text,
      category: category,
      gender: gender,
      stage: stage,
      breed: breed,
      weight: double.tryParse(weightController.text),
      dateOfBirth: dateOfBirth,
      serviceDate: serviceDate,
      pdDate: pdDate,
      calvingDate: calvingDate,
      avgMilkPerDay: double.tryParse(avgMilkController.text),
      milkSalePrice: double.tryParse(milkPriceController.text),
      milkSoldPercentage: double.tryParse(milkSoldController.text),
      feedCost: double.tryParse(feedCostController.text),
      medicalCost: double.tryParse(medicalCostController.text),
      laborCost: double.tryParse(laborCostController.text),
      expectedSaleAnimals: int.tryParse(expectedSaleController.text) ?? 0,
      entryType: entryType,
      entryDate: entryDate,
      purchasePrice: double.tryParse(purchasePriceController.text),
    );
  }

  String? validateBreedingStageRule() {
    if (!isCalfStage || !hasBreedingDates) return null;
    serviceDate = null;
    pdDate = null;
    calvingDate = null;
    refreshDates();
    return 'calfCannotHaveBreedingDatesError';
  }

  void refreshDates() {
    state = state.copyWith(
      serviceDate: serviceDate,
      pdDate: pdDate,
      calvingDate: calvingDate,
    );
  }

  @override
  void dispose() {
    tagNumberController.dispose();
    animalIdController.dispose();
    weightController.dispose();
    avgMilkController.dispose();
    milkPriceController.dispose();
    milkSoldController.dispose();
    feedCostController.dispose();
    medicalCostController.dispose();
    laborCostController.dispose();
    expectedSaleController.dispose();
    purchasePriceController.dispose();
    super.dispose();
  }
}

final herdProvider =
StateNotifierProvider<HerdViewModel, HerdInputModel>(
        (ref) => HerdViewModel());
