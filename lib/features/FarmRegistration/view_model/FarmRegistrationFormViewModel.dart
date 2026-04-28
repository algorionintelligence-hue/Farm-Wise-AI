import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/AppUrl.dart';
import '../../../core/network/NetworkApiServices.dart';
import '../model/BreedDetailModel.dart';
import '../model/FarmRegistrationLookupModels.dart';
import '../model/FarmRegistrationModel.dart';



final farmRegistrationProvider =
ChangeNotifierProvider<FarmRegistrationViewModel>((ref) {
  return FarmRegistrationViewModel();
});

class FarmRegistrationViewModel extends ChangeNotifier {
  final _api = NetworkApiServices();

  // ─────────────────────────────
  // LOADING STATES
  // ─────────────────────────────
  bool isLoading = false;
  bool isSubmitting = false;

  // ─────────────────────────────
  // LOOKUPS
  // ─────────────────────────────
  List<CurrencyModel> currencies = [];
  List<BusinessTypeModel> businessTypes = [];

  int? selectedCurrencyId;
  int? selectedBusinessTypeId;

  // ─────────────────────────────
  // FARM STATE
  // ─────────────────────────────
  FarmRegistrationModel farm = FarmRegistrationModel(
    farmName: '',
    city: '',
    area: '',
    businessType: 0,
    maxBreed: 0,
    currency: 0,
    monthStartDay: 0,
    breeds: [],
  );

  // ─────────────────────────────
  // CONTROLLERS
  // ─────────────────────────────
  final farmNameController = TextEditingController();
  final locationController = TextEditingController();
  final animalCountController = TextEditingController();
  final areaController = TextEditingController();

  void updateArea(String value) {
    farm = farm.copyWith(area: value);
    notifyListeners();
  }
  // ─────────────────────────────
  // BREEDS
  // ─────────────────────────────
  List<BreedField> breedFields = [];

  // ─────────────────────────────
  // INIT (CALL LOOKUPS ON SCREEN OPEN)
  // ─────────────────────────────
  Future<void> initLookups() async {
    isLoading = true;
    notifyListeners();

    try {
      final currencyRes =
      await _api.getApi(AppUrl.LOOKUP_CURRENCY_URL);

      final businessRes =
      await _api.getApi(AppUrl.LOOKUP_BUSINESSTYPE_URL);

      currencies = (currencyRes as List)
          .map((e) => CurrencyModel.fromJson(e))
          .toList();

      businessTypes = (businessRes as List)
          .map((e) => BusinessTypeModel.fromJson(e))
          .toList();

    } catch (e) {
      debugPrint("Lookup error: $e");
    }

    isLoading = false;
    notifyListeners();
  }

  // ─────────────────────────────
  // FIELD UPDATES
  // ─────────────────────────────
  void updateFarmName(String value) {
    farm = farm.copyWith(farmName: value);
    notifyListeners();
  }

  void updateLocation(String value) {
    farm = farm.copyWith(city: value);
    notifyListeners();
  }

  void updateAnimalCount(String value) {
    final qty = int.tryParse(value) ?? 0;
    farm = farm.copyWith(maxBreed: qty);
    notifyListeners();
  }

  void updateCurrency(int id) {
    selectedCurrencyId = id;
    farm = farm.copyWith(currency: id);
    notifyListeners();
  }

  void updateBusinessType(int id) {
    selectedBusinessTypeId = id;
    farm = farm.copyWith(businessType: id);
    notifyListeners();
  }

  void updateDate(DateTime date) {
    farm = farm.copyWith(monthStartDay: date.day);
    notifyListeners();
  }

  // ─────────────────────────────
  // BREED HANDLING
  // ─────────────────────────────
  void addBreedField() {
    breedFields.add(BreedField());
    notifyListeners();
  }

  void updateBreed(int index, String name, String quantity) {
    if (index >= breedFields.length) return;

    final qty = int.tryParse(quantity) ?? 0;

    breedFields[index].nameController.text = name;
    breedFields[index].quantityController.text = quantity;

    final updated = [...?farm.breeds];

    if (index < updated.length) {
      updated[index] = BreedDetailModel(
        breedName: name,
        quantity: qty,
      );
    } else {
      updated.add(
        BreedDetailModel(
          breedName: name,
          quantity: qty,
        ),
      );
    }

    farm = farm.copyWith(breeds: updated);
    notifyListeners();
  }

  void removeBreed(int index) {
    if (index >= breedFields.length) return;

    breedFields.removeAt(index);

    final updated = [...?farm.breeds];

    if (index < updated.length) {
      updated.removeAt(index);
    }

    farm = farm.copyWith(breeds: updated);
    notifyListeners();
  }

  bool validateForm(GlobalKey<FormState> formKey) {
    return formKey.currentState?.validate() ?? false;
  }

  // ─────────────────────────────
  // SUBMIT API (FARM REGISTER)
  // ─────────────────────────────
  Future<bool> submitForm() async {
    isSubmitting = true;
    notifyListeners();

    try {
      final response = await _api.postApi(
        farm.toJson(),
        AppUrl.FARM_REGISTRATION_URL,
      );

      isSubmitting = false;
      notifyListeners();

      return true;
    } catch (e) {
      isSubmitting = false;
      notifyListeners();

      debugPrint("Farm register error: $e");
      return false;
    }
  }

  // ─────────────────────────────
  @override
  void dispose() {
    farmNameController.dispose();
    locationController.dispose();
    animalCountController.dispose();

    for (var b in breedFields) {
      b.dispose();
    }

    super.dispose();
  }
}

// ─────────────────────────────
// BREED FIELD
// ─────────────────────────────
class BreedField {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  void dispose() {
    nameController.dispose();
    quantityController.dispose();
  }
}