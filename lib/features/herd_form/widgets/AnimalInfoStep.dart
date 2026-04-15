import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/themes/app_colors.dart';
import '../../../core/utils/sizes.dart';
import '../../../l10n/app_localizations.dart';
import '../viewmodel/herd_viewmodel.dart';
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

    final stage = vm.stage;
    final bool showBreeding = stage == StageKey.youngBull ||
        stage == StageKey.bull ||
        stage == StageKey.heifer ||
        stage == StageKey.lactating ||
        stage == StageKey.pregnant ||
        stage == StageKey.dry ||
        stage == StageKey.open;
    final bool showPregnancy =
        stage == StageKey.pregnant || stage == StageKey.dry;
    final bool showMilk = stage == StageKey.lactating;
    final bool serviceOnly = showBreeding && !showPregnancy;

    return Padding(
      padding: const EdgeInsets.only(top: sizes.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionCard(
            icon: Icons.pets_rounded,
            title: l10n.animalInfoStepTitle,
            children: [
              CustomInput(
                label: l10n.tagNumberLabel,
                hintText: l10n.tagNumberHint,
                controller: vm.tagNumberController,
              ),
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
                    onSelected: (_) => vm.setEntryType('purchased'),
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
                  ChoiceChip(
                    label: Text(l10n.entryTypeBornOnFarm),
                    selected: vm.entryType == 'born_on_farm',
                    onSelected: (_) => vm.setEntryType('born_on_farm'),
                    selectedColor: UColors.colorPrimary,
                    labelStyle: TextStyle(
                      color: vm.entryType == 'born_on_farm'
                          ? Colors.white
                          : UColors.textPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: vm.entryType == 'born_on_farm'
                            ? UColors.colorPrimary
                            : UColors.borderPrimary,
                      ),
                    ),
                    backgroundColor: Colors.white,
                  ),
                ],
              ),
              const SizedBox(height: sizes.sm),
              if (vm.entryType == 'purchased') ...[
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
              ] else if (vm.entryType == 'born_on_farm') ...[
                DatePickerTile(
                  icon: Icons.calendar_today_rounded,
                  label: l10n.entryDateLabel,
                  selectedDate: vm.entryDate,
                  onPicked: (date) => vm.setEntryDate(date),
                ),
              ],
            ],
          ),

        ],
      ),
    );
  }
}
