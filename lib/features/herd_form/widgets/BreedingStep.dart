import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/Utils/sizes.dart';
import '../../../core/themes/app_colors.dart';
import '../viewmodel/herd_viewmodel.dart';

class BreedingStep extends ConsumerWidget {
  const BreedingStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(herdProvider.notifier);

    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: sizes.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Section Label ─────────────────────────
          const Text(
            "Breeding Dates",
            style: TextStyle(
              fontSize: sizes.fontSizeMd,
              fontWeight: FontWeight.w800,
              color: UColors.colorPrimary,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            "Select relevant dates for breeding tracking",
            style: TextStyle(
              fontSize: sizes.fontSizeSm,
              color: UColors.textSecondary,
            ),
          ),

          const SizedBox(height: 24),

          // ── Service Date ──────────────────────────
          _DatePickerTile(
            icon: Icons.favorite_rounded,
            label: "Service Date",
            selectedDate: vm.serviceDate,
            onPicked: (date) {
              vm.serviceDate = date;
              ref.read(herdProvider.notifier).refreshDates();
            },
          ),

          const SizedBox(height: 12),

          // ── PD Date ───────────────────────────────
          _DatePickerTile(
            icon: Icons.medical_services_rounded,
            label: "PD Date",
            selectedDate: vm.pdDate,
            onPicked: (date) {
              vm.pdDate = date;
              ref.read(herdProvider.notifier).refreshDates();
            },
          ),

          const SizedBox(height: 12),

          // ── Calving Date ──────────────────────────
          _DatePickerTile(
            icon: Icons.child_care_rounded,
            label: "Calving Date",
            selectedDate: vm.calvingDate,
            onPicked: (date) {
              vm.calvingDate = date;
              ref.read(herdProvider.notifier).refreshDates();
            },
          ),

          const SizedBox(height: 24),

          // ── Expected Calves Result Card ───────────
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


// ═══════════════════════════════════════════════
// Reusable Date Picker Tile
// ═══════════════════════════════════════════════

class _DatePickerTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final DateTime? selectedDate;
  final void Function(DateTime) onPicked;

  const _DatePickerTile({
    required this.icon,
    required this.label,
    required this.selectedDate,
    required this.onPicked,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasDate = selectedDate != null;
    final String dateText = hasDate
        ? selectedDate!.toLocal().toString().split(' ')[0]
        : "Tap to select";

    return GestureDetector(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          firstDate: DateTime(2020),
          lastDate: DateTime(2035),
          initialDate: selectedDate ?? DateTime.now(),
          builder: (context, child) => Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: UColors.colorPrimary,
                onPrimary: Colors.white,
                surface: Colors.white,
                onSurface: UColors.textPrimary,
              ),
            ),
            child: child!,
          ),
        );
        if (picked != null) onPicked(picked);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: hasDate
              ? UColors.colorPrimary.withOpacity(0.06)
              : UColors.inputBg,
          borderRadius: BorderRadius.circular(sizes.inputFieldRadius),
          border: Border.all(
            color: hasDate ? UColors.colorPrimary : UColors.borderPrimary,
            width: hasDate ? 1.5 : 1.0,
          ),
        ),
        child: Row(
          children: [
            // Icon
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: hasDate
                    ? UColors.colorPrimary.withOpacity(0.12)
                    : UColors.grey.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                size: 18,
                color: hasDate ? UColors.colorPrimary : UColors.darkGrey,
              ),
            ),

            const SizedBox(width: 14),

            // Label + Value
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: sizes.fontSizeSm,
                      fontWeight: FontWeight.w700,
                      color: hasDate
                          ? UColors.colorPrimary
                          : UColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    dateText,
                    style: TextStyle(
                      fontSize: 12,
                      color: hasDate
                          ? UColors.colorPrimary.withOpacity(0.7)
                          : UColors.darkGrey,
                    ),
                  ),
                ],
              ),
            ),

            // Calendar icon / check
            Icon(
              hasDate
                  ? Icons.check_circle_rounded
                  : Icons.calendar_today_rounded,
              size: 18,
              color: hasDate ? UColors.colorPrimary : UColors.darkGrey,
            ),
          ],
        ),
      ),
    );
  }
}