import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/Utils/sizes.dart';
import '../viewmodel/herd_viewmodel.dart';
import 'CustomInput.dart';


import '../../../core/themes/app_colors.dart';


class ProductionStep extends ConsumerWidget {
  const ProductionStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(herdProvider.notifier);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: sizes.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Inputs ──────────────────────────────
            CustomInput(
              label: "Avg Milk / Day (litres)",
              controller: vm.avgMilkController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            CustomInput(
              label: "Milk Price (per litre)",
              controller: vm.milkPriceController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            CustomInput(
              label: "Feed Cost (monthly)",
              controller: vm.feedCostController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            CustomInput(
              label: "Medical Cost (monthly)",
              controller: vm.medicalCostController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            CustomInput(
              label: "Labor Cost (monthly)",
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
                      const Text(
                        "Projected Monthly Profit",
                        style: TextStyle(
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