import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/Utils/sizes.dart';
import '../../../core/themes/app_colors.dart';
import '../../../core/widgets/AppScaffoldBgBasic.dart';
import '../../../core/widgets/PrimaryButton.dart';
import '../../herd_form/widgets/CustomInput.dart';
import '../../herd_form/widgets/DatePickerTile.dart';
import '../../herd_form/widgets/SectionCard.dart';

import 'package:dropdown_button2/dropdown_button2.dart';

class RevenueInputsScreen extends ConsumerStatefulWidget {
  const RevenueInputsScreen({super.key});

  @override
  ConsumerState<RevenueInputsScreen> createState() =>
      _RevenueInputsScreenState();
}

class _RevenueInputsScreenState extends ConsumerState<RevenueInputsScreen> {
  // Milk Revenue
  final _milkRevenueCtrl = TextEditingController();
  final _dailyLitresSoldCtrl = TextEditingController();
  final _pricePerLitreCtrl = TextEditingController();
  final _collectionTransportCtrl = TextEditingController();

  // Animal Sales
  final _animalSalesCtrl = TextEditingController();
  final _salePriceCtrl = TextEditingController();
  final _commissionMarketFeeCtrl = TextEditingController();
  DateTime? _animalSoldDate;
  String? _animalCategory;

  // Other Revenue
  final _otherRevenueCtrl = TextEditingController();
  final _manureBiogasCtrl = TextEditingController();
  final _subsidiesGrantsCtrl = TextEditingController();

  static const _categories = [
    "Cow",
    "Buffalo",
    "Bull",
    "Heifer",
    "Calf (Male)",
    "Calf (Female)",
    "Goat",
    "Sheep",
    "Other",
  ];

  @override
  void dispose() {
    _milkRevenueCtrl.dispose();
    _dailyLitresSoldCtrl.dispose();
    _pricePerLitreCtrl.dispose();
    _collectionTransportCtrl.dispose();
    _animalSalesCtrl.dispose();
    _salePriceCtrl.dispose();
    _commissionMarketFeeCtrl.dispose();
    _otherRevenueCtrl.dispose();
    _manureBiogasCtrl.dispose();
    _subsidiesGrantsCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffoldBgBasic(
      showBackButton: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ──
          const Text(
            "Revenue Inputs",
            style: TextStyle(
              fontSize: sizes.fontSizeHeadings,
              fontWeight: FontWeight.bold,
              color: UColors.colorPrimary,
            ),
          ),
          const SizedBox(height: sizes.sm),
          const Text(
            "Enter all revenue sources for accurate ERP tracking",
            style: TextStyle(
              fontSize: sizes.fontSizeSm,
              color: UColors.textSecondary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: sizes.defaultSpace),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Milk Revenue ──────────────────────
                  SectionCard(
                    icon: Icons.water_drop_rounded,
                    title: "Milk Revenue",
                    children: [
                      CustomInput(
                        label: "Milk Revenue",
                        controller: _milkRevenueCtrl,
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                      ),
                      CustomInput(
                        label: "Daily Litres Sold",
                        controller: _dailyLitresSoldCtrl,
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                      ),
                      CustomInput(
                        label: "Price Per Litre",
                        controller: _pricePerLitreCtrl,
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                      ),
                      CustomInput(
                        label: "Collection / Transport Cost (optional)",
                        controller: _collectionTransportCtrl,
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                      ),
                    ],
                  ),

                  const SizedBox(height: sizes.spaceBtwItems),

                  // ── Animal Sales ──────────────────────
                  SectionCard(
                    icon: Icons.pets_rounded,
                    title: "Animal Sales",
                    children: [
                      CustomInput(
                        label: "Animal Sales (count)",
                        controller: _animalSalesCtrl,
                        keyboardType: TextInputType.number,
                      ),

                      // ✅ Date picker tile
                      DatePickerTile(
                        icon: Icons.calendar_today_rounded,
                        label: "Animal Sold Date",
                        selectedDate: _animalSoldDate,
                        onPicked: (date) =>
                            setState(() => _animalSoldDate = date),
                      ),

                      const SizedBox(height: sizes.sm),

                      // ✅ Category dropdown
                      _CategoryDropdown(
                        value: _animalCategory,
                        categories: _categories,
                        onChanged: (val) =>
                            setState(() => _animalCategory = val),
                      ),

                      const SizedBox(height: sizes.sm),

                      CustomInput(
                        label: "Sale Price",
                        controller: _salePriceCtrl,
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                      ),
                      CustomInput(
                        label: "Commission / Market Fee (optional)",
                        controller: _commissionMarketFeeCtrl,
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                      ),
                    ],
                  ),

                  const SizedBox(height: sizes.spaceBtwItems),

                  // ── Other Revenue ─────────────────────
                  SectionCard(
                    icon: Icons.attach_money_rounded,
                    title: "Other Revenue",
                    children: [
                      CustomInput(
                        label: "Other Revenue",
                        controller: _otherRevenueCtrl,
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                      ),
                      CustomInput(
                        label: "Manure / Biogas Income (optional)",
                        controller: _manureBiogasCtrl,
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                      ),
                      CustomInput(
                        label: "Subsidies / Grants (optional)",
                        controller: _subsidiesGrantsCtrl,
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                      ),
                    ],
                  ),

                  const SizedBox(height: sizes.spaceBtwSections),

                  PrimaryButton(
                    label: "Save Revenue Data",
                    onPressed: () {
                      // TODO: save logic
                    },
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

// ═══════════════════════════════════════════════
// Reusable Category Dropdown
// ═══════════════════════════════════════════════

class _CategoryDropdown extends StatelessWidget {
  final String? value;
  final List<String> categories;
  final void Function(String?) onChanged;

  const _CategoryDropdown({
    required this.value,
    required this.categories,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasValue = value != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Animal Category",
          style: const TextStyle(
            fontSize: sizes.fontSizeSm,
            fontWeight: FontWeight.w800,
            color: UColors.colorPrimary,
          ),
        ),
        const SizedBox(height: sizes.xs),

        DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: true,
            hint: const Text(
              "Select category",
              style: TextStyle(
                fontSize: sizes.fontSizeSm,
                color: UColors.darkGrey,
              ),
            ),
            value: value,
            items: categories
                .map((cat) => DropdownMenuItem<String>(
              value: cat,
              child: Text(
                cat,
                style: const TextStyle(
                  fontSize: sizes.fontSizeSm,
                  color: UColors.textPrimary,
                ),
              ),
            ))
                .toList(),
            onChanged: onChanged,
            buttonStyleData: ButtonStyleData(
              height: 52,
              padding: const EdgeInsets.symmetric(horizontal: sizes.md),
              decoration: BoxDecoration(
                color: hasValue
                    ? UColors.colorPrimary.withOpacity(0.06)
                    : UColors.inputBg,
                borderRadius: BorderRadius.circular(sizes.inputFieldRadius),
                border: Border.all(
                  color: hasValue ? UColors.colorPrimary : UColors.borderPrimary,
                  width: hasValue ? 1.5 : 1.0,
                ),
              ),
            ),
            iconStyleData: IconStyleData(
              icon: Icon(
                hasValue
                    ? Icons.check_circle_rounded
                    : Icons.keyboard_arrow_down_rounded,
                color: hasValue ? UColors.colorPrimary : UColors.darkGrey,
                size: 20,
              ),
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: 280,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(sizes.cardRadiusMd),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 44,
              padding: EdgeInsets.symmetric(horizontal: sizes.md),
            ),
          ),
        ),
      ],
    );
  }
}

