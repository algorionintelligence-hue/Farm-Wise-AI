import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/Utils/sizes.dart';
import '../../../core/themes/app_colors.dart';
import '../viewmodel/herd_viewmodel.dart';
import 'DatePickerTile.dart';




class BreedingStep extends ConsumerWidget {
  const BreedingStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(herdProvider);              // ✅ Fix: state change pe rebuild hoga
    final vm = ref.watch(herdProvider.notifier);

    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: sizes.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Section Label ──────────────────────────
          const Text(
            "Breeding Dates",
            style: TextStyle(
              fontSize: sizes.fontSizeMd,
              fontWeight: FontWeight.w800,
              color: UColors.colorPrimary,
            ),
          ),
          const SizedBox(height: sizes.xs),
          const Text(
            "Select relevant dates for breeding tracking",
            style: TextStyle(
              fontSize: sizes.fontSizeSm,
              color: UColors.textSecondary,
            ),
          ),

          const SizedBox(height: sizes.md),

          // ── Service Date ───────────────────────────
          DatePickerTile(
            icon: Icons.favorite_rounded,
            label: "Service Date",
            selectedDate: vm.serviceDate,
            onPicked: (date) {
              vm.serviceDate = date;
              ref.read(herdProvider.notifier).refreshDates();
            },
          ),

          const SizedBox(height: sizes.sm),

          // ── PD Date ────────────────────────────────
          DatePickerTile(
            icon: Icons.medical_services_rounded,
            label: "PD Date",
            selectedDate: vm.pdDate,
            onPicked: (date) {
              vm.pdDate = date;
              ref.read(herdProvider.notifier).refreshDates();
            },
          ),

          const SizedBox(height: sizes.sm),

          // ── Calving Date ───────────────────────────
          DatePickerTile(
            icon: Icons.child_care_rounded,
            label: "Calving Date",
            selectedDate: vm.calvingDate,
            onPicked: (date) {
              vm.calvingDate = date;
              ref.read(herdProvider.notifier).refreshDates();
            },
          ),

          const SizedBox(height: sizes.md),

          // ── Expected Calves Card ───────────────────
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
                    Icons.pets_rounded,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Expected Calves (3/6 months)",
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.white70,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      vm.expectedCalves().toString(),
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
    );
  }
}
