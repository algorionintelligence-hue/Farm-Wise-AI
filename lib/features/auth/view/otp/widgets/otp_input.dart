import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../core/themes/app_colors.dart';

class OtpInputBox extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool hasError;

  const OtpInputBox({
    super.key,
    required this.controller,
    required this.focusNode,
    this.hasError = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 56,
      decoration: BoxDecoration(
        color: UColors.inputBg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          // Error ho to red, focus ho to green, warna grey
          color: hasError
              ? UColors.error
              : focusNode.hasFocus
              ? UColors.plantaGreen
              : UColors.borderPrimary,
          width: focusNode.hasFocus ? 2 : 1.5,
        ),
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: UColors.textPrimary,
        ),
        decoration: const InputDecoration(
          counterText: '',  // "0/1" text hide karo
          border: InputBorder.none,
        ),
        // Sirf numbers allow karo
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      ),
    );
  }
}
