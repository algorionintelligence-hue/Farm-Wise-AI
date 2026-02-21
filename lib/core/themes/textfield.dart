// ═════════════════════════════════════════════════════════════
// 3. PlantaTextField
// ═════════════════════════════════════════════════════════════
import 'package:flutter/material.dart';

import '../constants/sizes.dart';
import 'app_colors.dart';

class PlantaTextField extends StatelessWidget {
  const PlantaTextField({
    super.key,
    required this.labelText,
    required this.hintText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
    this.onChanged,
  });

  final String labelText;
  final String hintText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Text(
          labelText,
          style: const TextStyle(
            fontSize: USizes.fontSizeSm,
            fontWeight: FontWeight.w600,
            color: UColors.textPrimary,
          ),
        ),
        const SizedBox(height: USizes.sm),

        // Input Field
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          onChanged: onChanged,
          validator: validator,
          style: const TextStyle(
            fontSize: USizes.fontSizeSm,
            color: UColors.textPrimary,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              fontSize: USizes.fontSizeSm,
              color: UColors.darkGrey,
            ),
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: UColors.inputBg,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: USizes.md,
              vertical: USizes.md,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(USizes.inputFieldRadius),
              borderSide: const BorderSide(color: UColors.borderPrimary),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(USizes.inputFieldRadius),
              borderSide: const BorderSide(color: UColors.borderPrimary),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(USizes.inputFieldRadius),
              borderSide:
              const BorderSide(color: UColors.plantaGreen, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(USizes.inputFieldRadius),
              borderSide: const BorderSide(color: UColors.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(USizes.inputFieldRadius),
              borderSide: const BorderSide(color: UColors.error, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}