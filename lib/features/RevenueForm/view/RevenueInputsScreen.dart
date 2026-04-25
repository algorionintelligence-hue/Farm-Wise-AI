import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../core/themes/app_colors.dart';
import '../../../core/utils/sizes.dart';
import '../../../core/widgets/AppScaffoldBgBasic.dart';
import '../../../core/widgets/PrimaryButton.dart';
import '../../../l10n/AppLocalizations.dart';

import '../../HerdForm/widgets/CustomInput.dart';
import '../../HerdForm/widgets/DatePickerTile.dart';
import '../model/revenue_record.dart';
import '../viewmodel/revenue_store.dart';

class RevenueInputsScreen extends ConsumerStatefulWidget {
  const RevenueInputsScreen({super.key});

  @override
  ConsumerState<RevenueInputsScreen> createState() => _RevenueInputsScreenState();
}

class _RevenueInputsScreenState extends ConsumerState<RevenueInputsScreen> {
  final _animalTagCtrl = TextEditingController();
  final _quantityCtrl = TextEditingController();
  final _unitPriceCtrl = TextEditingController();
  final _commissionCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();

  DateTime? _revenueDate;
  String? _revenueType;

  final _revenueTypes = [
    'Stud fee',
    'Milk sale',
    'Animal sale',
    'Other',
  ];

  @override
  void dispose() {
    _animalTagCtrl.dispose();
    _quantityCtrl.dispose();
    _unitPriceCtrl.dispose();
    _commissionCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  double get _netAmount {
    final quantity = double.tryParse(_quantityCtrl.text) ?? 0;
    final unitPrice = double.tryParse(_unitPriceCtrl.text) ?? 0;
    final commission = double.tryParse(_commissionCtrl.text) ?? 0;
    return (quantity * unitPrice) - commission;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AppScaffoldBgBasic(
      showBackButton: true,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add Revenue',
              style: const TextStyle(
                fontSize: sizes.fontSizeHeadings,
                fontWeight: FontWeight.bold,
                color: UColors.colorPrimary,
              ),
            ),
            const SizedBox(height: sizes.sm),
            const Text(
              'Record farm income from any source.',
              style: TextStyle(
                fontSize: sizes.fontSizeSm,
                color: UColors.textSecondary,
                height: 1.5,
              ),
            ),
            const SizedBox(height: sizes.defaultSpace),
            CustomInput(
              label: 'Animal (if applicable)',
              hintText: l10n.searchByTagNumber,
              controller: _animalTagCtrl,
            ),
            DatePickerTile(
              icon: Icons.calendar_today_rounded,
              label: 'Revenue date *',
              selectedDate: _revenueDate,
              onPicked: (date) => setState(() => _revenueDate = date),
            ),
            _buildDropdown(
              label: 'Revenue type *',
              value: _revenueType,
              options: _revenueTypes,
              onChanged: (value) => setState(() => _revenueType = value),
            ),
            const SizedBox(height: sizes.defaultSpace),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(sizes.md),
              decoration: BoxDecoration(
                color: UColors.light,
                borderRadius: BorderRadius.circular(sizes.cardRadiusLg),
                border: Border.all(color: UColors.borderPrimary),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Amount breakdown',
                    style: TextStyle(
                      fontSize: sizes.fontSizeMd,
                      fontWeight: FontWeight.bold,
                      color: UColors.colorPrimary,
                    ),
                  ),
                  const SizedBox(height: sizes.sm),
                  CustomInput(
                    label: 'Quantity *',
                    controller: _quantityCtrl,
                    keyboardType: TextInputType.number,
                    onChanged: (_) => setState(() {}),
                  ),
                  CustomInput(
                    label: 'Unit price (PKR) *',
                    controller: _unitPriceCtrl,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    onChanged: (_) => setState(() {}),
                  ),
                  CustomInput(
                    label: 'Commission (PKR)',
                    controller: _commissionCtrl,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    onChanged: (_) => setState(() {}),
                  ),
                ],
              ),
            ),
            const SizedBox(height: sizes.defaultSpace),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(sizes.md),
              decoration: BoxDecoration(
                color: UColors.colorPrimary,
                borderRadius: BorderRadius.circular(sizes.cardRadiusLg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Net amount',
                    style: TextStyle(
                      color: UColors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: sizes.fontSizeMd,
                    ),
                  ),
                  const SizedBox(height: sizes.sm),
                  Text(
                    'PKR ${_netAmount.toStringAsFixed(0)}',
                    style: const TextStyle(
                      color: UColors.white,
                      fontSize: sizes.fontSizeHeadings,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: sizes.xs),
                  const Text(
                    'Quantity × Unit price − Commission',
                    style: TextStyle(
                      color: UColors.white,
                      fontSize: sizes.fontSizeSm,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: sizes.defaultSpace),
            const Text(
              'Notes',
              style: TextStyle(
                fontSize: sizes.fontSizeSm,
                fontWeight: FontWeight.w800,
                color: UColors.colorPrimary,
              ),
            ),
            const SizedBox(height: sizes.xs),
            TextField(
              controller: _notesCtrl,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Buyer name, transaction details...',
                hintStyle: const TextStyle(color: UColors.darkGrey),
                filled: true,
                fillColor: UColors.inputBg,
                contentPadding: const EdgeInsets.all(sizes.md),
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
            const SizedBox(height: sizes.defaultSpace),
            PrimaryButton(
              label: 'Save revenue record',
              onPressed: () => _saveRevenue(context),
            ),
            const SizedBox(height: sizes.defaultSpace),
          ],
        ),
      ),
    );
  }

  Future<void> _saveRevenue(BuildContext context) async {
    FocusScope.of(context).unfocus();

    // Validate required fields
    if (_revenueDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select revenue date')),
      );
      return;
    }

    if (_revenueType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select revenue type')),
      );
      return;
    }

    final quantity = double.tryParse(_quantityCtrl.text);
    if (quantity == null || quantity <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid quantity')),
      );
      return;
    }

    final unitPrice = double.tryParse(_unitPriceCtrl.text);
    if (unitPrice == null || unitPrice <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid unit price')),
      );
      return;
    }

    try {
      final commission = double.tryParse(_commissionCtrl.text) ?? 0;
      final netAmount = (quantity * unitPrice) - commission;

      final record = RevenueRecord(
        id: const Uuid().v4(),
        animalRef: _animalTagCtrl.text.isNotEmpty ? _animalTagCtrl.text : 'General',
        revenueDate: _revenueDate!,
        revenueType: _revenueType!,
        quantity: quantity,
        unitPrice: unitPrice,
        commission: commission,
        notes: _notesCtrl.text.isNotEmpty ? _notesCtrl.text : null,
      );

      // Access the store and add the record
      // ignore: use_build_context_synchronously
      await ref.read(revenueStoreProvider.notifier).add(record);

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Revenue record saved: PKR ${netAmount.toStringAsFixed(0)}'),
          backgroundColor: UColors.colorPrimary,
        ),
      );

      // Clear form
      _animalTagCtrl.clear();
      _quantityCtrl.clear();
      _unitPriceCtrl.clear();
      _commissionCtrl.clear();
      _notesCtrl.clear();
      setState(() {
        _revenueDate = null;
        _revenueType = null;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving record: $e')),
      );
    }
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> options,
    required void Function(String?) onChanged,
  }) {
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
          Container(
            decoration: BoxDecoration(
              color: UColors.inputBg,
              borderRadius: BorderRadius.circular(sizes.inputFieldRadius),
              border: Border.all(color: UColors.borderPrimary),
            ),
            padding: const EdgeInsets.symmetric(horizontal: sizes.md),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: value,
                hint: const Text(
                  'Select type',
                  style: TextStyle(fontSize: sizes.fontSizeSm, color: UColors.darkGrey),
                ),
                isExpanded: true,
                items: options
                    .map(
                      (option) => DropdownMenuItem<String>(
                        value: option,
                        child: Text(option, style: const TextStyle(fontSize: sizes.fontSizeSm)),
                      ),
                    )
                    .toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
