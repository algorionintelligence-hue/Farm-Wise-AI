// ═══════════════════════════════════════════════
// Input Bar
// ═══════════════════════════════════════════════

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/Utils/sizes.dart';
import '../../../core/themes/app_colors.dart';

class InputBar extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String) onSend;

  const InputBar({required this.controller, required this.onSend});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: sizes.sm, vertical: sizes.xs),
      decoration: BoxDecoration(
        color: UColors.light,
        borderRadius: BorderRadius.circular(sizes.inputFieldRadius),
        border: Border.all(color: UColors.borderPrimary),
      ),
      child: Row(
        children: [
          const Icon(Icons.auto_awesome_rounded,
              size: sizes.iconSm, color: UColors.colorPrimary),
          const SizedBox(width: sizes.sm),
          Expanded(
            child: TextField(
              controller: controller,
              onSubmitted: onSend,
              style: const TextStyle(
                fontSize: sizes.fontSizeSm,
                color: UColors.textPrimary,
              ),
              decoration: const InputDecoration(
                hintText: "Ask about profits, costs, herd_form...",
                hintStyle: TextStyle(
                  fontSize: sizes.fontSizeSm,
                  color: UColors.darkGrey,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: sizes.sm),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => onSend(controller.text),
            child: Container(
              padding: const EdgeInsets.all(sizes.sm),
              decoration: const BoxDecoration(
                color: UColors.colorPrimary,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.send_rounded,
                  color: Colors.white, size: sizes.iconSm),
            ),
          ),
        ],
      ),
    );
  }
}