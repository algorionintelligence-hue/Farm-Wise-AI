// viewmodels/farm_registration_viewmodel.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/farm_registration_model.dart';

final farmRegistrationProvider =
ChangeNotifierProvider<FarmRegistrationViewModel>((ref) {
  return FarmRegistrationViewModel();
});

class FarmRegistrationViewModel extends ChangeNotifier {
  // Immutable Farm instance
  FarmRegistrationModel farm = const FarmRegistrationModel();

  // Text controllers
  final farmNameController = TextEditingController();
  final locationController = TextEditingController();
  final businessTypeController = TextEditingController();
  final animalCountController = TextEditingController();
  final currencyController = TextEditingController();

  // Dynamic breed fields
  List<BreedField> breedFields = [];

  // Update individual fields using copyWith
  void updateFarmName(String name) {
    farm = farm.copyWith(farmName: name);
    notifyListeners();
  }

  void updateLocation(String location) {
    farm = farm.copyWith(location: location);
    notifyListeners();
  }

  void updateBusinessType(String businessType) {
    farm = farm.copyWith(businessType: businessType);
    notifyListeners();
  }

  void updateAnimalCount(String count) {
    final qty = int.tryParse(count) ?? 0;
    farm = farm.copyWith(animalCount: qty);
    notifyListeners();
  }

  void updateCurrency(String currency) {
    farm = farm.copyWith(currency: currency);
    notifyListeners();
  }

  void updateDate(DateTime date) {
    farm = farm.copyWith(registrationDate: date);
    notifyListeners();
  }

  // Dynamic breed handling
  void addBreedField() {
    breedFields.add(BreedField());
    notifyListeners();
  }

  void updateBreed(int index, String name, String quantity) {
    if (index >= breedFields.length) return;
    final qty = int.tryParse(quantity) ?? 0;

    // Update field controllers
    breedFields[index].nameController.text = name;
    breedFields[index].quantityController.text = quantity;

    // Update farm breeds immutably
    final updatedBreeds = [...farm.breeds];
    if (index < updatedBreeds.length) {
      updatedBreeds[index] = Breed(name: name, quantity: qty);
    } else {
      updatedBreeds.add(Breed(name: name, quantity: qty));
    }

    farm = farm.copyWith(breeds: updatedBreeds);
    notifyListeners();
  }

  void removeBreed(int index) {
    if (index >= breedFields.length) return;
    breedFields.removeAt(index);

    final updatedBreeds = [...farm.breeds];
    if (index < updatedBreeds.length) {
      updatedBreeds.removeAt(index);
      farm = farm.copyWith(breeds: updatedBreeds);
      notifyListeners();
    }
    notifyListeners();
  }

  bool validateForm(GlobalKey<FormState> formKey) {
    return formKey.currentState?.validate() ?? false;
  }

  void submitForm() {

  }

  @override
  void dispose() {
    farmNameController.dispose();
    locationController.dispose();
    businessTypeController.dispose();
    animalCountController.dispose();
    currencyController.dispose();
    for (var bf in breedFields) {
      bf.dispose();
    }
    super.dispose();
  }
}

// Helper class for dynamic breed input
class BreedField {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  void dispose() {
    nameController.dispose();
    quantityController.dispose();
  }
}
