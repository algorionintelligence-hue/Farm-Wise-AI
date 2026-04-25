import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/themes/app_colors.dart';
import '../../../core/utils/sizes.dart';
import '../../../core/widgets/AppScaffoldBgBasic.dart';
import '../../../core/widgets/PrimaryButton.dart';
import '../../HerdForm/widgets/CustomInput.dart';
import '../../HerdForm/widgets/DatePickerTile.dart';


enum LedgerEntryType { expense, income }

class AddLedgerEntryScreen extends ConsumerStatefulWidget {
  const AddLedgerEntryScreen({super.key});

  @override
  ConsumerState<AddLedgerEntryScreen> createState() => _AddLedgerEntryScreenState();
}

class _AddLedgerEntryScreenState extends ConsumerState<AddLedgerEntryScreen> {
  LedgerEntryType _type = LedgerEntryType.expense;
  DateTime? _entryDate;

  String? _category;
  final _subCategoryCtrl = TextEditingController();
  final _amountCtrl = TextEditingController(text: '0');
  String _paymentMode = 'Cash';
  final _vendorCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();

  @override
  void dispose() {
    _subCategoryCtrl.dispose();
    _amountCtrl.dispose();
    _vendorCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  double get _amount => double.tryParse(_amountCtrl.text) ?? 0;

  @override
  Widget build(BuildContext context) {
    final isExpense = _type == LedgerEntryType.expense;
    final accent = isExpense ? const Color(0xFFE57373) : const Color(0xFF5CB85C);

    return AppScaffoldBgBasic(
      showBackButton: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Add Ledger Entry',
            style: TextStyle(
              fontSize: sizes.fontSizeHeadings,
              fontWeight: FontWeight.bold,
              color: UColors.colorPrimary,
            ),
          ),
          const SizedBox(height: 2),
          const Text(
            'Record farm income or expense',
            style: TextStyle(fontSize: sizes.fontSizeSm, color: UColors.textSecondary),
          ),
          const SizedBox(height: sizes.defaultSpace),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Segmented(
                    leftLabel: 'Expense',
                    rightLabel: 'Income',
                    leftActive: isExpense,
                    accent: accent,
                    onLeft: () => setState(() => _type = LedgerEntryType.expense),
                    onRight: () => setState(() => _type = LedgerEntryType.income),
                  ),
                  const SizedBox(height: sizes.sm),
                  DatePickerTile(
                    icon: Icons.calendar_today_rounded,
                    label: 'Entry date *',
                    selectedDate: _entryDate,
                    onPicked: (d) => setState(() => _entryDate = d),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _SelectTile(
                          label: 'Category *',
                          value: _category,
                          placeholder: 'Select',
                          onTap: () async {
                            final picked = await _pickFromSheet(
                              context,
                              title: 'Category',
                              options: const [
                                'Feed',
                                'Vet/Medicine',
                                'Labour',
                                'Utilities',
                                'Transport',
                                'Sales',
                                'Other',
                              ],
                            );
                            if (picked != null) setState(() => _category = picked);
                          },
                        ),
                      ),
                      const SizedBox(width: sizes.sm),
                      Expanded(
                        child: CustomInput(
                          label: 'Sub category',
                          hintText: 'e.g. Wheat bran',
                          controller: _subCategoryCtrl,
                        ),
                      ),
                    ],
                  ),
                  CustomInput(
                    label: 'Amount (PKR) *',
                    controller: _amountCtrl,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    onChanged: (_) => setState(() {}),
                  ),
                  const SizedBox(height: sizes.xs),
                  const Text(
                    'Payment details',
                    style: TextStyle(
                      fontSize: sizes.fontSizeSm,
                      fontWeight: FontWeight.w800,
                      color: UColors.colorPrimary,
                    ),
                  ),
                  const SizedBox(height: sizes.xs),
                  _ChipsRow(
                    label: 'Payment mode *',
                    value: _paymentMode,
                    options: const ['Cash', 'Bank transfer', 'Credit'],
                    onChanged: (v) => setState(() => _paymentMode = v),
                  ),
                  CustomInput(
                    label: 'Vendor name',
                    hintText: 'Supplier / person name',
                    controller: _vendorCtrl,
                  ),
                  _NotesField(
                    label: 'Notes',
                    hintText: 'Optional description...',
                    controller: _notesCtrl,
                  ),
                  _TotalBar(
                    label: isExpense ? 'Total expense' : 'Total income',
                    value: 'PKR ${_amount.toStringAsFixed(0)}',
                  ),
                  const SizedBox(height: sizes.spaceBtwSections),
                  PrimaryButton(
                    label: 'Save entry',
                    onPressed: () {},
                  ),
                  const SizedBox(height: sizes.defaultSpace),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Segmented extends StatelessWidget {
  final String leftLabel;
  final String rightLabel;
  final bool leftActive;
  final Color accent;
  final VoidCallback onLeft;
  final VoidCallback onRight;

  const _Segmented({
    required this.leftLabel,
    required this.rightLabel,
    required this.leftActive,
    required this.accent,
    required this.onLeft,
    required this.onRight,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: onLeft,
            child: Container(
              height: 44,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: leftActive ? accent.withOpacity(0.18) : Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: leftActive ? accent : UColors.borderPrimary),
              ),
              child: Text(
                leftLabel,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: leftActive ? accent : UColors.textSecondary,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: sizes.sm),
        Expanded(
          child: GestureDetector(
            onTap: onRight,
            child: Container(
              height: 44,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: !leftActive ? accent.withOpacity(0.18) : Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: !leftActive ? accent : UColors.borderPrimary),
              ),
              child: Text(
                rightLabel,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: !leftActive ? accent : UColors.textSecondary,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ChipsRow extends StatelessWidget {
  final String label;
  final String value;
  final List<String> options;
  final ValueChanged<String> onChanged;

  const _ChipsRow({
    required this.label,
    required this.value,
    required this.options,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: sizes.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: sizes.fontSizeSm,
              fontWeight: FontWeight.w800,
              color: UColors.colorPrimary,
            ),
          ),
          const SizedBox(height: sizes.xs),
          Row(
            children: options.map((o) {
              final active = o == value;
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: o == options.last ? 0 : sizes.xs),
                  child: GestureDetector(
                    onTap: () => onChanged(o),
                    child: Container(
                      height: 44,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: active ? UColors.colorPrimary.withOpacity(0.10) : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: active ? UColors.colorPrimary : UColors.borderPrimary,
                          width: active ? 1.5 : 1.0,
                        ),
                      ),
                      child: Text(
                        o,
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: active ? UColors.colorPrimary : UColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _NotesField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;

  const _NotesField({
    required this.label,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: sizes.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: sizes.fontSizeSm,
              fontWeight: FontWeight.w800,
              color: UColors.colorPrimary,
            ),
          ),
          const SizedBox(height: sizes.xs),
          TextField(
            controller: controller,
            maxLines: 4,
            style: const TextStyle(fontSize: sizes.fontSizeSm, color: UColors.textPrimary),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(fontSize: sizes.fontSizeSm, color: UColors.darkGrey),
              filled: true,
              fillColor: UColors.inputBg,
              contentPadding: const EdgeInsets.symmetric(horizontal: sizes.md, vertical: sizes.md),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(sizes.inputFieldRadius),
                borderSide: const BorderSide(color: UColors.borderPrimary),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(sizes.inputFieldRadius),
                borderSide: const BorderSide(color: UColors.borderPrimary),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(sizes.inputFieldRadius),
                borderSide: const BorderSide(color: UColors.colorPrimary, width: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TotalBar extends StatelessWidget {
  final String label;
  final String value;

  const _TotalBar({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: sizes.sm),
      padding: const EdgeInsets.symmetric(horizontal: sizes.md, vertical: sizes.sm),
      decoration: BoxDecoration(
        color: UColors.inputBg,
        borderRadius: BorderRadius.circular(sizes.cardRadiusMd),
        border: Border.all(color: UColors.borderPrimary),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: sizes.fontSizeSm,
              fontWeight: FontWeight.w700,
              color: UColors.textSecondary,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              fontSize: sizes.fontSizeSm,
              fontWeight: FontWeight.w800,
              color: UColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _SelectTile extends StatelessWidget {
  final String label;
  final String? value;
  final String placeholder;
  final VoidCallback onTap;

  const _SelectTile({
    required this.label,
    required this.value,
    required this.placeholder,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasValue = value != null && value!.trim().isNotEmpty;

    return Padding(
      padding: const EdgeInsets.only(bottom: sizes.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: sizes.fontSizeSm,
              fontWeight: FontWeight.w800,
              color: UColors.colorPrimary,
            ),
          ),
          const SizedBox(height: sizes.xs),
          GestureDetector(
            onTap: onTap,
            child: Container(
              height: 52,
              padding: const EdgeInsets.symmetric(horizontal: sizes.md),
              decoration: BoxDecoration(
                color: hasValue ? UColors.colorPrimary.withOpacity(0.06) : UColors.inputBg,
                borderRadius: BorderRadius.circular(sizes.inputFieldRadius),
                border: Border.all(
                  color: hasValue ? UColors.colorPrimary : UColors.borderPrimary,
                  width: hasValue ? 1.5 : 1.0,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      hasValue ? value! : placeholder,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: sizes.fontSizeSm,
                        color: hasValue ? UColors.textPrimary : UColors.darkGrey,
                        fontWeight: hasValue ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  ),
                  Icon(
                    hasValue ? Icons.check_circle_rounded : Icons.keyboard_arrow_down_rounded,
                    color: hasValue ? UColors.colorPrimary : UColors.darkGrey,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<String?> _pickFromSheet(
  BuildContext context, {
  required String title,
  required List<String> options,
}) {
  return showModalBottomSheet<String>(
    context: context,
    showDragHandle: true,
    backgroundColor: Colors.white,
    builder: (context) {
      final maxHeight = MediaQuery.of(context).size.height * 0.70;
      return SafeArea(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: maxHeight),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(sizes.md, sizes.sm, sizes.md, sizes.md),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: sizes.fontSizeMd,
                    fontWeight: FontWeight.w800,
                    color: UColors.colorPrimary,
                  ),
                ),
                const SizedBox(height: sizes.sm),
                Flexible(
                  child: ListView.builder(
                    itemCount: options.length,
                    itemBuilder: (context, i) {
                      final opt = options[i];
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          opt,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        onTap: () => Navigator.pop(context, opt),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

