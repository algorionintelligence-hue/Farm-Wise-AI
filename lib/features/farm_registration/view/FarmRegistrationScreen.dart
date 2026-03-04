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
  final List<String> businessTypes = ["Dairy", "Breeding", "Mixed", "Fattening"];
  final List<String> locations = ["Karachi", "Lahore", "Islamabad"]; // example
  final List<String> currencies = ["PKR", "USD", "EUR"];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(farmRegistrationProvider);

    return AppScaffold(
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
              // Sub Title
              Text(
                UTexts.farmRegistrationFormSubTitle,
                style: TextStyle(
                  fontSize: sizes.fontSizeSm,
                  color: UColors.textSecondary,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: sizes.defaultSpace),

              // Farm Name
              FTextField(
                labelText: UTexts.farmName,
                hintText: "Hannan",
                controller: viewModel.farmNameController,
                onChanged: viewModel.updateFarmName,
                validator: (v) => v == null || v.isEmpty ? 'Enter your Farm Name' : null,
              ),
              const SizedBox(height: sizes.spaceBtwInputFields),

              // Location Dropdown
              DropDown(
                labelText: UTexts.location,
                hint: "Select your Location",
                items: locations,
                value: viewModel.farm.location.isEmpty ? null : viewModel.farm.location,
                onChanged: (value) => viewModel.updateLocation(value ?? ''),
              ),
              const SizedBox(height: sizes.spaceBtwInputFields),

              // Business Type Dropdown
              DropDown(
                labelText: UTexts.businessType,
                hint: "Select your Business Type",
                items: businessTypes,
                value: viewModel.farm.businessType.isEmpty ? null : viewModel.farm.businessType,
                onChanged: (value) => viewModel.updateBusinessType(value ?? ''),
              ),
              const SizedBox(height: sizes.spaceBtwInputFields),

              // Total Animals
              FTextField(
                labelText: UTexts.breedMax,
                hintText: "Enter no of animals you have eg: 100",
                controller: viewModel.animalCountController,
                keyboardType: TextInputType.number,
                onChanged: viewModel.updateAnimalCount,
                validator: (v) =>
                v == null || v.isEmpty ? 'Enter no of animals you have in your farm' : null,
              ),
              const SizedBox(height: sizes.spaceBtwInputFields),

              // Add Breed Button (only visible if animalCount > 0)
              if (viewModel.farm.animalCount > 0)

                Align(
                  alignment: Alignment.centerRight,
                  child: AddBtn(
                    onPressed: viewModel.addBreedField,
                  ),
                ),

              if (viewModel.farm.animalCount > 0)
                SizedBox(height: sizes.spaceBtwInputFields),

              // Dynamic Breed Fields

              ...List.generate(viewModel.breedFields.length, (index) {
                final breedField = viewModel.breedFields[index];
                return Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          flex: 2,
                          child: FTextField(
                            labelText: "Breed Name",
                            controller: breedField.nameController,
                            hintText: 'Normande',
                            onChanged: (v) => viewModel.updateBreed(
                              index,
                              v,
                              breedField.quantityController.text,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          flex: 1,
                          child: FTextField(
                            labelText: "Quantity",
                            controller: breedField.quantityController,
                            keyboardType: TextInputType.number,
                            hintText: '5',
                            onChanged: (v) => viewModel.updateBreed(
                              index,
                              breedField.nameController.text,
                              v,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
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
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => viewModel.removeBreed(index),
                            ),
                          ],
                        ),
                      ],
                    ),                    SizedBox(height: sizes.spaceBtwInputFields),
                  ],

                );
              }),

              // Currency Dropdown
              DropDown(
                labelText: UTexts.currency,
                hint: "Select your Currency",
                items: currencies,
                value: viewModel.farm.currency.isEmpty ? null : viewModel.farm.currency,
                onChanged: (value) => viewModel.updateCurrency(value ?? ''),
              ),
              const SizedBox(height: sizes.spaceBtwInputFields),

              // Registration Date Picker
              DatePickerButton(
                selectedDate: viewModel.farm.registrationDate,
                onDateSelected: viewModel.updateDate,
                labelText: 'Starting Date',
              ),
              const SizedBox(height: sizes.spaceBtwInputFields),

              // Submit Button
              PrimaryButton(
                label: UTexts.continueBtn,
                onPressed: () {
                  if (viewModel.validateForm(_formKey)) {
                    viewModel.submitForm();
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