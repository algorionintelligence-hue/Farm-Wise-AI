import 'package:farm_wise_ai/core/widgets/AppScaffoldBgBasic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/themes/app_colors.dart';
import '../../../core/utils/sizes.dart';
import '../../../l10n/app_localizations.dart';

class ReportpdfExportscreen extends ConsumerWidget {
  const ReportpdfExportscreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    return AppScaffoldBgBasic(
      showBackButton: true,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.reportsTitle,
              style: const TextStyle(
                color: UColors.colorPrimary,
                fontSize: sizes.fontSizeHeadings,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: sizes.spaceBtwSections),
            Column(
              children: [
                _buildReportButton(l10n.monthlyPnL, UColors.gradientBarGreen1, UColors.gradientBarGreen2),
                _buildReportButton(l10n.breedingImpact, UColors.gradientBarBlue1, UColors.gradientBarBlue2),
                _buildReportButton(l10n.ninetyDayForecast, UColors.gradientOrange1, UColors.gradientOrange2),
                _buildReportButton(l10n.inventoryReport, UColors.gradientBarPurple1, UColors.gradientBarPurple2),
              ],
            ),
            const SizedBox(height: sizes.spaceBtwSections),
          ],
        ),
      ),
    );
  }

  Widget _buildReportButton(String title, Color c1, Color c2) {
    return Container(
      margin: const EdgeInsets.only(bottom: sizes.md),
      decoration: BoxDecoration(
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
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(sizes.cardRadiusMd),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: sizes.md, vertical: sizes.mdLg),
            child: Row(
              children: [
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
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: UColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: sizes.fontSizeMd,
                    ),
                  ),
                ),
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
  }
}
