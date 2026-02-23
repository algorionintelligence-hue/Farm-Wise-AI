import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DatePickerButton extends ConsumerWidget {
  final DateTime? selectedDate;
  final Function(DateTime) onDateSelected;

  const DatePickerButton({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton.icon(
      onPressed: () async {
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
      icon: const Icon(Icons.calendar_today),
      label: Text(
        selectedDate == null
            ? 'Select Date'
            : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
      ),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}