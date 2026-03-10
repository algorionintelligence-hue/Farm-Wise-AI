import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/sizes.dart';
import '../themes/app_colors.dart';

class DatePickerField extends ConsumerWidget {
  final String labelText;
  final DateTime? selectedDate;
  final Function(DateTime) onDateSelected;

  const DatePickerField({
    super.key,
    required this.labelText,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label (Same as PlantaTextField)
        Text(
          labelText,
          style: const TextStyle(
            fontSize: sizes.fontSizeSm,
            fontWeight: FontWeight.w800,
            color: UColors.colorPrimary,
          ),
        ),
        const SizedBox(height: sizes.sm),

        GestureDetector(
          onTap: () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: selectedDate ?? DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            );

            if (picked != null) {
              onDateSelected(picked);
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: sizes.md,
              vertical: sizes.md,
            ),
            decoration: BoxDecoration(
              color: UColors.inputBg,
              borderRadius:
              BorderRadius.circular(sizes.inputFieldRadius),
              border: Border.all(
                color: UColors.borderPrimary,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedDate == null
                      ? "Select Starting Date of the Month"
                      : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                  style: TextStyle(
                    fontSize: sizes.fontSizeSm,
                    color: selectedDate == null
                        ? UColors.darkGrey
                        : UColors.textPrimary,
                  ),
                ),
                const Icon(
                  Icons.calendar_today,
                  color: UColors.colorPrimary,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
