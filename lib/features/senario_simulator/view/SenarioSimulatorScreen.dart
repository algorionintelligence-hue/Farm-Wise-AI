import 'package:farm_wise_ai/core/widgets/AppScaffoldBgBasic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/Utils/sizes.dart';
import '../../../core/themes/app_colors.dart';
import '../ViewModel/SenarioSimulatorViewModel.dart';

class ScenarioSimulatorScreen extends ConsumerWidget {
  const ScenarioSimulatorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(scenarioProvider);
    final viewModel = ref.read(scenarioProvider.notifier);

    return AppScaffoldBgBasic(
      showBackButton: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Scenario Simulator",
            style: TextStyle(
              color: UColors.colorPrimary,
              fontSize: sizes.fontSizeHeadings,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: sizes.spaceBtwSections),

          const Text(
            "Sliders",
            style: TextStyle(
              color: UColors.textSecondary,
              fontSize: sizes.fontSizeLg,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: sizes.md),
          Container(
            padding: EdgeInsets.only(
              top: sizes.lg,
              bottom: sizes.lg,
              left: sizes.lg,
              right: sizes.lg,
            ),
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
                // --- Slider Widgets ---
                _buildSlider(
                  label: "Feed price",
                  value: state.feedPrice,
                  onChanged: (val) => viewModel.updateFeed(val),
                ),
                _buildSlider(
                    label: "Milk price",
                    value: state.milkPrice,
                    onChanged: (val) => viewModel.updateMilk(val)),

                _buildSlider(
                  label: "Pregnancy rate",
                  value: state.pregnancyRate,
                  onChanged: (val) => viewModel.updatePregnancy(val),
                ),
              ],
            ),
          ),
          SizedBox(height: sizes.spaceBtwSections),

          const Text(
            "Output",
            style: TextStyle(
              color: UColors.textSecondary,
              fontSize: sizes.fontSizeLg,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: sizes.md),

          // --- Result Card Widget ---
          _buildResultCard(viewModel.calculatedProfit, 31)
        ],
      ),
    );
  }

  // --- Reusable Component: Slider ---
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
          // Label Row
          Row(
            children: [
              const Text("• ", style: TextStyle(color: UColors.textDark)),
              Text(
                "$label ${value >= 0 ? '+' : ''}${value.toInt()}%",
                style: const TextStyle(
                    color: UColors.textDark, fontSize: sizes.fontSizeSm),
              ),
            ],
          ),
          const SizedBox(height: sizes.sm),

          // Custom Neumorphic Slider
          LayoutBuilder(
            builder: (context, constraints) {
              double width = constraints.maxWidth;
              // Map value (-50 to 50) to local position (0 to width)
              double thumbPosition = ((value + 50) / 100) * width;

              return GestureDetector(
                onHorizontalDragUpdate: (details) {
                  double localX = details.localPosition.dx;
                  // Calculate percentage from position and map back to -50 to 50
                  double newValue = ((localX / width) * 100) - 50;
                  onChanged(newValue.clamp(-50.0, 50.0));
                },
                child: SizedBox(
                  height: 35, // Height of the slider area
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      // 1. The Inset Track (The "Groove")
                      Container(
                        height: 12,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE0E0E0), // Base track color
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            // Inner Shadow Top Left (Dark)
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              offset: const Offset(1, 1),
                              blurRadius: 2,
                              spreadRadius: 1,
                            ),
                            // Inner Shadow Bottom Right (Light)
                            const BoxShadow(
                              color: Colors.white,
                              offset: Offset(-1, -1),
                              blurRadius: 2,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                      ),

                      // 2. The Active Progress (The Green Line inside the groove)
                      Container(
                        height: 4,
                        width: thumbPosition.clamp(0.0, width),
                        margin: const EdgeInsets.only(left: 6),
                        decoration: BoxDecoration(
                          color: UColors.plantaGreen,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),

                      // 3. The Neumorphic Thumb (The orange circular button)
                      Positioned(
                        left: thumbPosition - 15, // Center the 30px thumb
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xFFFFA726), // Light orange top
                                Color(0xFFE65100), // Darker orange bottom
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
                            // Small vertical line detail on thumb
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

  // --- Reusable Component: Result Card ---
  Widget _buildResultCard(double profit, int days) {
    // Formatting number with commas
    final String formattedProfit = profit.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );

    return Container(
      width: double.infinity,
      // Increased padding for a "large box" feel
      padding: const EdgeInsets.all(sizes.lg),
      decoration: BoxDecoration(
        // Large bold gradient background
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            UColors.gradientBarGreen1,
            UColors.gradientOrange2,
          ],
        ),
        borderRadius: BorderRadius.circular(sizes.cardRadiusLg), // Using larger radius
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
            "New Profit: PKR $formattedProfit",
            style: const TextStyle(
              color: UColors.white,
              fontFamily: 'monospace',
              fontSize: sizes.fontSizeLg,
              fontWeight: FontWeight.w600
            ),
          ),
          const SizedBox(height: sizes.sm),
          Row(
            children: [
              Text(
                "Cash Runway: $days days",
                style: const TextStyle(
                  color: UColors.white,
                  fontFamily: 'monospace',
                  fontSize: sizes.fontSizeLg,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: sizes.xs),
              const Icon(Icons.arrow_downward,
                  color: UColors.error, size: sizes.iconSm),
            ],
          ),
        ],
      ),
    );
  }
}
