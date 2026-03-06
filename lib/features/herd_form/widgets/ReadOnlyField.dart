import 'package:flutter/material.dart';

import '../../../core/Utils/sizes.dart';
import '../../../core/themes/app_colors.dart';

class ReadOnlyField extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const ReadOnlyField({
    super.key,
    required this.label,
    required this.value,
    this.icon = Icons.calculate_rounded,
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
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: sizes.md,
              vertical: sizes.md,
            ),
            decoration: BoxDecoration(
              color: UColors.colorPrimary.withOpacity(0.06),
              borderRadius: BorderRadius.circular(sizes.inputFieldRadius),
              border: Border.all(
                color: UColors.colorPrimary.withOpacity(0.3),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: sizes.iconXs,
                  color: UColors.colorPrimary,
                ),
                const SizedBox(width: sizes.sm),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: sizes.fontSizeSm,
                    fontWeight: FontWeight.w700,
                    color: UColors.colorPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}