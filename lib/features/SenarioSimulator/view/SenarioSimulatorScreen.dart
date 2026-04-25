import 'package:farm_wise_ai/core/widgets/AppScaffoldBgBasic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/themes/app_colors.dart';
import '../../../core/utils/sizes.dart';
import '../../../l10n/AppLocalizations.dart';
import '../viewmodel/SenarioSimulatorViewModel.dart';

class ScenarioSimulatorScreen extends ConsumerWidget {
  const ScenarioSimulatorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(scenarioProvider);
    final viewModel = ref.read(scenarioProvider.notifier);
    final l10n = AppLocalizations.of(context)!;

    return AppScaffoldBgBasic(
      showBackButton: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.scenarioSimulatorTitle,
            style: const TextStyle(
              color: UColors.colorPrimary,
              fontSize: sizes.fontSizeHeadings,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: sizes.spaceBtwSections),
          Text(
            l10n.sliders,
            style: const TextStyle(
              color: UColors.textSecondary,
              fontSize: sizes.fontSizeLg,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: sizes.md),
          Container(
            padding: const EdgeInsets.all(sizes.lg),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(sizes.cardRadiusLg),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildSlider(
                  label: l10n.feedPrice,
                  value: state.feedPrice,
                  onChanged: (val) => viewModel.updateFeed(val),
                ),
                _buildSlider(
                  label: l10n.milkPrice,
                  value: state.milkPrice,
                  onChanged: (val) => viewModel.updateMilk(val),
                ),
                _buildSlider(
                  label: l10n.pregnancyRate,
                  value: state.pregnancyRate,
                  onChanged: (val) => viewModel.updatePregnancy(val),
                ),
              ],
            ),
          ),
          const SizedBox(height: sizes.spaceBtwSections),
          Text(
            l10n.output,
            style: const TextStyle(
              color: UColors.textSecondary,
              fontSize: sizes.fontSizeLg,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: sizes.md),
          _buildResultCard(viewModel.calculatedProfit, 31, l10n),
        ],
      ),
    );
  }

  Widget _buildSlider({
    required String label,
    required double value,
    required ValueChanged<double> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: sizes.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('� ', style: TextStyle(color: UColors.textDark)),
              Text(
                '$label ${value >= 0 ? '+' : ''}${value.toInt()}%',
                style: const TextStyle(
                  color: UColors.textDark,
                  fontSize: sizes.fontSizeSm,
                ),
              ),
            ],
          ),
          const SizedBox(height: sizes.sm),
          LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              final thumbPosition = ((value + 50) / 100) * width;

              return GestureDetector(
                onHorizontalDragUpdate: (details) {
                  final localX = details.localPosition.dx;
                  final newValue = ((localX / width) * 100) - 50;
                  onChanged(newValue.clamp(-50.0, 50.0));
                },
                child: SizedBox(
                  height: 35,
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Container(
                        height: 12,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE0E0E0),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              offset: const Offset(1, 1),
                              blurRadius: 2,
                              spreadRadius: 1,
                            ),
                            const BoxShadow(
                              color: Colors.white,
                              offset: Offset(-1, -1),
                              blurRadius: 2,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 4,
                        width: thumbPosition.clamp(0.0, width),
                        margin: const EdgeInsets.only(left: 6),
                        decoration: BoxDecoration(
                          color: UColors.plantaGreen,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      Positioned(
                        left: thumbPosition - 15,
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xFFFFA726),
                                Color(0xFFE65100),
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                offset: const Offset(2, 2),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Container(
                              width: 2,
                              height: 12,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(1),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildResultCard(double profit, int daysValue, AppLocalizations l10n) {
    final formattedProfit = profit.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(sizes.lg),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            UColors.gradientBarGreen1,
            UColors.gradientOrange2,
          ],
        ),
        borderRadius: BorderRadius.circular(sizes.cardRadiusLg),
        boxShadow: [
          BoxShadow(
            color: UColors.gradientOrange2.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${l10n.newProfit}: PKR $formattedProfit',
            style: const TextStyle(
              color: UColors.white,
              fontFamily: 'monospace',
              fontSize: sizes.fontSizeLg,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: sizes.sm),
          Row(
            children: [
              Text(
                '${l10n.cashRunwayTitle}: $daysValue ${l10n.days}',
                style: const TextStyle(
                  color: UColors.white,
                  fontFamily: 'monospace',
                  fontSize: sizes.fontSizeLg,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: sizes.xs),
              const Icon(Icons.arrow_downward, color: UColors.error, size: sizes.iconSm),
            ],
          ),
        ],
      ),
    );
  }
}
