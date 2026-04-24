import 'package:farm_wise_ai/core/widgets/AddBtn.dart';
import 'package:farm_wise_ai/core/widgets/DatePickerField.dart';
import 'package:farm_wise_ai/core/widgets/DropDownField.dart';
import 'package:farm_wise_ai/features/auth/view/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/themes/app_colors.dart';
import '../../../core/utils/sizes.dart';
import '../../../core/widgets/AppScaffoldBgBasic.dart';
import '../../../core/widgets/FTextField.dart';
import '../../../core/widgets/PrimaryButton.dart';
import '../../../l10n/app_localizations.dart';
import '../view_model/farm_registration_form_viewmodel.dart';

class FarmRegistrationScreen extends ConsumerWidget {
  FarmRegistrationScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final List<String> locations = ['Karachi', 'Lahore', 'Islamabad'];
  final List<String> currencies = ['PKR', 'USD', 'EUR'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(farmRegistrationProvider);
    final l10n = AppLocalizations.of(context)!;
    final businessTypes = [
      l10n.dairy,
      l10n.breeding,
      l10n.mixed,
      l10n.fattening,
    ];

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
              FTextField(
                labelText: l10n.farmName,
                hintText: l10n.farmNameHint,
                controller: viewModel.farmNameController,
                onChanged: viewModel.updateFarmName,
              ),
              const SizedBox(height: sizes.spaceBtwInputFields),
              DropDown(
                labelText: l10n.location,
                hint: l10n.selectLocation,
                items: locations,
                value: viewModel.farm.location.isEmpty ? null : viewModel.farm.location,
                onChanged: (value) => viewModel.updateLocation(value ?? ''),
              ),
              const SizedBox(height: sizes.spaceBtwInputFields),
              DropDown(
                labelText: l10n.businessType,
                hint: l10n.selectBusinessType,
                items: businessTypes,
                value: viewModel.farm.businessType.isEmpty ? null : viewModel.farm.businessType,
                onChanged: (value) => viewModel.updateBusinessType(value ?? ''),
              ),
              const SizedBox(height: sizes.spaceBtwInputFields),
              FTextField(
                labelText: l10n.totalAnimals,
                hintText: l10n.totalAnimalsHint,
                controller: viewModel.animalCountController,
                keyboardType: TextInputType.number,
                onChanged: viewModel.updateAnimalCount,
              ),
              const SizedBox(height: sizes.spaceBtwInputFields),
              if (viewModel.farm.animalCount > 0)
                Align(
                  alignment: Alignment.centerRight,
                  child: AddBtn(onPressed: viewModel.addBreedField),
                ),
              if (viewModel.farm.animalCount > 0)
                const SizedBox(height: sizes.spaceBtwInputFields),
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
                            labelText: l10n.breedName,
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
                            labelText: l10n.quantity,
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
                              '0%',
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
                    ),
                    const SizedBox(height: sizes.spaceBtwInputFields),
                  ],
                );
              }),
              DropDown(
                labelText: l10n.currency,
                hint: l10n.selectCurrency,
                items: currencies,
                value: viewModel.farm.currency.isEmpty ? null : viewModel.farm.currency,
                onChanged: (value) => viewModel.updateCurrency(value ?? ''),
              ),
              const SizedBox(height: sizes.spaceBtwInputFields),
              DatePickerField(
                selectedDate: viewModel.farm.registrationDate,
                onDateSelected: viewModel.updateDate,
                labelText: l10n.startingDate,
              ),
              const SizedBox(height: sizes.spaceBtwSections),
              PrimaryButton(
                label: l10n.registerFarm,
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => LoginScreen()),
                    (route) => false,
                  );
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
