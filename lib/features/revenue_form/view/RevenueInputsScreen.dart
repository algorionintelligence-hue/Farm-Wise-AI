import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/Utils/sizes.dart';
import '../../../core/themes/app_colors.dart';
import '../../../core/widgets/AppScaffoldBgBasic.dart';
import '../../../core/widgets/PrimaryButton.dart';
import '../../herd_form/widgets/CustomInput.dart';
import '../../herd_form/widgets/SectionCard.dart';


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
  final _animalSoldDateCtrl = TextEditingController();
  final _animalCategoryCtrl = TextEditingController();
  final _salePriceCtrl = TextEditingController();
  final _commissionMarketFeeCtrl = TextEditingController();

  // Other Revenue
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
    _animalSoldDateCtrl.dispose();
    _animalCategoryCtrl.dispose();
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
            "Enter all revenue_form sources for accurate ERP tracking",
            style: TextStyle(
              fontSize: sizes.fontSizeSm,
              color: UColors.textSecondary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: sizes.defaultSpace),

          // ── Sections ──
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Milk Revenue ──
                  SectionCard(
                    icon: Icons.water_drop_rounded,
                    title: "Milk Revenue",
                    children: [
                      CustomInput(
                        label: "Milk Revenue",
                        controller: _milkRevenueCtrl,
                        keyboardType: TextInputType.number,
                      ),
                      CustomInput(
                        label: "Daily Litres Sold",
                        controller: _dailyLitresSoldCtrl,
                        keyboardType: TextInputType.number,
                      ),
                      CustomInput(
                        label: "Price Per Litre",
                        controller: _pricePerLitreCtrl,
                        keyboardType: TextInputType.number,
                      ),
                      CustomInput(
                        label: "Collection / Transport Cost (optional)",
                        controller: _collectionTransportCtrl,
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),

                  const SizedBox(height: sizes.spaceBtwItems),

                  // ── Animal Sales ──
                  SectionCard(
                    icon: Icons.pets_rounded,
                    title: "Animal Sales",
                    children: [
                      CustomInput(
                        label: "Animal Sales",
                        controller: _animalSalesCtrl,
                        keyboardType: TextInputType.number,
                      ),
                      CustomInput(
                        label: "Animal Sold Date",
                        controller: _animalSoldDateCtrl,
                      ),
                      CustomInput(
                        label: "Animal Category",
                        controller: _animalCategoryCtrl,
                      ),
                      CustomInput(
                        label: "Sale Price",
                        controller: _salePriceCtrl,
                        keyboardType: TextInputType.number,
                      ),
                      CustomInput(
                        label: "Commission / Market Fee (optional)",
                        controller: _commissionMarketFeeCtrl,
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),

                  const SizedBox(height: sizes.spaceBtwItems),

                  // ── Other Revenue ──
                  SectionCard(
                    icon: Icons.attach_money_rounded,
                    title: "Other Revenue",
                    children: [
                      CustomInput(
                        label: "Other Revenue",
                        controller: _otherRevenueCtrl,
                        keyboardType: TextInputType.number,
                      ),
                      CustomInput(
                        label: "Manure / Biogas Income (optional)",
                        controller: _manureBiogasCtrl,
                        keyboardType: TextInputType.number,
                      ),
                      CustomInput(
                        label: "Subsidies / Grants (optional)",
                        controller: _subsidiesGrantsCtrl,
                        keyboardType: TextInputType.number,
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

