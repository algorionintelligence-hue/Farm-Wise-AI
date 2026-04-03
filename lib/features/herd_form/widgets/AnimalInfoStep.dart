import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../../../core/themes/app_colors.dart';
import '../../../core/utils/sizes.dart';
import '../../../l10n/app_localizations.dart';
import '../viewmodel/herd_viewmodel.dart';
import '../widgets/CustomInput.dart';

class AnimalInfoStep extends ConsumerWidget {
  const AnimalInfoStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(herdProvider.notifier);
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.only(top: sizes.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Animal ID - text keyboard
          CustomInput(
            label: l10n.animalIdLabel,
            controller: vm.animalIdController,
            keyboardType: TextInputType.text,
          ),

          // Category - dropdown
          _DropdownInput(
            label: l10n.categoryLabel,
            hint: l10n.selectCategory,
            value: vm.category,
            items: const [
              "Cow",
              "Buffalo",
              "Bull",
              "Heifer",
              "Calf (Male)",
              "Calf (Female)"
            ],
            itemLabels: [
              l10n.cow,
              l10n.buffalo,
              l10n.bull,
              l10n.heifer,
              l10n.calfMale,
              l10n.calfFemale,
            ],
            onChanged: (value) {
              if (value == null) return;
              vm.category = value;
            },
          ),

          // Stage - dropdown
          _DropdownInput(
            label: l10n.stageLabel,
            hint: l10n.selectStage,
            value: vm.stage,
            items: const ["lactating", "dry", "pregnant", "open"],
            itemLabels: [
              l10n.stageLactating,
              l10n.stageDry,
              l10n.stagePregnant,
              l10n.stageOpen,
            ],
            onChanged: (value) {
              if (value == null) return;
              vm.stage = value;
            },
          ),

          // Weight - number keyboard
          CustomInput(
            label: l10n.weightKgLabel,
            controller: vm.weightController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
        ],
      ),
    );
  }
}

class _DropdownInput extends StatelessWidget {
  final String label;
  final String hint;
  final String? value;
  final List<String> items;
  final List<String> itemLabels;
  final ValueChanged<String?> onChanged;

  const _DropdownInput({
    required this.label,
    required this.hint,
    required this.value,
    required this.items,
    required this.itemLabels,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: sizes.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: sizes.fontSizeSm,
              fontWeight: FontWeight.w800,
              color: UColors.colorPrimary,
            ),
          ),
          const SizedBox(height: sizes.xs),
          DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              value: value,
              isExpanded: true,
              hint: Text(
                hint,
                style: const TextStyle(
                  fontSize: sizes.fontSizeSm,
                  color: UColors.darkGrey,
                ),
              ),
              items: items
                  .asMap()
                  .entries
                  .map(
                    (entry) => DropdownMenuItem<String>(
                      value: entry.value,
                      child: Text(
                        itemLabels[entry.key],
                        style: const TextStyle(
                          fontSize: sizes.fontSizeSm,
                          fontWeight: FontWeight.w600,
                          color: UColors.textPrimary,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: onChanged,
              buttonStyleData: ButtonStyleData(
                height: 52,
                padding: const EdgeInsets.symmetric(horizontal: sizes.md),
                decoration: BoxDecoration(
                  color: UColors.inputBg,
                  borderRadius: BorderRadius.circular(sizes.inputFieldRadius),
                  border: Border.all(
                    color: UColors.borderPrimary,
                    width: 1.0,
                  ),
                ),
              ),
              iconStyleData: const IconStyleData(
                icon: Icon(Icons.keyboard_arrow_down_rounded),
                iconSize: 22,
                iconEnabledColor: UColors.darkGrey,
              ),
              dropdownStyleData: DropdownStyleData(
                maxHeight: 280,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(sizes.cardRadiusMd),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 44,
                padding: EdgeInsets.symmetric(horizontal: sizes.md),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
