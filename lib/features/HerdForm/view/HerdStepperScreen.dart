import 'package:farm_wise_ai/l10n/AppLocalizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/themes/app_colors.dart';
import '../../../core/utils/sizes.dart';
import '../../../core/widgets/AppScaffoldBgBasic.dart';
import '../../../core/widgets/PrimaryButton.dart';
import '../../BreedingForm/view/BreedingEntryScreen.dart';
import '../../HealthEvents/view/AddHealthEventScreen.dart';
import '../../HerdStore/HerdStore.dart';
import '../../Vaccinations/view/AddVaccinationScreen.dart';
import '../viewmodel/HerdViewmodel.dart';
import '../widgets/AnimalInfoStep.dart';

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

                      // Decide next step based on animal data
                      final animalRef = (vm.state.tagNumber?.trim().isNotEmpty == true)
                          ? vm.state.tagNumber!.trim()
                          : (vm.state.animalId?.trim().isNotEmpty == true
                              ? vm.state.animalId!.trim()
                              : null);

                      WidgetBuilder? nextRoute;
                      if (vm.isLactatingFemale) {
                        nextRoute = (_) => const BreedingEntryScreen(
                              continueToProduction: true,
                            );
                      } else if (vm.isBreedableFemaleOnly) {
                        nextRoute = (_) => const BreedingEntryScreen();
                      }

                      if (!context.mounted) return;

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AddHealthEventScreen(
                            initialAnimalRef: animalRef,
                            nextScreenBuilder: (_) => AddVaccinationScreen(
                              initialAnimalRef: animalRef,
                              nextScreenBuilder: nextRoute,
                            ),
                          ),
                        ),
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
