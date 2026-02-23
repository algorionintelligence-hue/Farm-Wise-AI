import 'package:farm_wise_ai/core/constants/sizes.dart';
import 'package:flutter/material.dart';

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
          hint: Text(hint),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 16,
            ),
          ),
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}