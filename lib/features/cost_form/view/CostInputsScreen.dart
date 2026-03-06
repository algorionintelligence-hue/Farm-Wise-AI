import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/Utils/sizes.dart';
import '../../../core/themes/app_colors.dart';
import '../../../core/widgets/AppScaffoldBgBasic.dart';
import '../../../core/widgets/PrimaryButton.dart';
import '../../herd_form/widgets/CustomInput.dart';
import '../../herd_form/widgets/ReadOnlyField.dart';
import '../../herd_form/widgets/SectionCard.dart';

class CostInputsScreen extends ConsumerStatefulWidget {
  const CostInputsScreen({super.key});

  @override
  ConsumerState<CostInputsScreen> createState() => _CostInputsScreenState();
}

class _CostInputsScreenState extends ConsumerState<CostInputsScreen> {
  // Feed Costs
  final _feedTypeCtrl = TextEditingController();
  final _quantityPerDayCtrl = TextEditingController();
  final _pricePerUnitCtrl = TextEditingController();
  final _deliveryFrequencyCtrl = TextEditingController();

  // Vet & Medicine
  final _visitDateCtrl = TextEditingController();
  final _serviceTypeCtrl = TextEditingController();
  final _medicineCostCtrl = TextEditingController();
  final _vetFeeCtrl = TextEditingController();

  // Breeding Cost
  final _naturalServiceFeeCtrl = TextEditingController();
  final _technicianFeeCtrl = TextEditingController();
  final _pregnancyDiagnosisFeeCtrl = TextEditingController();

  // Labour
  final _noOfWorkersCtrl = TextEditingController();
  final _salariesTotalCtrl = TextEditingController();
  final _housingFoodAllowanceCtrl = TextEditingController();

  // Utilities & Overhead
  final _electricityWaterCtrl = TextEditingController();
  final _dieselFuelCtrl = TextEditingController();
  final _rentLeaseCtrl = TextEditingController();
  final _maintenanceCtrl = TextEditingController();
  final _miscellaneousCtrl = TextEditingController();

  // Capex / Assets
  final _assetNameCtrl = TextEditingController();
  final _purchaseCostCtrl = TextEditingController();
  final _usefulLifeCtrl = TextEditingController();
  final _monthlyDepreciationCtrl = TextEditingController();

  @override
  void dispose() {
    _feedTypeCtrl.dispose();
    _quantityPerDayCtrl.dispose();
    _pricePerUnitCtrl.dispose();
    _deliveryFrequencyCtrl.dispose();
    _visitDateCtrl.dispose();
    _serviceTypeCtrl.dispose();
    _medicineCostCtrl.dispose();
    _vetFeeCtrl.dispose();
    _naturalServiceFeeCtrl.dispose();
    _technicianFeeCtrl.dispose();
    _pregnancyDiagnosisFeeCtrl.dispose();
    _noOfWorkersCtrl.dispose();
    _salariesTotalCtrl.dispose();
    _housingFoodAllowanceCtrl.dispose();
    _electricityWaterCtrl.dispose();
    _dieselFuelCtrl.dispose();
    _rentLeaseCtrl.dispose();
    _maintenanceCtrl.dispose();
    _miscellaneousCtrl.dispose();
    _assetNameCtrl.dispose();
    _purchaseCostCtrl.dispose();
    _usefulLifeCtrl.dispose();
    _monthlyDepreciationCtrl.dispose();
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
            "Cost Inputs",
            style: TextStyle(
              fontSize: sizes.fontSizeHeadings,
              fontWeight: FontWeight.bold,
              color: UColors.colorPrimary,
            ),
          ),
          const SizedBox(height: sizes.sm),
          const Text(
            "Enter all cost_form details for accurate ERP tracking",
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
                  // ── Feed Costs ──
                  SectionCard(
                    icon: Icons.grass_rounded,
                    title: "Feed Costs",
                    subtitle: "chokar, silage, bhusa, concentrate, mineral mix",
                    children: [
                      CustomInput(
                        label: "Feed Type",
                        controller: _feedTypeCtrl,
                      ),
                      CustomInput(
                        label: "Quantity / Day (per group) or Monthly Total",
                        controller: _quantityPerDayCtrl,
                        keyboardType: TextInputType.number,
                      ),
                      CustomInput(
                        label: "Price / Unit",
                        controller: _pricePerUnitCtrl,
                        keyboardType: TextInputType.number,
                      ),
                      CustomInput(
                        label: "Delivery Frequency",
                        controller: _deliveryFrequencyCtrl,
                      ),
                    ],
                  ),

                  const SizedBox(height: sizes.spaceBtwItems),

                  // ── Vet & Medicine ──
                  SectionCard(
                    icon: Icons.medical_services_rounded,
                    title: "Vet & Medicine",
                    children: [
                      CustomInput(
                        label: "Visit Date",
                        controller: _visitDateCtrl,
                      ),
                      CustomInput(
                        label: "Service Type",
                        controller: _serviceTypeCtrl,
                      ),
                      CustomInput(
                        label: "Medicine Cost",
                        controller: _medicineCostCtrl,
                        keyboardType: TextInputType.number,
                      ),
                      CustomInput(
                        label: "Vet Fee",
                        controller: _vetFeeCtrl,
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),

                  const SizedBox(height: sizes.spaceBtwItems),

                  // ── Breeding Cost ──
                  SectionCard(
                    icon: Icons.favorite_rounded,
                    title: "Breeding Cost",
                    children: [
                      CustomInput(
                        label: "Natural Service Fee or AI Straw Cost",
                        controller: _naturalServiceFeeCtrl,
                        keyboardType: TextInputType.number,
                      ),
                      CustomInput(
                        label: "Technician Fee",
                        controller: _technicianFeeCtrl,
                        keyboardType: TextInputType.number,
                      ),
                      CustomInput(
                        label: "Pregnancy Diagnosis Fee",
                        controller: _pregnancyDiagnosisFeeCtrl,
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),

                  const SizedBox(height: sizes.spaceBtwItems),

                  // ── Labour ──
                  SectionCard(
                    icon: Icons.people_rounded,
                    title: "Labour",
                    children: [
                      CustomInput(
                        label: "No. of Workers",
                        controller: _noOfWorkersCtrl,
                        keyboardType: TextInputType.number,
                      ),
                      CustomInput(
                        label: "Salaries Total / Month",
                        controller: _salariesTotalCtrl,
                        keyboardType: TextInputType.number,
                      ),
                      CustomInput(
                        label: "Housing / Food Allowance (optional)",
                        controller: _housingFoodAllowanceCtrl,
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),

                  const SizedBox(height: sizes.spaceBtwItems),

                  // ── Utilities & Overhead ──
                  SectionCard(
                    icon: Icons.electric_bolt_rounded,
                    title: "Utilities & Overhead",
                    children: [
                      CustomInput(
                        label: "Electricity & Water",
                        controller: _electricityWaterCtrl,
                        keyboardType: TextInputType.number,
                      ),
                      CustomInput(
                        label: "Diesel / Fuel",
                        controller: _dieselFuelCtrl,
                        keyboardType: TextInputType.number,
                      ),
                      CustomInput(
                        label: "Rent / Lease",
                        controller: _rentLeaseCtrl,
                        keyboardType: TextInputType.number,
                      ),
                      CustomInput(
                        label: "Maintenance (shed, equipment)",
                        controller: _maintenanceCtrl,
                        keyboardType: TextInputType.number,
                      ),
                      CustomInput(
                        label: "Miscellaneous",
                        controller: _miscellaneousCtrl,
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),

                  const SizedBox(height: sizes.spaceBtwItems),

                  // ── Capex / Assets ──
                  SectionCard(
                    icon: Icons.precision_manufacturing_rounded,
                    title: "Capex / Assets",
                    subtitle: "generator, chaff cutter, milking machine",
                    children: [
                      CustomInput(
                        label: "Asset Name",
                        controller: _assetNameCtrl,
                      ),
                      CustomInput(
                        label: "Purchase Cost",
                        controller: _purchaseCostCtrl,
                        keyboardType: TextInputType.number,
                      ),
                      CustomInput(
                        label: "Useful Life (months / years)",
                        controller: _usefulLifeCtrl,
                      ),
                      // Auto-calculated field (read-only style)
                      ReadOnlyField(
                        label: "Monthly Depreciation (auto)",
                        value: _calcDepreciation(),
                      ),
                    ],
                  ),

                  const SizedBox(height: sizes.spaceBtwSections),

                  PrimaryButton(
                    label: "Save Cost Data",
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

  String _calcDepreciation() {
    final purchase = double.tryParse(_purchaseCostCtrl.text);
    final life = double.tryParse(_usefulLifeCtrl.text);
    if (purchase != null && life != null && life > 0) {
      return (purchase / life).toStringAsFixed(2);
    }
    return "—";
  }
}
