import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/themes/app_colors.dart';
import '../../../core/utils/sizes.dart';
import '../../../core/widgets/AppScaffoldBgBasic.dart';
import '../../../core/widgets/PrimaryButton.dart';
import '../../../l10n/app_localizations.dart';
import '../../breeding_form/view/BreedingEntryScreen.dart';
import '../viewmodel/herd_viewmodel.dart';
import '../widgets/AnimalInfoStep.dart';
import '../../herd_store/herd_store.dart';

class HerdStepperScreen extends ConsumerWidget {
  const HerdStepperScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(herdProvider);
    final vm = ref.watch(herdProvider.notifier);
    final l10n = AppLocalizations.of(context)!;

    // Button label logic
    final bool hasNextStep = vm.isLactatingFemale || vm.isBreedableFemaleOnly;
    final String buttonLabel = hasNextStep ? l10n.continueButton : l10n.save;

    return AppScaffoldBgBasic(
      showBackButton: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.registerAnimal,
            style: const TextStyle(
              fontSize: sizes.fontSizeHeadings,
              fontWeight: FontWeight.bold,
              color: UColors.colorPrimary,
            ),
          ),
          const SizedBox(height: sizes.sm),
          Text(
            l10n.animalRegistrationSubtitle,
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
                children: [
                  const AnimalInfoStep(),
                  const SizedBox(height: sizes.spaceBtwSections),
                  PrimaryButton(
                    label: buttonLabel,
                    onPressed: () async {
                      final validationError = vm.validateAnimalInfoStep();
                      if (validationError != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(validationError)),
                        );
                        return;
                      }

                      final errorKey = vm.validateBreedingStageRule();
                      if (errorKey != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(l10n.calfCannotHaveBreedingDatesError)),
                        );
                        return;
                      }

                      // Save animal
                      vm.save();
                      await ref.read(herdStoreProvider.notifier).upsert(vm.state);

                      // Navigation Logic
                      if (!context.mounted) return;
                      if (vm.isLactatingFemale) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const BreedingEntryScreen(
                              continueToProduction: true,
                            ),
                          ),
                        );
                      } else if (vm.isBreedableFemaleOnly) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const BreedingEntryScreen()),
                        );
                      } else {
                        // 3. Non-Breedable -> Back to Dashboard
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(l10n.animalRegisteredSuccess)),
                        );
                      }
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
