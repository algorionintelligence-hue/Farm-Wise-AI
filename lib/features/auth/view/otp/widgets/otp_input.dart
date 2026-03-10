import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../core/themes/app_colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../core/themes/app_colors.dart';

class OtpInputBox extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool hasError;
  final ValueChanged<String>? onChanged; // ✅ add this

  const OtpInputBox({
    super.key,
    required this.controller,
    required this.focusNode,
    this.hasError = false,
    this.onChanged, // ✅ add this
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
        onChanged: onChanged, // ✅ wire it up
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: UColors.textPrimary,
        ),
        decoration: const InputDecoration(
          counterText: '',
          border: InputBorder.none,
        ),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      ),
    );
  }
}
