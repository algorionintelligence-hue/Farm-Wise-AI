import 'package:farm_wise_ai/features/auth/view/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/themes/app_colors.dart';
import '../../../core/utils/sizes.dart';
import '../../../core/widgets/AddBtn.dart';
import '../../../core/widgets/AppScaffoldBgBasic.dart';
import '../../../core/widgets/DatePickerField.dart';
import '../../../core/widgets/DropDownField.dart';
import '../../../core/widgets/FTextField.dart';
import '../../../core/widgets/PrimaryButton.dart';
import '../../../l10n/AppLocalizations.dart';
import '../view_model/FarmRegistrationFormViewModel.dart';

class FarmRegistrationScreen extends ConsumerStatefulWidget {
  const FarmRegistrationScreen({super.key});

  @override
  ConsumerState<FarmRegistrationScreen> createState() =>
      _FarmRegistrationScreenState();
}

class _FarmRegistrationScreenState
    extends ConsumerState<FarmRegistrationScreen> {

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    // 🔥 ONLY FIX: CALL API WHEN SCREEN OPENS
    Future.microtask(() {
      ref.read(farmRegistrationProvider).initLookups();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(farmRegistrationProvider);
    final l10n = AppLocalizations.of(context)!;

    final businessTypes =
    viewModel.businessTypes.map((e) => e.name).toList();

    final currencies =
    viewModel.currencies.map((e) => e.name).toList();

    return AppScaffoldBgBasic(
      showBackButton: true,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.farmRegistrationTitle,
                style: const TextStyle(
                  fontSize: sizes.fontSizeHeadings,
                  fontWeight: FontWeight.bold,
                  color: UColors.colorPrimary,
                ),
              ),

              const SizedBox(height: sizes.sm),

              Text(
                l10n.farmRegistrationSubtitle,
                style: const TextStyle(
                  fontSize: sizes.fontSizeSm,
                  color: UColors.textSecondary,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: sizes.defaultSpace),

              // FARM NAME
              FTextField(
                labelText: l10n.farmName,
                hintText: l10n.farmNameHint,
                controller: viewModel.farmNameController,
                onChanged: viewModel.updateFarmName,
              ),

              const SizedBox(height: sizes.spaceBtwInputFields),

              // CITY
              FTextField(
                labelText: "City",
                hintText: "Enter city",
                controller: viewModel.locationController,
                onChanged: viewModel.updateLocation,
              ),

              const SizedBox(height: sizes.spaceBtwInputFields),

              // AREA
              FTextField(
                labelText: "Area",
                hintText: "Enter area",
                controller: viewModel.areaController,
                onChanged: viewModel.updateArea,
              ),

              const SizedBox(height: sizes.spaceBtwInputFields),

              // BUSINESS TYPE
              DropDown(
                labelText: l10n.businessType,
                hint: l10n.selectBusinessType,
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

              // TOTAL ANIMALS
              FTextField(
                labelText: l10n.totalAnimals,
                hintText: l10n.totalAnimalsHint,
                controller: viewModel.animalCountController,
                keyboardType: TextInputType.number,
                onChanged: viewModel.updateAnimalCount,
              ),

              const SizedBox(height: sizes.spaceBtwInputFields),

              if (viewModel.farm.maxBreed > 0)
                Align(
                  alignment: Alignment.centerRight,
                  child: AddBtn(
                    onPressed: viewModel.addBreedField,
                  ),
                ),

              const SizedBox(height: sizes.spaceBtwInputFields),

              // BREEDS
              ...List.generate(viewModel.breedFields.length, (index) {
                final breed = viewModel.breedFields[index];

                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: FTextField(
                            labelText: l10n.breedName,
                            controller: breed.nameController,
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
                          child: FTextField(
                            labelText: l10n.quantity,
                            controller: breed.quantityController,
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
                              '0%',
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
                    ),
                    const SizedBox(height: sizes.spaceBtwInputFields),
                  ],
                );
              }),

              // CURRENCY
              DropDown(
                labelText: l10n.currency,
                hint: l10n.selectCurrency,
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

              // DATE
              DatePickerField(
                selectedDate: DateTime(
                  2024,
                  1,
                  viewModel.farm.monthStartDay == 0
                      ? 1
                      : viewModel.farm.monthStartDay,
                ),
                onDateSelected: viewModel.updateDate,
                labelText: "Date Picker",
              ),

              const SizedBox(height: sizes.spaceBtwSections),

              // SUBMIT
              PrimaryButton(
                label: l10n.registerFarm,
                onPressed: () async {
                  final success = await viewModel.submitForm();

                  if (success) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => LoginScreen(),
                      ),
                          (route) => false,
                    );
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
/\gh''}