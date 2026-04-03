import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils/sizes.dart';
import '../../../l10n/app_localizations.dart';
import '../viewmodel/herd_viewmodel.dart';
import 'CustomInput.dart';


import '../../../core/themes/app_colors.dart';


class ProductionStep extends ConsumerWidget {
  const ProductionStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(herdProvider.notifier);
    final l10n = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: sizes.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Inputs ──────────────────────────────
            CustomInput(
              label: l10n.avgMilkPerDayLitres,
              controller: vm.avgMilkController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            CustomInput(
              label: l10n.milkPricePerLitre,
              controller: vm.milkPriceController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            CustomInput(
              label: l10n.feedCostMonthly,
              controller: vm.feedCostController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            CustomInput(
              label: l10n.medicalCostMonthly,
              controller: vm.medicalCostController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            CustomInput(
              label: l10n.laborCostMonthly,
              controller: vm.laborCostController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),

            const SizedBox(height: sizes.md),

            // ── Projected Profit Card ────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
              decoration: BoxDecoration(
                color: UColors.colorPrimary,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.trending_up_rounded,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.projectedMonthlyProfit,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.white70,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "PKR ${vm.monthlyProfit().toStringAsFixed(0)}",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
