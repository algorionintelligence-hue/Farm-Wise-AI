import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/themes/app_colors.dart';
import '../../../core/utils/sizes.dart';
import '../../../core/widgets/AppScaffoldBgBasic.dart';
import '../../../core/widgets/PrimaryButton.dart';
import '../../../l10n/app_localizations.dart';
import '../../breeding_form/view/BreedingEntryScreen.dart';
import '../../production_form/view/ProductionEntryScreen.dart';
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
                    onPressed: () {
                      final errorKey = vm.validateBreedingStageRule();
                      if (errorKey != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(l10n.calfCannotHaveBreedingDatesError)),
                        );
                        return;
                      }

                      // Save animal
                      vm.save();
                      ref.read(herdStoreProvider.notifier).upsert(vm.state);

                      // Navigation Logic
                      if (vm.isLactatingFemale) {
                        // 1. Lactating Female -> Show Prompt for BOTH Production and Breeding
                        _showLactatingPrompt(context, l10n);
                      } else if (vm.isBreedableFemaleOnly) {
                        // 2. Breedable Female -> Direct to Breeding screen
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

  void _showLactatingPrompt(BuildContext context, AppLocalizations l10n) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(sizes.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40, height: 4,
                decoration: BoxDecoration(color: UColors.grey, borderRadius: BorderRadius.circular(2)),
              ),
              const SizedBox(height: sizes.md),
              const Icon(Icons.check_circle_rounded, color: UColors.plantaGreen, size: 48),
              const SizedBox(height: sizes.sm),
              Text(
                l10n.nextStepPromptTitle,
                style: const TextStyle(fontSize: sizes.fontSizeLg, fontWeight: FontWeight.w800, color: UColors.colorPrimary),
              ),
              const SizedBox(height: sizes.xs),
              Text(l10n.nextStepPromptSubtitle, style: const TextStyle(color: UColors.textSecondary)),
              const SizedBox(height: sizes.lg),
              _PromptOptionTile(
                icon: Icons.opacity_rounded,
                title: l10n.productionStepTitle,
                subtitle: l10n.productionPromptSubtitle,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ProductionEntryScreen()));
                },
              ),
              _PromptOptionTile(
                icon: Icons.favorite_rounded,
                title: l10n.addBreeding,
                subtitle: l10n.breedingPromptSubtitle,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const BreedingEntryScreen()));
                },
              ),
              _PromptOptionTile(
                icon: Icons.dashboard_rounded,
                title: l10n.dashboard,
                subtitle: l10n.dashboardPromptSubtitle,
                color: UColors.textSecondary,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: sizes.md),
            ],
          ),
        );
      },
    );
  }
}

class _PromptOptionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Color color;

  const _PromptOptionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.color = UColors.colorPrimary,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: sizes.sm),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(sizes.cardRadiusMd),
        child: Container(
          padding: const EdgeInsets.all(sizes.md),
          decoration: BoxDecoration(
            border: Border.all(color: UColors.borderPrimary),
            borderRadius: BorderRadius.circular(sizes.cardRadiusMd),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(sizes.sm),
                decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: sizes.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: TextStyle(fontSize: sizes.fontSizeMd, fontWeight: FontWeight.bold, color: color)),
                    Text(subtitle, style: const TextStyle(fontSize: sizes.fontSizeVerySm, color: UColors.textSecondary)),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: UColors.darkGrey),
            ],
          ),
        ),
      ),
    );
  }
}
