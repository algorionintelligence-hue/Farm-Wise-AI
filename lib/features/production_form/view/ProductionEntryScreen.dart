import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/themes/app_colors.dart';
import '../../../core/utils/sizes.dart';
import '../../../core/widgets/AppScaffoldBgBasic.dart';
import '../../../core/widgets/PrimaryButton.dart';
import '../../../l10n/app_localizations.dart';
import '../../herd_form/viewmodel/herd_viewmodel.dart';
import '../../herd_form/widgets/CustomInput.dart';
import '../../herd_form/widgets/SectionCard.dart';
import '../../herd_store/herd_store.dart';

class ProductionEntryScreen extends ConsumerWidget {
  const ProductionEntryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(herdProvider);
    final vm = ref.watch(herdProvider.notifier);
    final l10n = AppLocalizations.of(context)!;

    return AppScaffoldBgBasic(
      showBackButton: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.productionStepTitle,
            style: const TextStyle(
              fontSize: sizes.fontSizeHeadings,
              fontWeight: FontWeight.bold,
              color: UColors.colorPrimary,
            ),
          ),
          const SizedBox(height: sizes.sm),
          const Text(
            'Avg milk, milk price aur feed cost fill karein.',
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
                children: [
                  SectionCard(
                    icon: Icons.opacity_rounded,
                    title: l10n.productionStepTitle,
                    subtitle: 'Complete all 3 required fields',
                    children: [
                      CustomInput(
                        label: 'Avg Milk / Day (litres)',
                        hintText: '0',
                        controller: vm.avgMilkController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                      ),
                      CustomInput(
                        label: 'Milk Price (per litre)',
                        hintText: '0',
                        controller: vm.milkPriceController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                      ),
                      CustomInput(
                        label: 'Feed Cost (monthly)',
                        hintText: '0',
                        controller: vm.feedCostController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: sizes.spaceBtwSections),
                  PrimaryButton(
                    label: l10n.save,
                    onPressed: () {
                      final validationError = vm.validateProductionStep();
                      if (validationError != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(validationError)),
                        );
                        return;
                      }

                      vm.save();
                      ref.read(herdStoreProvider.notifier).upsert(vm.state);
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(l10n.animalRegisteredSuccess)),
                      );
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
