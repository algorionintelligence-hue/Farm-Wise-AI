import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/sizes.dart';
import '../../../core/themes/app_colors.dart';
import '../../../core/widgets/AppScaffoldBgBasic.dart';
import '../../../core/widgets/PrimaryButton.dart';
import '../../../l10n/app_localizations.dart';
import '../viewmodel/herd_viewmodel.dart';
import '../widgets/AnimalInfoStep.dart';
import '../widgets/BreedingStep.dart';
import '../widgets/ProductionStep.dart';

class HerdStepperScreen extends ConsumerWidget {
  const HerdStepperScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(herdProvider.notifier);
    final l10n = AppLocalizations.of(context)!;

    return AppScaffoldBgBasic(
      showBackButton: true,
      // headerTitle: "Animal Registration",
      // headerSubtitle: "Register your herd_form animals",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ──
          Text(
            l10n.animalRegistrationTitle,
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

          // ── Timeline ──
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _TimelineStep(
                    number: 1,
                    title: l10n.animalInfoStepTitle,
                    icon: Icons.pets_rounded,
                    isLast: false,
                    child: const AnimalInfoStep(),
                  ),
                  _TimelineStep(
                    number: 2,
                    title: l10n.breeding,
                    icon: Icons.favorite_rounded,
                    isLast: false,
                    child: const BreedingStep(),
                  ),

                  _TimelineStep(
                    number: 3,
                    title: l10n.productionStepTitle,
                    icon: Icons.water_drop_rounded,
                    isLast: false,
                    child: const ProductionStep(),
                  ),

                  const SizedBox(height: sizes.spaceBtwSections),

                  PrimaryButton(
                    label: l10n.save,
                    onPressed: () {
                      vm.save();
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

// ── Timeline Step ───────────────────────────────
class _TimelineStep extends StatelessWidget {
  final int number;
  final String title;
  final IconData icon;
  final bool isLast;
  final Widget child;

  const _TimelineStep({
    required this.number,
    required this.title,
    required this.icon,
    required this.isLast,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Left: Circle + Line ──
          SizedBox(
            width: 48,
            child: Column(
              children: [
                // Circle
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: UColors.colorPrimary,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: UColors.colorPrimary.withOpacity(0.3),
                        blurRadius: 8,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(icon, color: Colors.white, size: 16),
                  ),
                ),

                // Vertical line — only if not last
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        color: UColors.colorPrimary.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(width: sizes.sm),

          // ── Right: Title + Content ──
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Step number + title row
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: sizes.sm, vertical: sizes.xs),
                      decoration: BoxDecoration(
                        color: UColors.colorPrimary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        l10n.stepLabel(number),
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: UColors.colorPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(width: sizes.sm),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: sizes.fontSizeMd,
                        fontWeight: FontWeight.w800,
                        color: UColors.colorPrimary,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: sizes.xs),

                // Step content
                child,

                if (!isLast) const SizedBox(height: sizes.lg),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
