import 'package:flutter/material.dart';

import '../Utils/sizes.dart';
import '../themes/app_colors.dart';

class DropDown extends StatelessWidget {
  final String labelText;
  final String hint;
  final List<String> items;
  final String? value;
  final ValueChanged<String?> onChanged;

  const DropDown({
    super.key,
    required this.labelText,
    required this.hint,
    required this.items,
    required this.onChanged,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: const TextStyle(
            fontSize: sizes.fontSizeSm,
            fontWeight: FontWeight.w800,
            color: UColors.colorPrimary,
          ),
        ),
        const SizedBox(height: sizes.sm),
        DropdownButtonFormField<String>(
          value: value,

          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: UColors.colorPrimary,
          ),

          style: const TextStyle(
            fontSize: sizes.fontSizeSm,
            fontWeight: FontWeight.normal,
            color: UColors.textPrimary,
          ),

          hint: Text(
            hint,
            style: const TextStyle(
              fontSize: sizes.fontSizeSm,
              fontWeight: FontWeight.normal,
              color: UColors.darkGrey,
            ),
          ),

          decoration: InputDecoration(
            filled: true,
            fillColor: UColors.inputBg,
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
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(sizes.inputFieldRadius),
              borderSide:
              const BorderSide(color: UColors.plantaGreen, width: 1.5),
            ),
          ),

          items: items
              .map((item) => DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: const TextStyle(
                fontSize: sizes.fontSizeSm,
                fontWeight: FontWeight.normal,
              ),
            ),
          ))
              .toList(),

          onChanged: onChanged,
        ),      ],
    );
  }
}