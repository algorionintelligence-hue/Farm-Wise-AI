import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/sizes.dart';
import '../../../core/themes/app_colors.dart';
import '../../../core/widgets/internal_app_bg.dart';
import '../viewmodel/inventory_viewmodel.dart';

class InventoryDashboard extends ConsumerWidget {
  const InventoryDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(inventoryProvider);
    return InternalAppBg(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildGreeting(),
          const SizedBox(height: sizes.md),

          // Card 1: Feed
          _inventoryCard(
            title: 'Feed Days Cover',
            value: '21 days',
            icon: Icons.grass,
            color: UColors.plantaGreen,
          ),

          // Card 2: Medicine
          _inventoryCard(
            title: 'Medicine Stock',
            value: '45 days',
            icon: Icons.medication_rounded,
            color: Colors.blue,
          ),

          // Card 3: Minerals with Warning
          _inventoryCard(
            title: 'Minerals Stock',
            value: '12 days',
            icon: Icons.opacity,
            color: UColors.warning,
            showAlert: true,
          ),

          _buildTrendsAndInsights()
        ],
      ),
    );
  }


  Widget _buildGreeting() {
    return RichText(
      text: const TextSpan(
        style: TextStyle(color: UColors.textDark, fontSize: sizes.fontSizeLg),
        children: [
          TextSpan(
            text: 'Inventory Health',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }


  Widget _inventoryCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    bool showAlert = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: sizes.md),
      padding: const EdgeInsets.all(sizes.md),
      // Styled like the reference card
      decoration: BoxDecoration(
        color: UColors.white,
        borderRadius: BorderRadius.circular(sizes.cardRadiusLg),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Left side Icon Container
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(sizes.borderRadiusMd),
            ),
            child: Icon(icon, color: color, size: sizes.iconMd),
          ),
          const SizedBox(width: sizes.md),

          // Text Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title, //
                  style: const TextStyle(
                    color: UColors.textPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: sizes.fontSizeMd,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Text(
                      value, //
                      style: const TextStyle(
                        color: UColors.textSecondary,
                        fontSize: sizes.fontSizeSm,
                      ),
                    ),
                    if (showAlert) ...[
                      const SizedBox(width: 4),
                      const Icon(Icons.warning_rounded, color: UColors.warning,
                          size: 14), //
                    ]
                  ],
                ),
              ],
            ),
          ),

          // Trailing dots from reference
          const Icon(
              Icons.more_horiz, color: UColors.darkGrey, size: sizes.iconSm),
        ],
      ),
    );
  }

  Widget _buildTrendsAndInsights() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        const Text(
          'Consumption Trend', //
          style: TextStyle(
            color: UColors.primary,
            fontSize: sizes.fontSizeMd,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: sizes.md),

        // Trend Card
        Container(
          padding: const EdgeInsets.all(sizes.md),
          decoration: BoxDecoration(
            color: UColors.white,
            borderRadius: BorderRadius.circular(sizes.cardRadiusLg),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Feed vs Milk Output', //
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: UColors.textPrimary,
                  fontSize: sizes.fontSizeMd,
                ),
              ),
              const SizedBox(height: sizes.lg),

              // Feed Progress Row
              _buildProgressBar(
                label: 'Feed', //
                value: 0.85, // Example 85% full
                color: UColors.primary,
              ),
              const SizedBox(height: sizes.md),

              // Milk Progress Row
              _buildProgressBar(
                label: 'Milk', //
                value: 0.60, // Example 60% full
                color: UColors.plantaGreen,
              ),
            ],
          ),
        ),

        const SizedBox(height: sizes.spaceBtwSections),

        // AI Insight Section
        const Text(
          'AI Insight', //
          style: TextStyle(
            color: UColors.primary,
            fontSize: sizes.fontSizeMd,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: sizes.md),

        // AI Insight Speech Bubble / Callout
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(sizes.md),
          decoration: BoxDecoration(
            color: UColors.lightGrey,
            borderRadius: BorderRadius.circular(sizes.cardRadiusMd),
            border: Border.all(color: UColors.borderSecondary),
          ),
          child: const Text(
            '"Feed increased 12% but milk only 2%. Possible efficiency issue."', //
            textAlign: TextAlign.center,
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: UColors.textPrimary,
              fontSize: sizes.fontSizeSm + 1,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProgressBar({required String label, required double value, required Color color}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: UColors.textSecondary, fontSize: sizes.fontSizeSm),
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(sizes.borderRadiusSm),
          child: LinearProgressIndicator(
            value: value,
            minHeight: 12,
            backgroundColor: UColors.grey.withOpacity(0.3),
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }

}