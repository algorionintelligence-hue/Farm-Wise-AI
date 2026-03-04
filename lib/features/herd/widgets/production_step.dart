import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/sizes.dart';
import '../viewmodel/herd_viewmodel.dart';
import 'custom_input.dart';

class ProductionStep extends ConsumerWidget {
  const ProductionStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(herdProvider.notifier);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: sizes.md),

        child: Column(
          children: [
            CustomInput(
                label: "Avg Milk / Day",
                controller: vm.avgMilkController),
            CustomInput(
                label: "Milk Price",
                controller: vm.milkPriceController),
            CustomInput(
                label: "Feed Cost",
                controller: vm.feedCostController),
            CustomInput(
                label: "Medical Cost",
                controller: vm.medicalCostController),
            CustomInput(
                label: "Labor Cost",
                controller: vm.laborCostController),
      
            const SizedBox(height: 20),
      
            Text(
              "Projected Profit: ${vm.monthlyProfit().toStringAsFixed(0)}",
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}