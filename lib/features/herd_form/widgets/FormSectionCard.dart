import 'package:flutter/material.dart';

import '../../../core/themes/app_colors.dart';
import '../../../core/utils/sizes.dart';

class FormSectionCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget child;

  const FormSectionCard({
    super.key,
    required this.title,
    required this.child,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: sizes.md),
      padding: const EdgeInsets.all(sizes.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(sizes.cardRadiusLg),
        border: Border.all(color: UColors.borderPrimary),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: sizes.fontSizeMd,
              fontWeight: FontWeight.w800,
              color: UColors.colorPrimary,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(
              subtitle!,
              style: const TextStyle(
                fontSize: sizes.fontSizeSm,
                color: UColors.textSecondary,
              ),
            ),
          ],
          const SizedBox(height: sizes.sm),
          child,
        ],
      ),
    );
  }
}
