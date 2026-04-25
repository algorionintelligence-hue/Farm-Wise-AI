import 'package:flutter/material.dart';

import '../../../core/utils/sizes.dart';
import '../../../core/themes/app_colors.dart';

class CustomInput extends StatelessWidget {
  final String label;
  final String? hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final void Function(String)? onChanged;
  final bool readOnly;
  final bool enabled;

  const CustomInput({
    super.key,
    required this.label,
    this.hintText,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.readOnly = false,
    this.enabled = true,
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
          TextField(
            controller: controller,
            keyboardType: keyboardType,
            onChanged: onChanged,
            readOnly: readOnly,
            enabled: enabled,
            style: const TextStyle(
              fontSize: sizes.fontSizeSm,
              color: UColors.textPrimary,
            ),
            decoration: InputDecoration(
              hintText: hintText ?? label,
              hintStyle: const TextStyle(
                fontSize: sizes.fontSizeSm,
                color: UColors.darkGrey,
              ),
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
                borderSide: const BorderSide(
                    color: UColors.colorPrimary, width: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
