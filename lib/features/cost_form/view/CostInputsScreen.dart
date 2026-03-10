import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/themes/app_colors.dart';
import '../../../core/utils/sizes.dart';
import '../../../core/widgets/AppScaffoldBgBasic.dart';
import '../../../core/widgets/PrimaryButton.dart';
import '../../../l10n/app_localizations.dart';
import '../../herd_form/widgets/CustomInput.dart';
import '../../herd_form/widgets/ReadOnlyField.dart';
import '../../herd_form/widgets/SectionCard.dart';

class CostInputsScreen extends ConsumerStatefulWidget {
  const CostInputsScreen({super.key});

  @override
  ConsumerState<CostInputsScreen> createState() => _CostInputsScreenState();
}

class _CostInputsScreenState extends ConsumerState<CostInputsScreen> {
  final _feedTypeCtrl = TextEditingController();
  final _quantityPerDayCtrl = TextEditingController();
  final _pricePerUnitCtrl = TextEditingController();
  final _deliveryFrequencyCtrl = TextEditingController();
  final _visitDateCtrl = TextEditingController();
  final _serviceTypeCtrl = TextEditingController();
  final _medicineCostCtrl = TextEditingController();
  final _vetFeeCtrl = TextEditingController();
  final _naturalServiceFeeCtrl = TextEditingController();
  final _technicianFeeCtrl = TextEditingController();
  final _pregnancyDiagnosisFeeCtrl = TextEditingController();
  final _noOfWorkersCtrl = TextEditingController();
  final _salariesTotalCtrl = TextEditingController();
  final _housingFoodAllowanceCtrl = TextEditingController();
  final _electricityWaterCtrl = TextEditingController();
  final _dieselFuelCtrl = TextEditingController();
  final _rentLeaseCtrl = TextEditingController();
  final _maintenanceCtrl = TextEditingController();
  final _miscellaneousCtrl = TextEditingController();
  final _assetNameCtrl = TextEditingController();
  final _purchaseCostCtrl = TextEditingController();
  final _usefulLifeCtrl = TextEditingController();

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AppScaffoldBgBasic(
      showBackButton: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.costInputsTitle,
            style: const TextStyle(
              fontSize: sizes.fontSizeHeadings,
              fontWeight: FontWeight.bold,
              color: UColors.colorPrimary,
            ),
          ),
          const SizedBox(height: sizes.sm),
          Text(
            l10n.costInputsSubtitle,
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
                    icon: Icons.grass_rounded,
                    title: l10n.feedCosts,
                    subtitle: l10n.feedCostsSubtitle,
                    children: [
                      CustomInput(label: l10n.feedType, controller: _feedTypeCtrl),
                      CustomInput(label: l10n.quantityPerDayMonthly, controller: _quantityPerDayCtrl, keyboardType: TextInputType.number),
                      CustomInput(label: l10n.pricePerUnit, controller: _pricePerUnitCtrl, keyboardType: TextInputType.number),
                      CustomInput(label: l10n.deliveryFrequency, controller: _deliveryFrequencyCtrl),
                    ],
                  ),
                  const SizedBox(height: sizes.spaceBtwItems),
                  SectionCard(
                    icon: Icons.medical_services_rounded,
                    title: l10n.vetMedicine,
                    children: [
                      CustomInput(label: l10n.visitDate, controller: _visitDateCtrl),
                      CustomInput(label: l10n.serviceType, controller: _serviceTypeCtrl),
                      CustomInput(label: l10n.medicineCost, controller: _medicineCostCtrl, keyboardType: TextInputType.number),
                      CustomInput(label: l10n.vetFee, controller: _vetFeeCtrl, keyboardType: TextInputType.number),
                    ],
                  ),
                  const SizedBox(height: sizes.spaceBtwItems),
                  SectionCard(
                    icon: Icons.favorite_rounded,
                    title: l10n.breedingCost,
                    children: [
                      CustomInput(label: l10n.naturalServiceOrAiStrawCost, controller: _naturalServiceFeeCtrl, keyboardType: TextInputType.number),
                      CustomInput(label: l10n.technicianFee, controller: _technicianFeeCtrl, keyboardType: TextInputType.number),
                      CustomInput(label: l10n.pregnancyDiagnosisFee, controller: _pregnancyDiagnosisFeeCtrl, keyboardType: TextInputType.number),
                    ],
                  ),
                  const SizedBox(height: sizes.spaceBtwItems),
                  SectionCard(
                    icon: Icons.people_rounded,
                    title: l10n.labour,
                    children: [
                      CustomInput(label: l10n.numberOfWorkers, controller: _noOfWorkersCtrl, keyboardType: TextInputType.number),
                      CustomInput(label: l10n.salariesTotalMonth, controller: _salariesTotalCtrl, keyboardType: TextInputType.number),
                      CustomInput(label: l10n.housingFoodAllowanceOptional, controller: _housingFoodAllowanceCtrl, keyboardType: TextInputType.number),
                    ],
                  ),
                  const SizedBox(height: sizes.spaceBtwItems),
                  SectionCard(
                    icon: Icons.electric_bolt_rounded,
                    title: l10n.utilitiesOverhead,
                    children: [
                      CustomInput(label: l10n.electricityWater, controller: _electricityWaterCtrl, keyboardType: TextInputType.number),
                      CustomInput(label: l10n.dieselFuel, controller: _dieselFuelCtrl, keyboardType: TextInputType.number),
                      CustomInput(label: l10n.rentLease, controller: _rentLeaseCtrl, keyboardType: TextInputType.number),
                      CustomInput(label: l10n.maintenanceShedEquipment, controller: _maintenanceCtrl, keyboardType: TextInputType.number),
                      CustomInput(label: l10n.miscellaneous, controller: _miscellaneousCtrl, keyboardType: TextInputType.number),
                    ],
                  ),
                  const SizedBox(height: sizes.spaceBtwItems),
                  SectionCard(
                    icon: Icons.precision_manufacturing_rounded,
                    title: l10n.capexAssets,
                    subtitle: l10n.capexAssetsSubtitle,
                    children: [
                      CustomInput(label: l10n.assetName, controller: _assetNameCtrl),
                      CustomInput(label: l10n.purchaseCost, controller: _purchaseCostCtrl, keyboardType: TextInputType.number),
                      CustomInput(label: l10n.usefulLife, controller: _usefulLifeCtrl),
                      ReadOnlyField(label: l10n.monthlyDepreciationAuto, value: _calcDepreciation()),
                    ],
                  ),
                  const SizedBox(height: sizes.spaceBtwSections),
                  PrimaryButton(
                    label: l10n.saveCostData,
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

  String _calcDepreciation() {
    final purchase = double.tryParse(_purchaseCostCtrl.text);
    final life = double.tryParse(_usefulLifeCtrl.text);
    if (purchase != null && life != null && life > 0) {
      return (purchase / life).toStringAsFixed(2);
    }
    return '-';
  }
}
