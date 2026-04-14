import 'package:flutter/material.dart';

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
          DropdownButtonFormField<String>(
            value: enabled ? value : null,
            onChanged: enabled ? onChanged : null,
            icon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: UColors.colorPrimary,
            ),
            style: TextStyle(
              fontSize: sizes.fontSizeSm,
              color: enabled ? UColors.textPrimary : UColors.darkGrey,
            ),
            hint: Text(
              hint,
              style: const TextStyle(
                fontSize: sizes.fontSizeSm,
                color: UColors.darkGrey,
              ),
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: enabled ? UColors.inputBg : UColors.borderPrimary,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: sizes.md,
                vertical: sizes.md,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(sizes.inputFieldRadius),
                borderSide: const BorderSide(color: UColors.borderPrimary),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(sizes.inputFieldRadius),
                borderSide: const BorderSide(color: UColors.borderPrimary),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(sizes.inputFieldRadius),
                borderSide: const BorderSide(color: UColors.borderPrimary),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(sizes.inputFieldRadius),
                borderSide: const BorderSide(
                  color: UColors.colorPrimary,
                  width: 1.5,
                ),
              ),
            ),
            items: List.generate(items.length, (index) {
              return DropdownMenuItem<String>(
                value: items[index],
                child: Text(
                  itemLabels?[index] ?? items[index],
                  style: const TextStyle(fontSize: sizes.fontSizeSm),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
