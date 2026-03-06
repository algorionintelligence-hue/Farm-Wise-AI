import 'package:flutter/material.dart';

import '../../../core/Utils/sizes.dart';
import '../../../core/themes/app_colors.dart';

class AiActionsCard extends StatelessWidget {
  // We use a List of Maps to avoid needing a separate model Class
  final List<Map<String, dynamic>> actions;

  const AiActionsCard({
    super.key,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(sizes.cardRadiusLg),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(sizes.md),
            child: Row(
              children: [
                const Icon(Icons.auto_awesome, color: Color(0xFF1A2B4C), size: sizes.iconSm),
                const SizedBox(width: sizes.xs),
                const Text(
                  'Top 3 AI Actions',
                  style: TextStyle(
                    color: UColors.colorPrimary,
                    fontSize: sizes.fontSizeMd,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Action Items mapped from the List
          ...actions.map((action) {
            final bool isLast = actions.indexOf(action) == actions.length - 1;

            return Column(
              children: [
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(sizes.sm),
                    decoration: BoxDecoration(
                      color: (action['color'] as Color).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                        action['icon'] as IconData,
                        color: action['color'] as Color,
                        size: sizes.iconMd
                    ),
                  ),
                  title: Text(
                    action['title'] ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: sizes.fontSizeSm + 1,
                      color: UColors.textDark,
                    ),
                  ),
                  subtitle: Text(
                    action['subtitle'] ?? '',
                    style: TextStyle(
                      color:  (action['subtitleTextColor'] as Color),
                      fontSize: sizes.fontSizeSm - 1,
                    ),
                  ),
                  trailing: Icon(Icons.chevron_right, color: UColors.colorPrimary, size: sizes.iconSm),
                  onTap: () {},
                ),
                if (!isLast)
                  Divider(height: 1, color: UColors.grey, indent: 70),
              ],
            );
          }).toList(),
          const SizedBox(height: sizes.sm),
        ],
      ),
    );
  }
}