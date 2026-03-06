import 'package:flutter/material.dart';

import '../../../core/Utils/sizes.dart';
import '../../../core/themes/app_colors.dart';

class SectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final List<Widget> children;

  const SectionCard({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(sizes.md),
      decoration: BoxDecoration(
        color: UColors.light,
        borderRadius: BorderRadius.circular(sizes.cardRadiusLg),
        border: Border.all(color: UColors.borderPrimary),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Section Header ──
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(sizes.sm),
                decoration: BoxDecoration(
                  color: UColors.colorPrimary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(sizes.borderRadiusMd),
                ),
                child: Icon(
                  icon,
                  size: sizes.iconSm,
                  color: UColors.colorPrimary,
                ),
              ),
              const SizedBox(width: sizes.sm),
              Expanded(
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
                    if (subtitle != null)
                      Text(
                        subtitle!,
                        style: const TextStyle(
                          fontSize: 11,
                          color: UColors.textSecondary,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: sizes.md),

          // ── Divider ──
          Container(
            height: 1,
            color: UColors.borderPrimary,
            margin: const EdgeInsets.only(bottom: sizes.md),
          ),

          // ── Fields ──
          ...children,
        ],
      ),
    );
  }
}