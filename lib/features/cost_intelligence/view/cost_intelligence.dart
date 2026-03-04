import 'package:farm_wise_ai/core/widgets/internal_app_bg.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/sizes.dart';
import '../../../core/themes/app_colors.dart';

class CashIntelliganceDashboard extends ConsumerWidget {
  const CashIntelliganceDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InternalAppBg(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildGreeting(),
            const SizedBox(height: sizes.md),
            SingleChildScrollView(
              child: Column(
                children: [
                  _buildCostBreakdownCard(),
                  const SizedBox(height: sizes.spaceBtwItems),
                  //_buildFeedAlertCard(),
                  const SizedBox(height: sizes.spaceBtwItems),
                  Column(
                    children: [
                      _buildEconomicsItem(
                        icon: Icons.pets,
                        title: "Cost / Animal",
                        value: "PKR 18,400",
                        time: "Per Month",
                      ),
                      _buildEconomicsItem(
                        icon: Icons.opacity,
                        title: "Cost / Litre",
                        value: "PKR 142",
                        time: "Per Month",
                      ),
                      _buildEconomicsItem(
                        icon: Icons.attach_money,
                        title: "Milk Price",
                        value: "PKR 185",
                        time: "Per Month",
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        )

    );
  }

  /// --- SECTION 1: PIE CHART WITH INDIVIDUAL PERCENTAGES ---
  Widget _buildCostBreakdownCard() {
    return Container(
      padding: const EdgeInsets.all(sizes.md),
      decoration: BoxDecoration(
        color: UColors.white,
        borderRadius: BorderRadius.circular(sizes.cardRadiusLg),
        border: Border.all(color: UColors.borderSecondary),
      ),
      child: Column(
        children: [
          const Text(
            "Monthly Cost Breakdown",
            style: TextStyle(
                color: UColors.textDark,
                fontSize: sizes.fontSizeMd,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: sizes.md),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: SizedBox(
                  height: 160, // Increased height to accommodate labels
                  child: PieChart(
                    // Triggers circular animation on screen load
                    swapAnimationDuration: const Duration(milliseconds: 1000),
                    swapAnimationCurve: Curves.decelerate,
                    PieChartData(
                      sectionsSpace: 2,
                      centerSpaceRadius: 0,
                      sections: [
                        _getSection(45, "45%",
                            [const Color(0xFF66BB6A), const Color(0xFF388E3C)]),
                        _getSection(25, "25%",
                            [const Color(0xFF42A5F5), const Color(0xFF1976D2)]),
                        _getSection(15, "15%",
                            [const Color(0xFFFFA726), const Color(0xFFF57C00)]),
                        _getSection(12, "12%",
                            [const Color(0xFFEF5350), const Color(0xFFD32F2F)]),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: sizes.md),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLegendRow("Feed", "45%", const Color(0xFF388E3C)),
                  _buildLegendRow("Labour", "25%", const Color(0xFF1976D2)),
                  _buildLegendRow("Vet", "15%", const Color(0xFFF57C00)),
                  _buildLegendRow("Deft", "12%", const Color(0xFFD32F2F)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  PieChartSectionData _getSection(
      double value, String title, List<Color> colors) {
    return PieChartSectionData(
      value: value,
      title: title,
      // This shows the % on each piece
      radius: 80,
      showTitle: true,
      titleStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      // Adjusts text position to be inside the slice
      titlePositionPercentageOffset: 0.6,
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: colors,
      ),
    );
  }

  Widget _buildLegendRow(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                    color: color, borderRadius: BorderRadius.circular(2)),
              ),
              const SizedBox(width: sizes.sm),
              Text(label,
                  style: const TextStyle(color: UColors.textSecondary)),
              const SizedBox(width: sizes.sm),
              Text(value,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: UColors.textPrimary)),
            ],
          ),
          const Divider(height: 10, thickness: 0.5),
        ],
      ),
    );
  }

  Widget _buildEconomicsItem({
    required IconData icon,
    required String title,
    required String value,
    required String time,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: UColors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        children: [
          // Icon container
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: UColors.colorPrimary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Icon(icon, color: UColors.colorPrimary, size: 24),
          ),
          const SizedBox(width: 16),
          // Title and Value
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: UColors.textPrimary,
                    fontSize: sizes.md,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    color: UColors.colorPrimary,
                    fontSize: sizes.mdLg,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // Time
          Text(
            time,
            style: const TextStyle(
              color: UColors.textSecondary,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
Widget _buildGreeting() {
  return RichText(
    text: const TextSpan(
      style: TextStyle(color: UColors.textDark, fontSize: sizes.fontSizeLg),
      children: [
        TextSpan(
          text: 'Cost Intelligance',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}
