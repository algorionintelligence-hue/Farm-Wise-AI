import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/themes/app_colors.dart';
import '../../../core/utils/sizes.dart';
import '../../../l10n/AppLocalizations.dart';
import '../viewmodel/HerdViewmodel.dart';
import '../widgets/CustomInput.dart';
import '../widgets/DatePickerTile.dart';
import '../widgets/FormDropdownField.dart';
import '../widgets/SectionCard.dart';

class AnimalInfoStep extends ConsumerWidget {
  const AnimalInfoStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(herdProvider);
    final vm = ref.watch(herdProvider.notifier);
    final l10n = AppLocalizations.of(context)!;

    const categories = [
      'Cow',
      'Buffalo',
      'Goat',
      'Sheep',
    ];

    const breeds = [
      'Sahiwal',
      'Nili Ravi',
      'Holstein Friesian',
      'Jersey',
      'Crossbred',
      'Other',
    ];

    const maleStageItems = [
      StageKey.maleCalf,
      StageKey.youngBull,
      StageKey.bull,
    ];

    const femaleStageItems = [
      StageKey.femaleCalf,
      StageKey.heifer,
      StageKey.lactating,
      StageKey.pregnant,
      StageKey.dry,
      StageKey.open,
    ];

    final maleStageLabels = [
      l10n.stageMaleCalf,
      l10n.stageYoungBull,
      l10n.stageBull,
    ];

    final femaleStageLabels = [
      l10n.stageFemaleCalf,
      l10n.stageHeifer,
      l10n.stageLactating,
      l10n.stagePregnant,
      l10n.stageDry,
      l10n.stageOpen,
    ];



    Future<void> pickImage() async {
      // final picker = ImagePicker();
      // final picked = await picker.pickImage(
      //   source: ImageSource.gallery,
      //   imageQuality: 80,
      //   maxWidth: 800,
      // );
      // if (picked != null) {
      //   vm.setAnimalImagePath(picked.path);
      // }
    }

    return Padding(
      padding: const EdgeInsets.only(top: sizes.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionCard(
            icon: Icons.pets_rounded,
            title: l10n.animalInfoStepTitle,
            children: [
              // ── Animal Photo Upload ──
              Text(
                l10n.animalPhotoLabel,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: UColors.colorPrimary,
                ),
              ),
              const SizedBox(height: sizes.xs),
              GestureDetector(
                onTap: pickImage,
                child: Container(
                  height: 140,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: UColors.inputBg,
                    borderRadius: BorderRadius.circular(sizes.inputFieldRadius),
                    border: Border.all(
                      color: vm.animalImagePath != null
                          ? UColors.colorPrimary
                          : UColors.borderPrimary,
                      width: vm.animalImagePath != null ? 1.5 : 1.0,
                    ),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: vm.animalImagePath != null
                      ? Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.file(
                              File(vm.animalImagePath!),
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 12),
                                color: Colors.black.withOpacity(0.45),
                                child: Text(
                                  l10n.changePhoto,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: UColors.colorPrimary.withOpacity(0.08),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.add_a_photo_rounded,
                                color: UColors.colorPrimary,
                                size: 28,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              l10n.tapToUploadPhoto,
                              style: const TextStyle(
                                fontSize: 13,
                                color: UColors.darkGrey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
              // ── Tag Number ──
              // CustomInput(
              //   label: l10n.tagNumberLabel,
              //   hintText: l10n.tagNumberHint,
              //   controller: vm.tagNumberController,
              // ),ok

              const SizedBox(height: sizes.sm),

              // ── Animal Name ──
              CustomInput(
                label: l10n.animalNameLabel,
                hintText: l10n.animalNameHint,
                controller: vm.animalNameController,
              ),

              // ── Category & Gender ──
              Row(
                children: [
                  Expanded(
                    child: FormDropdownField(
                      label: l10n.categoryLabel,
                      hint: l10n.selectCategory,
                      value: vm.category,
                      items: categories,
                      itemLabels: [
                        l10n.cow,
                        l10n.buffalo,
                        l10n.goat,
                        l10n.sheep,
                      ],
                      onChanged: (value) {
                        if (value == null) return;
                        vm.setCategory(value);
                      },
                    ),
                  ),
                  const SizedBox(width: sizes.sm),
                  Expanded(
                    child: FormDropdownField(
                      label: l10n.genderLabel,
                      hint: l10n.selectGender,
                      value: vm.gender,
                      items: const [GenderKey.male, GenderKey.female],
                      itemLabels: [l10n.genderMale, l10n.genderFemale],
                      onChanged: (value) {
                        if (value == null) return;
                        vm.setGender(value);
                      },
                    ),
                  ),
                ],
              ),
              FormDropdownField(
                label: l10n.stageLabel,
                hint: l10n.selectStage,
                value: vm.gender == null ? null : vm.stage,
                items: vm.gender == GenderKey.male
                    ? maleStageItems
                    : vm.gender == GenderKey.female
                        ? femaleStageItems
                        : const <String>[],
                itemLabels: vm.gender == GenderKey.male
                    ? maleStageLabels
                    : vm.gender == GenderKey.female
                        ? femaleStageLabels
                        : const <String>[],
                enabled: vm.gender != null,
                onChanged: (value) {
                  if (value == null) return;
                  vm.setStage(value);
                },
              ),
              FormDropdownField(
                label: l10n.breedLabel,
                hint: l10n.selectBreed,
                value: vm.breed,
                items: breeds,
                onChanged: (value) {
                  if (value == null) return;
                  vm.setBreed(value);
                },
              ),
              DatePickerTile(
                icon: Icons.calendar_today_rounded,
                label: l10n.dateOfBirthLabel,
                selectedDate: vm.dateOfBirth,
                onPicked: (date) => vm.setDateOfBirth(date),
              ),
              CustomInput(
                label: l10n.weightKgLabel,
                hintText: l10n.weightHint,
                controller: vm.weightController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
            ],
          ),
          SectionCard(
            icon: Icons.how_to_reg_rounded,
            title: l10n.entryDetailsTitle,
            subtitle: l10n.entryDetailsSubtitle,
            children: [
              Text(
                l10n.entryTypeLabel,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: UColors.textPrimary,
                ),
              ),
              const SizedBox(height: sizes.xs),
              Wrap(
                spacing: sizes.sm,
                children: [
                  ChoiceChip(
                    label: Text(l10n.entryTypePurchased),
                    selected: vm.entryType == 'purchased',
                    onSelected: (selected) {
                      vm.setEntryType(selected ? 'purchased' : null);
                    },
                    selectedColor: UColors.colorPrimary,
                    labelStyle: TextStyle(
                      color: vm.entryType == 'purchased'
                          ? Colors.white
                          : UColors.textPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: vm.entryType == 'purchased'
                            ? UColors.colorPrimary
                            : UColors.borderPrimary,
                      ),
                    ),
                    backgroundColor: Colors.white,
                  ),
                ],
              ),
              if (vm.entryType == 'purchased') ...[
                const SizedBox(height: sizes.sm),
                DatePickerTile(
                  icon: Icons.calendar_today_rounded,
                  label: l10n.entryDateLabel,
                  selectedDate: vm.entryDate,
                  onPicked: (date) => vm.setEntryDate(date),
                ),
                CustomInput(
                  label: l10n.purchasePriceLabel,
                  hintText: '0',
                  controller: vm.purchasePriceController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
