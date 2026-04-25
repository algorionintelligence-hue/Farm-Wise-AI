import 'package:farm_wise_ai/core/widgets/AppScaffoldBg.dart';
import 'package:farm_wise_ai/features/dashboard/view/AiActionsCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/themes/app_colors.dart';
import '../../../core/utils/sizes.dart';
import '../../../l10n/AppLocalizations.dart';
import 'ForecastData.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    return AppScaffoldBg(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildGreeting(l10n),
          const SizedBox(height: sizes.md),
          _buildCombinedFinancialCard(context, l10n),
          const SizedBox(height: sizes.md),
          AdvancedForecastCard(),
          const SizedBox(height: sizes.md),
          AiActionsCard(
            actions: [
              {
                'title': l10n.reduceOpenDays,
                'subtitle': l10n.monthlyLoss,
                'icon': Icons.trending_down,
                'color': UColors.error,
                'subtitleTextColor': UColors.error,
              },
              {
                'title': l10n.feedCostHighMilkFlat,
                'subtitle': l10n.optimizeRationBalance,
                'icon': Icons.warning_amber_rounded,
                'color': UColors.warning,
                'subtitleTextColor': UColors.warning,
              },
              {
                'title': l10n.sellMaleCalvesInApril,
                'subtitle': l10n.forecastedCashInjection,
                'icon': Icons.sell_outlined,
                'color': UColors.success,
                'subtitleTextColor': UColors.success,
              },
            ],
          ),
          const SizedBox(height: sizes.lg),
        ],
      ),
    );
  }

  Widget _buildGreeting(AppLocalizations l10n) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(color: UColors.textDark, fontSize: sizes.fontSizeLg),
        children: [
          TextSpan(text: '${l10n.welcome}, '),
          const TextSpan(
            text: 'Ahmed Farm',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildCombinedFinancialCard(BuildContext context, AppLocalizations l10n) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF384A24), Color(0xFF388540)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(sizes.scaffoldTopRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: sizes.sm,
            offset: const Offset(0, sizes.xs),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(sizes.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.cashRunwayTitle,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: sizes.fontSizeMd,
                  ),
                ),
                const SizedBox(height: sizes.sm),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'PKR 320,000',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: sizes.lg,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: sizes.md,
                        vertical: sizes.xs,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(sizes.buttonRadius),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.arrow_drop_up, color: Colors.white, size: sizes.iconSm),
                          Text(
                            '47 ${l10n.days}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: sizes.fontSizeSm,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: sizes.spaceBtwItems),
                Row(
                  children: [
                    const Icon(Icons.trending_up, color: Colors.white70, size: sizes.iconSm),
                    const SizedBox(width: sizes.xs),
                    Text(
                      'PKR 1,896 ${l10n.todaysGrowth}',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: sizes.fontSizeSm,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          _cashDetails(l10n),
        ],
      ),
    );
  }

  Widget _cashDetails(AppLocalizations l10n) {
    return Container(
      margin: const EdgeInsets.fromLTRB(sizes.md, 0, sizes.md, sizes.md),
      padding: const EdgeInsets.symmetric(vertical: sizes.spaceBtwItems),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(sizes.cardRadiusLg),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildModernAction(Icons.analytics_outlined, l10n.revenue, '680k'),
          _buildVerticalDivider(),
          _buildModernAction(Icons.arrow_upward, l10n.cost, '560k'),
          _buildVerticalDivider(),
          _buildModernAction(Icons.arrow_forward, l10n.profit, '120k'),
        ],
      ),
    );
  }

  Widget _buildModernAction(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFF388540), size: sizes.iconMd),
        const SizedBox(height: sizes.xs),
        Text(
          label,
          style: const TextStyle(color: Colors.grey, fontSize: sizes.fontSizeSm),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Color(0xFF384A24),
            fontWeight: FontWeight.bold,
            fontSize: sizes.fontSizeSm,
          ),
        ),
      ],
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      height: sizes.xl,
      width: 1,
      color: Colors.grey.withOpacity(0.3),
    );
  }
}
