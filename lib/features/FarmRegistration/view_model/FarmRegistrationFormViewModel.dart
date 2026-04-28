import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/AppUrl.dart';
import '../../../core/network/NetworkApiServices.dart';
import '../model/FarmRegistrationLookupModels.dart';
import '../model/FarmRegistrationModel.dart';
import '../model/BreedDetailModel.dart';

final farmRegistrationProvider =
ChangeNotifierProvider<FarmRegistrationViewModel>((ref) {
  return FarmRegistrationViewModel();
});

class FarmRegistrationViewModel extends ChangeNotifier {
  final _api = NetworkApiServices();

  String? farmNameError;
  String? cityError;
  String? areaError;
  String? businessTypeError;
  String? currencyError;
  String? maxBreedError;
  String? serverError;


  // ================= STATES =================
  bool isLoading = false;
  bool isSubmitting = false;

  // ================= LOOKUPS =================
  List<CurrencyModel> currencies = [];
  List<BusinessTypeModel> businessTypes = [];

  int? selectedCurrencyId;
  int? selectedBusinessTypeId;

  // ================= FARM MODEL =================
  FarmRegistrationModel farm = FarmRegistrationModel(
    farmName: '',
    city: '',
    area: '',
    businessType: 0,
    maxBreed: 0,
    currency: 0,
    monthStartDay: 0,
  );

  // ================= CONTROLLERS =================
  final farmNameController = TextEditingController();
  final locationController = TextEditingController();
  final animalCountController = TextEditingController();
  final areaController = TextEditingController();

  // ================= BREEDS UI ONLY =================
  List<BreedField> breedFields = [];

  // ================= INIT LOOKUPS =================
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

  // ================= FARM FIELD UPDATES =================
  void updateFarmName(String value) {
    farm = farm.copyWith(farmName: value);
    notifyListeners();
  }

  void updateLocation(String value) {
    farm = farm.copyWith(city: value);
    notifyListeners();
  }

  void updateArea(String value) {
    farm = farm.copyWith(area: value);
    notifyListeners();
  }

  void updateAnimalCount(String value) {
    farm = farm.copyWith(maxBreed: int.tryParse(value) ?? 0);
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

  // ================= BREED HANDLING =================
  void addBreedField() {
    if (breedFields.length >= farm.maxBreed) return;

    breedFields.add(BreedField());
    notifyListeners();
  }

  void removeBreed(int index) {
    if (index >= breedFields.length) return;

    breedFields.removeAt(index);
    notifyListeners();
  }

  // ================= CREATE FARM =================
  Future<String?> _createFarm() async {
    final response = await _api.postApi(
      {
        "farmName": farm.farmName,
        "city": farm.city,
        "area": farm.area,
        "businessType": farm.businessType,
        "currency": farm.currency,
        "monthStartDay": farm.monthStartDay,
        "maxBreed": farm.maxBreed,
      },
      AppUrl.FARM_REGISTRATION_URL,
    );

    debugPrint("FARM RESPONSE: $response");

    if (response == null || response["farmId"] == null) {
      return null;
    }

    return response["farmId"];
  }
  void updateBreed(int index, String name, String quantity) {
    if (index >= breedFields.length) return;

    breedFields[index].nameController.text = name;
    breedFields[index].quantityController.text = quantity;

    notifyListeners();
  }
  // ================= ADD BREEDS =================
  Future<void> _addBreeds(String farmId) async {
    for (var b in breedFields) {
      final name = b.nameController.text.trim();
      final qty = int.tryParse(b.quantityController.text) ?? 0;

      if (name.isEmpty || qty <= 0) continue;

      await _api.postApi(
        {
          "breedName": name,
          "quantity": qty,
        },
        "${AppUrl.FARM_REGISTRATION_URL}/$farmId/breeds",
      );
    }
  }

  // ================= SUBMIT FORM =================
  Future<bool> submitForm() async {
    if (!validateFields()) return false;

    isSubmitting = true;
    notifyListeners();

    try {
      final farmResponse = await _api.postApi(
        {
          "farmName": farm.farmName,
          "city": farm.city,
          "area": farm.area,
          "businessType": farm.businessType,
          "maxBreed": farm.maxBreed,
          "currency": farm.currency,
          "monthStartDay": farm.monthStartDay,
        },
        AppUrl.FARM_REGISTRATION_URL,
      );

      if (farmResponse == null || farmResponse["farmId"] == null) {
        serverError = "Server error: Farm creation failed";
        notifyListeners();
        return false;
      }

      final farmId = farmResponse["farmId"];

      for (var b in breedFields) {
        final name = b.nameController.text.trim();
        final qty = int.tryParse(b.quantityController.text) ?? 0;

        if (name.isEmpty || qty <= 0) continue;

        await _api.postApi(
          {
            "breedName": name,
            "quantity": qty,
          },
          "${AppUrl.FARM_REGISTRATION_URL}/$farmId/breeds",
        );
      }

      isSubmitting = false;
      notifyListeners();
      return true;

    } catch (e) {
      serverError = "Server error: ${e.toString()}";
      isSubmitting = false;
      notifyListeners();
      return false;
    }
  }
  // ================= DISPOSE =================
  @override
  void dispose() {
    farmNameController.dispose();
    locationController.dispose();
    animalCountController.dispose();
    areaController.dispose();

    for (var b in breedFields) {
      b.dispose();
    }

    super.dispose();
  }


  bool validateFields() {
    bool isValid = true;

    farmNameError = null;
    cityError = null;
    areaError = null;
    businessTypeError = null;
    currencyError = null;
    maxBreedError = null;
    serverError = null;

    if (farm.farmName.trim().isEmpty) {
      farmNameError = "Farm name is required";
      isValid = false;
    }

    if (farm.city.trim().isEmpty) {
      cityError = "City is required";
      isValid = false;
    }

    if (farm.area.trim().isEmpty) {
      areaError = "Area is required";
      isValid = false;
    }

    if (farm.businessType == 0) {
      businessTypeError = "Business type required";
      isValid = false;
    }

    if (farm.currency == 0) {
      currencyError = "Currency required";
      isValid = false;
    }

    if (farm.maxBreed <= 0) {
      maxBreedError = "Max breed must be greater than 0";
      isValid = false;
    }

    notifyListeners();
    return isValid;
  }




}

// ================= BREED FIELD =================
class BreedField {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  void dispose() {
    nameController.dispose();
    quantityController.dispose();
  }
}