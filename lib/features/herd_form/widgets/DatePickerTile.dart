import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/utils/sizes.dart';
import '../../../core/themes/app_colors.dart';
import '../../../l10n/app_localizations.dart';

class DatePickerTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final DateTime? selectedDate;
  final void Function(DateTime) onPicked;

  const DatePickerTile({
    super.key,
    required this.icon,
    required this.label,
    required this.selectedDate,
    required this.onPicked,
  });

  String _formattedDate(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (selectedDate == null) return l10n.tapToSelect;
    return DateFormat('d MMM yyyy', l10n.localeName).format(selectedDate!);
  }

  @override
  Widget build(BuildContext context) {
    final bool hasDate = selectedDate != null;

    return GestureDetector(
      onTap: () async {
        // ? Fix: keyboard band karo, Labor Cost focus na jaye
        FocusScope.of(context).unfocus();
        await Future.delayed(const Duration(milliseconds: 150));

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
            // ? Icon Box
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

            // ? Label + Date
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
                    _formattedDate(context),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight:
                          hasDate ? FontWeight.w600 : FontWeight.normal,
                      color: hasDate
                          ? UColors.colorPrimary.withOpacity(0.8)
                          : UColors.darkGrey,
                    ),
                  ),
                ],
              ),
            ),

            // ? Trailing Icon
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
