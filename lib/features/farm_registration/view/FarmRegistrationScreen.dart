import 'package:farm_wise_ai/core/constants/sizes.dart';
import 'package:farm_wise_ai/core/widgets/add_btn.dart';
import 'package:farm_wise_ai/core/widgets/date_picker_btn.dart';
import 'package:farm_wise_ai/core/widgets/dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/texts.dart';
import '../../../core/themes/app_colors.dart';
import '../../../core/widgets/bg.dart';
import '../../../core/widgets/btn.dart';
import '../../../core/widgets/textfield.dart';
import '../view_model/farm_registration_form_viewmodel.dart';


class FarmRegistrationScreen extends ConsumerWidget {
  FarmRegistrationScreen({super.key});

  final _formKey = GlobalKey<FormState>();
<<<<<<< Updated upstream:lib/features/farm_registration/view/FarmRegistrationScreen.dart
  final List<String> businessTypes = ["Dairy", "Breeding", "Mixed", "Fattening"];
  final List<String> locations = ["Karachi", "Lahore", "Islamabad"]; // example
  final List<String> currencies = ["PKR", "USD", "EUR"];
=======

  final List<String> locations = ['Karachi', 'Lahore', 'Islamabad'];
>>>>>>> Stashed changes:lib/features/FarmRegistration/view/FarmRegistrationScreen.dart

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(farmRegistrationProvider);
<<<<<<< Updated upstream:lib/features/farm_registration/view/FarmRegistrationScreen.dart
=======
    final l10n = AppLocalizations.of(context)!;

    final businessTypes = viewModel.businessTypes.map((e) => e.name).toList();
    final currencies = viewModel.currencies.map((e) => e.name).toList();
>>>>>>> Stashed changes:lib/features/FarmRegistration/view/FarmRegistrationScreen.dart

    return PlantaScaffold(
      showBackButton: true,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                UTexts.farmRegistrationFormTitle,
                style: TextStyle(
                  fontSize: sizes.fontSizeHeadings,
                  fontWeight: FontWeight.bold,
                  color: UColors.colorPrimary,
                ),
              ),
              const SizedBox(height: sizes.sm),
<<<<<<< Updated upstream:lib/features/farm_registration/view/FarmRegistrationScreen.dart
              // Sub Title
=======

>>>>>>> Stashed changes:lib/features/FarmRegistration/view/FarmRegistrationScreen.dart
              Text(
                UTexts.farmRegistrationFormSubTitle,
                style: TextStyle(
                  fontSize: sizes.fontSizeSm,
                  color: UColors.textSecondary,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: sizes.defaultSpace),

<<<<<<< Updated upstream:lib/features/farm_registration/view/FarmRegistrationScreen.dart
              // Farm Name
              PlantaTextField(
                labelText: UTexts.farmName,
                hintText: "Hannan",
=======
              // FARM NAME
              FTextField(
                labelText: l10n.farmName,
                hintText: l10n.farmNameHint,
>>>>>>> Stashed changes:lib/features/FarmRegistration/view/FarmRegistrationScreen.dart
                controller: viewModel.farmNameController,
                onChanged: viewModel.updateFarmName,
                validator: (v) => v == null || v.isEmpty ? 'Enter your Farm Name' : null,
              ),

              const SizedBox(height: sizes.spaceBtwInputFields),

<<<<<<< Updated upstream:lib/features/farm_registration/view/FarmRegistrationScreen.dart
              // Location Dropdown
=======
              // LOCATION (CITY)
>>>>>>> Stashed changes:lib/features/FarmRegistration/view/FarmRegistrationScreen.dart
              DropDown(
                labelText: UTexts.location,
                hint: "Select your Location",
                items: locations,
                value: viewModel.farm.city.isEmpty
                    ? null
                    : viewModel.farm.city,
                onChanged: (value) =>
                    viewModel.updateLocation(value ?? ''),
              ),

              const SizedBox(height: sizes.spaceBtwInputFields),

<<<<<<< Updated upstream:lib/features/farm_registration/view/FarmRegistrationScreen.dart
              // Business Type Dropdown
=======
              // BUSINESS TYPE (ID BASED)
>>>>>>> Stashed changes:lib/features/FarmRegistration/view/FarmRegistrationScreen.dart
              DropDown(
                labelText: UTexts.businessType,
                hint: "Select your Business Type",
                items: businessTypes,
                value: viewModel.selectedBusinessTypeId == null
                    ? null
                    : viewModel.businessTypes
                    .firstWhere((e) =>
                e.id == viewModel.selectedBusinessTypeId)
                    .name,
                onChanged: (value) {
                  final selected = viewModel.businessTypes
                      .firstWhere((e) => e.name == value);
                  viewModel.updateBusinessType(selected.id);
                },
              ),

              const SizedBox(height: sizes.spaceBtwInputFields),

<<<<<<< Updated upstream:lib/features/farm_registration/view/FarmRegistrationScreen.dart
              // Total Animals
              PlantaTextField(
                labelText: UTexts.breedMax,
                hintText: "Enter no of animals you have eg: 100",
=======
              // TOTAL ANIMALS (maxBreed)
              FTextField(
                labelText: l10n.totalAnimals,
                hintText: l10n.totalAnimalsHint,
>>>>>>> Stashed changes:lib/features/FarmRegistration/view/FarmRegistrationScreen.dart
                controller: viewModel.animalCountController,
                keyboardType: TextInputType.number,
                onChanged: viewModel.updateAnimalCount,
                validator: (v) =>
                v == null || v.isEmpty ? 'Enter no of animals you have in your farm' : null,
              ),

              const SizedBox(height: sizes.spaceBtwInputFields),

<<<<<<< Updated upstream:lib/features/farm_registration/view/FarmRegistrationScreen.dart
              // Add Breed Button (only visible if animalCount > 0)
              if (viewModel.farm.animalCount > 0)

=======
              // ADD BREED BUTTON
              if (viewModel.farm.maxBreed > 0)
>>>>>>> Stashed changes:lib/features/FarmRegistration/view/FarmRegistrationScreen.dart
                Align(
                  alignment: Alignment.centerRight,
                  child: AddBtn(
                    onPressed: viewModel.addBreedField,
                  ),
                ),

<<<<<<< Updated upstream:lib/features/farm_registration/view/FarmRegistrationScreen.dart
              if (viewModel.farm.animalCount > 0)
                SizedBox(height: sizes.spaceBtwInputFields),

              // Dynamic Breed Fields

=======
              if (viewModel.farm.maxBreed > 0)
                const SizedBox(height: sizes.spaceBtwInputFields),

              // BREED LIST
>>>>>>> Stashed changes:lib/features/FarmRegistration/view/FarmRegistrationScreen.dart
              ...List.generate(viewModel.breedFields.length, (index) {
                final breed = viewModel.breedFields[index];

                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
<<<<<<< Updated upstream:lib/features/farm_registration/view/FarmRegistrationScreen.dart
                          child: PlantaTextField(
                            labelText: "Breed Name",
                            controller: breedField.nameController,
=======
                          child: FTextField(
                            labelText: l10n.breedName,
                            controller: breed.nameController,
>>>>>>> Stashed changes:lib/features/FarmRegistration/view/FarmRegistrationScreen.dart
                            hintText: 'Normande',
                            onChanged: (v) => viewModel.updateBreed(
                              index,
                              v,
                              breed.quantityController.text,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          flex: 1,
<<<<<<< Updated upstream:lib/features/farm_registration/view/FarmRegistrationScreen.dart
                          child: PlantaTextField(
                            labelText: "Quantity",
                            controller: breedField.quantityController,
=======
                          child: FTextField(
                            labelText: l10n.quantity,
                            controller: breed.quantityController,
>>>>>>> Stashed changes:lib/features/FarmRegistration/view/FarmRegistrationScreen.dart
                            keyboardType: TextInputType.number,
                            hintText: '5',
                            onChanged: (v) => viewModel.updateBreed(
                              index,
                              breed.nameController.text,
                              v,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          children: [
                            const Text(
                              "0%",
                              style: TextStyle(
                                color: UColors.colorPrimary,
                                fontSize: sizes.fontSizeSm,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () =>
                                  viewModel.removeBreed(index),
                            ),
                          ],
                        ),
                      ],
                    ),                    SizedBox(height: sizes.spaceBtwInputFields),
                  ],

                );
              }),

<<<<<<< Updated upstream:lib/features/farm_registration/view/FarmRegistrationScreen.dart
              // Currency Dropdown
=======
              // CURRENCY (ID BASED)
>>>>>>> Stashed changes:lib/features/FarmRegistration/view/FarmRegistrationScreen.dart
              DropDown(
                labelText: UTexts.currency,
                hint: "Select your Currency",
                items: currencies,
                value: viewModel.selectedCurrencyId == null
                    ? null
                    : viewModel.currencies
                    .firstWhere((e) =>
                e.id == viewModel.selectedCurrencyId)
                    .name,
                onChanged: (value) {
                  final selected = viewModel.currencies
                      .firstWhere((e) => e.name == value);
                  viewModel.updateCurrency(selected.id);
                },
              ),

              const SizedBox(height: sizes.spaceBtwInputFields),

<<<<<<< Updated upstream:lib/features/farm_registration/view/FarmRegistrationScreen.dart
              // Registration Date Picker
              DatePickerButton(
                selectedDate: viewModel.farm.registrationDate,
=======
              // DATE
              DatePickerField(
                selectedDate: DateTime(
                  2024,
                  1,
                  viewModel.farm.monthStartDay == 0
                      ? 1
                      : viewModel.farm.monthStartDay,
                ),
>>>>>>> Stashed changes:lib/features/FarmRegistration/view/FarmRegistrationScreen.dart
                onDateSelected: viewModel.updateDate,
                labelText: 'Starting Date',
              ),
<<<<<<< Updated upstream:lib/features/farm_registration/view/FarmRegistrationScreen.dart
              const SizedBox(height: sizes.spaceBtwInputFields),

              // Submit Button
              PlantaPrimaryButton(
                label: UTexts.continueBtn,
                onPressed: () {
                  if (viewModel.validateForm(_formKey)) {
                    viewModel.submitForm();
=======

              const SizedBox(height: sizes.spaceBtwSections),

              // SUBMIT BUTTON
              PrimaryButton(
                label: l10n.registerFarm,
                onPressed: () async {
                  final success =
                  await viewModel.submitForm();

                  if (success) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (_) => LoginScreen()),
                          (route) => false,
                    );
>>>>>>> Stashed changes:lib/features/FarmRegistration/view/FarmRegistrationScreen.dart
                  }
                },
              ),

              const SizedBox(height: sizes.spaceBtwSections),
            ],
          ),
        ),
      ),
    );
  }
}