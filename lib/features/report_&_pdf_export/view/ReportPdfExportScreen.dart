import 'package:farm_wise_ai/core/widgets/AppScaffoldBgBasic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/Utils/sizes.dart';
import '../../../core/themes/app_colors.dart';

class ReportpdfExportscreen extends ConsumerWidget {
  const ReportpdfExportscreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppScaffoldBgBasic(
      showBackButton: true,
      child:
    SingleChildScrollView(
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Financial & Operational Reports",
          style: TextStyle(
            color: UColors.colorPrimary,
            fontSize: sizes.fontSizeHeadings,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: sizes.spaceBtwSections),
      
        // --- Reports Grid ---
        Column(

          children: [
            _buildReportButton("Monthly P&L", UColors.gradientBarGreen1, UColors.gradientBarGreen2),
            _buildReportButton("Breeding Impact", UColors.gradientBarBlue1, UColors.gradientBarBlue2),
            _buildReportButton("90-Day Forecast", UColors.gradientOrange1, UColors.gradientOrange2),
            _buildReportButton("Inventory Report", UColors.gradientBarPurple1, UColors.gradientBarPurple2),
          ],
        ),
      
        const SizedBox(height: sizes.spaceBtwSections),

      ],
          ),
    ),
    );
  }

  // --- Large Gradient Report Button ---
  Widget _buildReportButton(String title, Color c1, Color c2) {
    return Container(
      margin: const EdgeInsets.only(bottom: sizes.md), // Spacing between rows
      decoration: BoxDecoration(
        // Gradient background
        gradient: LinearGradient(
          colors: [c1, c2],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(sizes.cardRadiusMd),
        boxShadow: [
          BoxShadow(
            color: c2.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(sizes.cardRadiusMd),
          onTap: () => print("Exporting $title..."),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: sizes.md,
              vertical: sizes.mdLg, // Larger height for row form
            ),
            child: Row(
              children: [
                // 1. PDF Icon with subtle background
                Container(
                  padding: const EdgeInsets.all(sizes.sm),
                  decoration: BoxDecoration(
                    color: UColors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(sizes.borderRadiusSm),
                  ),
                  child: const Icon(
                    Icons.picture_as_pdf,
                    color: UColors.white,
                    size: sizes.iconMd,
                  ),
                ),
                const SizedBox(width: sizes.md),

                // 2. Report Title
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: UColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: sizes.fontSizeMd, // Slightly larger for row layout
                    ),
                  ),
                ),

                // 3. Download Icon
                const Icon(
                  Icons.file_download_outlined,
                  color: UColors.white,
                  size: sizes.iconMd,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }}
