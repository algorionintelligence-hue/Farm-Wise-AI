import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/themes/app_colors.dart';
import '../../../core/utils/sizes.dart';
import '../../../core/widgets/AppScaffoldBgBasic.dart';
import '../../../core/widgets/PrimaryButton.dart';
import '../../../l10n/app_localizations.dart';
import '../../herd_form/widgets/CustomInput.dart';
import '../../herd_form/widgets/DatePickerTile.dart';
import '../../herd_form/widgets/SectionCard.dart';

class RevenueInputsScreen extends ConsumerStatefulWidget {
  const RevenueInputsScreen({super.key});

  @override
  ConsumerState<RevenueInputsScreen> createState() =>
      _RevenueInputsScreenState();
}

class _RevenueInputsScreenState extends ConsumerState<RevenueInputsScreen> {
  final _milkRevenueCtrl = TextEditingController();
  final _dailyLitresSoldCtrl = TextEditingController();
  final _pricePerLitreCtrl = TextEditingController();
  final _collectionTransportCtrl = TextEditingController();

  final _animalSalesCtrl = TextEditingController();
  final _salePriceCtrl = TextEditingController();
  final _commissionMarketFeeCtrl = TextEditingController();
  DateTime? _animalSoldDate;
  String? _animalCategory;

  final _otherRevenueCtrl = TextEditingController();
  final _manureBiogasCtrl = TextEditingController();
  final _subsidiesGrantsCtrl = TextEditingController();

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
    final l10n = AppLocalizations.of(context)!;
    final categories = [
      l10n.cow,
      l10n.buffalo,
      l10n.bull,
      l10n.heifer,
      l10n.calfMale,
      l10n.calfFemale,
      l10n.goat,
      l10n.sheep,
      l10n.other,
    ];

    return AppScaffoldBgBasic(
      showBackButton: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.revenueInputsTitle,
            style: const TextStyle(
              fontSize: sizes.fontSizeHeadings,
              fontWeight: FontWeight.bold,
              color: UColors.colorPrimary,
            ),
          ),
          const SizedBox(height: sizes.sm),
          Text(
            l10n.revenueInputsSubtitle,
            style: const TextStyle(
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
                  SectionCard(
                    icon: Icons.water_drop_rounded,
                    title: l10n.milkRevenueTitle,
                    children: [
                      CustomInput(
                        label: l10n.milkRevenue,
                        controller: _milkRevenueCtrl,
                        keyboardType:
                            const TextInputType.numberWithOptions(decimal: true),
                      ),
                      CustomInput(
                        label: l10n.dailyLitresSold,
                        controller: _dailyLitresSoldCtrl,
                        keyboardType:
                            const TextInputType.numberWithOptions(decimal: true),
                      ),
                      CustomInput(
                        label: l10n.pricePerLitre,
                        controller: _pricePerLitreCtrl,
                        keyboardType:
                            const TextInputType.numberWithOptions(decimal: true),
                      ),
                      CustomInput(
                        label: l10n.collectionTransportCostOptional,
                        controller: _collectionTransportCtrl,
                        keyboardType:
                            const TextInputType.numberWithOptions(decimal: true),
                      ),
                    ],
                  ),
                  const SizedBox(height: sizes.spaceBtwItems),
                  SectionCard(
                    icon: Icons.pets_rounded,
                    title: l10n.animalSalesTitle,
                    children: [
                      CustomInput(
                        label: l10n.animalSalesCount,
                        controller: _animalSalesCtrl,
                        keyboardType: TextInputType.number,
                      ),
                      DatePickerTile(
                        icon: Icons.calendar_today_rounded,
                        label: l10n.animalSoldDate,
                        selectedDate: _animalSoldDate,
                        onPicked: (date) => setState(() => _animalSoldDate = date),
                      ),
                      const SizedBox(height: sizes.sm),
                      _CategoryDropdown(
                        value: _animalCategory,
                        categories: categories,
                        onChanged: (value) => setState(() => _animalCategory = value),
                      ),
                      const SizedBox(height: sizes.sm),
                      CustomInput(
                        label: l10n.salePrice,
                        controller: _salePriceCtrl,
                        keyboardType:
                            const TextInputType.numberWithOptions(decimal: true),
                      ),
                      CustomInput(
                        label: l10n.commissionMarketFeeOptional,
                        controller: _commissionMarketFeeCtrl,
                        keyboardType:
                            const TextInputType.numberWithOptions(decimal: true),
                      ),
                    ],
                  ),
                  const SizedBox(height: sizes.spaceBtwItems),
                  SectionCard(
                    icon: Icons.attach_money_rounded,
                    title: l10n.otherRevenueTitle,
                    children: [
                      CustomInput(
                        label: l10n.otherRevenue,
                        controller: _otherRevenueCtrl,
                        keyboardType:
                            const TextInputType.numberWithOptions(decimal: true),
                      ),
                      CustomInput(
                        label: l10n.manureBiogasIncomeOptional,
                        controller: _manureBiogasCtrl,
                        keyboardType:
                            const TextInputType.numberWithOptions(decimal: true),
                      ),
                      CustomInput(
                        label: l10n.subsidiesGrantsOptional,
                        controller: _subsidiesGrantsCtrl,
                        keyboardType:
                            const TextInputType.numberWithOptions(decimal: true),
                      ),
                    ],
                  ),
                  const SizedBox(height: sizes.spaceBtwSections),
                  PrimaryButton(
                    label: l10n.saveRevenueData,
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
    final hasValue = value != null;
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.animalCategory,
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
            hint: Text(
              l10n.selectCategory,
              style: const TextStyle(
                fontSize: sizes.fontSizeSm,
                color: UColors.darkGrey,
              ),
            ),
            value: value,
            items: categories
                .map(
                  (category) => DropdownMenuItem<String>(
                    value: category,
                    child: Text(
                      category,
                      style: const TextStyle(
                        fontSize: sizes.fontSizeSm,
                        color: UColors.textPrimary,
                      ),
                    ),
                  ),
                )
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
                  color:
                      hasValue ? UColors.colorPrimary : UColors.borderPrimary,
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
