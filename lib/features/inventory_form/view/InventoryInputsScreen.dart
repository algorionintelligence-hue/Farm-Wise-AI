import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/themes/app_colors.dart';
import '../../../core/utils/sizes.dart';
import '../../../core/widgets/AppScaffoldBgBasic.dart';
import '../../../core/widgets/PrimaryButton.dart';
import '../../../features/herd_form/widgets/CustomInput.dart';
import '../../../features/herd_form/widgets/DatePickerTile.dart';
import '../../../l10n/app_localizations.dart';

class InventoryInputsScreen extends ConsumerStatefulWidget {
  const InventoryInputsScreen({super.key});

  @override
  ConsumerState<InventoryInputsScreen> createState() => _InventoryInputsScreenState();
}

class _InventoryInputsScreenState extends ConsumerState<InventoryInputsScreen> {
  final _itemNameCtrl = TextEditingController();
  final _reorderLevelCtrl = TextEditingController();
  final _overstockLevelCtrl = TextEditingController();
  final _transactionItemCtrl = TextEditingController();
  final _transactionQtyCtrl = TextEditingController();
  DateTime? _transactionDate;
  String? _category;
  String? _unit;
  String? _transactionType;
  bool _isAddItem = true;

  final _categories = ['Feed', 'Medicine', 'Minerals', 'Seeds', 'Other'];
  final _units = ['kg', 'litre', 'bag', 'piece', 'unit'];
  final _transactionTypes = ['Purchase', 'Issue', 'Adjustment'];

  @override
  void dispose() {
    _itemNameCtrl.dispose();
    _reorderLevelCtrl.dispose();
    _overstockLevelCtrl.dispose();
    _transactionItemCtrl.dispose();
    _transactionQtyCtrl.dispose();
    super.dispose();
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
              l10n.inventory,
              style: const TextStyle(
                fontSize: sizes.fontSizeHeadings,
                fontWeight: FontWeight.bold,
                color: UColors.colorPrimary,
              ),
            ),
            const SizedBox(height: sizes.sm),
            Text(
              'Manage stock items, thresholds and transactions from a single place.',
              style: const TextStyle(
                fontSize: sizes.fontSizeSm,
                color: UColors.textSecondary,
                height: 1.5,
              ),
            ),
            const SizedBox(height: sizes.defaultSpace),
            Row(
              children: [
                _buildTab('Add Item', _isAddItem),
                const SizedBox(width: sizes.sm),
                _buildTab('Add Transaction', !_isAddItem),
              ],
            ),
            const SizedBox(height: sizes.defaultSpace),
            if (_isAddItem) _buildAddItemForm(context) else _buildAddTransactionForm(context),
            const SizedBox(height: sizes.defaultSpace),
            PrimaryButton(
              label: _isAddItem ? 'Save item' : 'Save transaction',
              onPressed: () {
                FocusScope.of(context).unfocus();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      _isAddItem ? 'Item saved successfully.' : 'Transaction saved successfully.',
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(String label, bool isActive) {
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _isAddItem = label == 'Add Item'),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: sizes.sm),
          decoration: BoxDecoration(
            color: isActive ? UColors.colorPrimary : UColors.white,
            borderRadius: BorderRadius.circular(sizes.borderRadiusMd),
            border: Border.all(color: UColors.borderPrimary),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isActive ? UColors.white : UColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> options,
    required void Function(String?) onChanged,
    String? hint,
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
                hint: Text(
                  hint ?? 'Select $label',
                  style: const TextStyle(fontSize: sizes.fontSizeSm, color: UColors.darkGrey),
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

  Widget _buildAddItemForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomInput(
          label: 'Item name *',
          hintText: 'e.g. Wheat bran, Tetracycline...',
          controller: _itemNameCtrl,
          keyboardType: TextInputType.text,
        ),
        _buildDropdown(
          label: 'Category *',
          value: _category,
          options: _categories,
          onChanged: (value) => setState(() => _category = value),
          hint: 'Select',
        ),
        _buildDropdown(
          label: 'Unit of measure *',
          value: _unit,
          options: _units,
          onChanged: (value) => setState(() => _unit = value),
          hint: 'Select',
        ),
        const SizedBox(height: sizes.md),
        Text(
          'Stock thresholds',
          style: const TextStyle(
            fontSize: sizes.fontSizeMd,
            fontWeight: FontWeight.w700,
            color: UColors.colorPrimary,
          ),
        ),
        const SizedBox(height: sizes.sm),
        Row(
          children: [
            Expanded(
              child: CustomInput(
                label: 'Reorder level',
                controller: _reorderLevelCtrl,
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: sizes.sm),
            Expanded(
              child: CustomInput(
                label: 'Overstock level',
                controller: _overstockLevelCtrl,
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
        const SizedBox(height: sizes.xs),
        Text(
          _unit == null ? '— select unit' : 'Unit: $_unit',
          style: TextStyle(
            color: UColors.textSecondary,
            fontSize: sizes.fontSizeSm,
          ),
        ),
      ],
    );
  }

  Widget _buildAddTransactionForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomInput(
          label: 'Item name *',
          hintText: 'e.g. Wheat bran, Tetracycline...',
          controller: _transactionItemCtrl,
          keyboardType: TextInputType.text,
        ),
        _buildDropdown(
          label: 'Transaction type *',
          value: _transactionType,
          options: _transactionTypes,
          onChanged: (value) => setState(() => _transactionType = value),
          hint: 'Select',
        ),
        CustomInput(
          label: 'Quantity *',
          controller: _transactionQtyCtrl,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
        ),
        const SizedBox(height: sizes.sm),
        DatePickerTile(
          icon: Icons.calendar_today_rounded,
          label: 'Transaction date',
          selectedDate: _transactionDate,
          onPicked: (date) => setState(() => _transactionDate = date),
        ),
        const SizedBox(height: sizes.sm),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(sizes.md),
          decoration: BoxDecoration(
            color: UColors.light,
            borderRadius: BorderRadius.circular(sizes.cardRadiusLg),
            border: Border.all(color: UColors.borderPrimary),
          ),
          child: const Text(
            'Transactions track stock movement and help keep reorder levels accurate.',
            style: TextStyle(color: UColors.textSecondary),
          ),
        ),
      ],
    );
  }
}
