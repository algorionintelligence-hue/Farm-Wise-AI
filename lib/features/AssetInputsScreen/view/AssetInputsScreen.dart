import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/themes/app_colors.dart';
import '../../../core/utils/sizes.dart';
import '../../../core/widgets/AppScaffoldBgBasic.dart';
import '../../../core/widgets/PrimaryButton.dart';
import '../../HerdForm/widgets/CustomInput.dart';
import '../../HerdForm/widgets/DatePickerTile.dart';


class AssetInputsScreen extends ConsumerStatefulWidget {
  const AssetInputsScreen({super.key});

  @override
  ConsumerState<AssetInputsScreen> createState() => _AssetInputsScreenState();
}

class _AssetInputsScreenState extends ConsumerState<AssetInputsScreen> {
  final _assetNameCtrl = TextEditingController();
  final _purchaseCostCtrl = TextEditingController();
  final _usefulLifeCtrl = TextEditingController();
  final _salvageValueCtrl = TextEditingController();
  DateTime? _purchaseDate;
  String? _assetType;

  final _assetTypes = ['Tractor', 'Milking machine', 'Water pump', 'Generator', 'Other'];

  @override
  void dispose() {
    _assetNameCtrl.dispose();
    _purchaseCostCtrl.dispose();
    _usefulLifeCtrl.dispose();
    _salvageValueCtrl.dispose();
    super.dispose();
  }

  double get _monthlyDepreciation {
    final cost = double.tryParse(_purchaseCostCtrl.text) ?? 0;
    final salvage = double.tryParse(_salvageValueCtrl.text) ?? 0;
    final life = double.tryParse(_usefulLifeCtrl.text) ?? 0;
    if (life <= 0) return 0;
    return ((cost - salvage) / life).clamp(0, double.infinity);
  }

  double get _annualDepreciation => _monthlyDepreciation * 12;

  @override
  Widget build(BuildContext context) {
    return AppScaffoldBgBasic(
      showBackButton: true,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: sizes.sm),
            const Text(
              'Add Farm Asset',
              style: TextStyle(
                fontSize: sizes.fontSizeHeadings,
                fontWeight: FontWeight.bold,
                color: UColors.colorPrimary,
              ),
            ),
            const SizedBox(height: sizes.sm),
            const Text(
              'Track equipment, land and machinery with purchase and depreciation details.',
              style: TextStyle(
                fontSize: sizes.fontSizeSm,
                color: UColors.textSecondary,
                height: 1.5,
              ),
            ),
            const SizedBox(height: sizes.defaultSpace),
            CustomInput(
              label: 'Asset name *',
              hintText: 'e.g. Tractor, Milking machine...',
              controller: _assetNameCtrl,
              keyboardType: TextInputType.text,
            ),
            _buildDropdown(
              label: 'Asset type *',
              value: _assetType,
              options: _assetTypes,
              onChanged: (value) => setState(() => _assetType = value),
              hint: 'Select type',
            ),
            DatePickerTile(
              icon: Icons.calendar_today_rounded,
              label: 'Purchase date',
              selectedDate: _purchaseDate,
              onPicked: (date) => setState(() => _purchaseDate = date),
            ),
            CustomInput(
              label: 'Purchase cost (PKR) *',
              controller: _purchaseCostCtrl,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              onChanged: (_) => setState(() {}),
            ),
            CustomInput(
              label: 'Useful life (months) *',
              controller: _usefulLifeCtrl,
              keyboardType: TextInputType.number,
              onChanged: (_) => setState(() {}),
            ),
            CustomInput(
              label: 'Salvage value (PKR)',
              controller: _salvageValueCtrl,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: sizes.spaceBtwSections),
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
                    'Depreciation (auto-calculated)',
                    style: TextStyle(
                      fontSize: sizes.fontSizeMd,
                      fontWeight: FontWeight.bold,
                      color: UColors.colorPrimary,
                    ),
                  ),
                  const SizedBox(height: sizes.sm),
                  _buildDepreciationRow('Formula', '(Cost − Salvage) ÷ Life months'),
                  const SizedBox(height: sizes.sm),
                  _buildDepreciationRow('Monthly depreciation', 'PKR ${_monthlyDepreciation.toStringAsFixed(0)}'),
                  const SizedBox(height: sizes.sm),
                  _buildDepreciationRow('Annual depreciation', 'PKR ${_annualDepreciation.toStringAsFixed(0)}'),
                  const SizedBox(height: sizes.sm),
                  _buildDepreciationRow('Total useful life', '${_usefulLifeCtrl.text.isNotEmpty ? '${_usefulLifeCtrl.text} months' : '— months'}'),
                ],
              ),
            ),
            const SizedBox(height: sizes.defaultSpace),
            PrimaryButton(
              label: 'Save asset',
              onPressed: () {
                FocusScope.of(context).unfocus();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Asset saved successfully.')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> options,
    required void Function(String?) onChanged,
    required String hint,
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
                  hint,
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

  Widget _buildDepreciationRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: sizes.fontSizeSm,
            color: UColors.textSecondary,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: sizes.fontSizeSm,
            fontWeight: FontWeight.w700,
            color: UColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
