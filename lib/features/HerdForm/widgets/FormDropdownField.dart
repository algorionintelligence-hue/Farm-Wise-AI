import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import '../../../core/themes/app_colors.dart';
import '../../../core/utils/sizes.dart';

class FormDropdownField extends StatelessWidget {
  final String label;
  final String hint;
  final String? value;
  final List<String> items;
  final List<String>? itemLabels;
  final ValueChanged<String?> onChanged;
  final bool enabled;

  const FormDropdownField({
    super.key,
    required this.label,
    required this.hint,
    required this.items,
    required this.onChanged,
    this.value,
    this.itemLabels,
    this.enabled = true,
  }) : assert(
          itemLabels == null || itemLabels.length == items.length,
          'itemLabels must match items length',
        );

  @override
  Widget build(BuildContext context) {
    final selectedValue = enabled ? value : null;

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
              isExpanded: true,
              value: selectedValue,
              onChanged: enabled ? onChanged : null,
              hint: Text(
                hint,
                style: const TextStyle(
                  fontSize: sizes.fontSizeSm,
                  color: UColors.darkGrey,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              iconStyleData: const IconStyleData(
                icon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: UColors.colorPrimary,
                ),
              ),
              buttonStyleData: ButtonStyleData(
                height: 52,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: sizes.md),
                decoration: BoxDecoration(
                  color: enabled ? UColors.inputBg : UColors.borderPrimary,
                  borderRadius: BorderRadius.circular(sizes.inputFieldRadius),
                  border: Border.all(color: UColors.borderPrimary),
                ),
              ),
              dropdownStyleData: DropdownStyleData(
                maxHeight: 280,
                offset: const Offset(0, 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(sizes.inputFieldRadius),
                  border: Border.all(color: UColors.borderPrimary),
                ),
              ),
              menuItemStyleData: const MenuItemStyleData(height: 44),
              items: List.generate(items.length, (index) {
                return DropdownMenuItem<String>(
                  value: items[index],
                  child: Text(
                    itemLabels?[index] ?? items[index],
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: sizes.fontSizeSm,
                      color: enabled ? UColors.textPrimary : UColors.darkGrey,
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
