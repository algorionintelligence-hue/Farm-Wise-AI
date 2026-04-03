import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils/sizes.dart';
import '../../../core/themes/app_colors.dart';
import '../../../l10n/app_localizations.dart';
import '../viewmodel/herd_viewmodel.dart';
import 'DatePickerTile.dart';




class BreedingStep extends ConsumerWidget {
  const BreedingStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(herdProvider);              // ✅ Fix: state change pe rebuild hoga
    final vm = ref.watch(herdProvider.notifier);
    final l10n = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: sizes.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Section Label ──────────────────────────
          Text(
            l10n.breedingDatesTitle,
            style: const TextStyle(
              fontSize: sizes.fontSizeMd,
              fontWeight: FontWeight.w800,
              color: UColors.colorPrimary,
            ),
          ),
          const SizedBox(height: sizes.xs),
          Text(
            l10n.breedingDatesSubtitle,
            style: const TextStyle(
              fontSize: sizes.fontSizeSm,
              color: UColors.textSecondary,
            ),
          ),

          const SizedBox(height: sizes.md),

          // ── Service Date ───────────────────────────
          DatePickerTile(
            icon: Icons.favorite_rounded,
            label: l10n.serviceDate,
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
            label: l10n.pdDate,
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
            label: l10n.calvingDate,
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
                    Text(
                      l10n.expectedCalves36Months,
                      style: const TextStyle(
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

