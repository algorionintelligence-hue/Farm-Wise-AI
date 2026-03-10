import 'package:farm_wise_ai/core/widgets/AppScaffoldBg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils/sizes.dart';
import '../../../core/themes/app_colors.dart';

class BreedingDashboard extends ConsumerWidget {
  const BreedingDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppScaffoldBg(child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildGreeting(),
        const SizedBox(height: sizes.md),


        _buildFinanceCard(
          title: 'Conception Rate',
          value: '62%',
          subTitle: 'Target: 75%',
          gradient: [UColors.gradientBarGreen2, UColors.plantaGreen], // Green theme
          icon: Image.asset('lib/core/assets/icons/barbgone.png', ),
        ),

        const SizedBox(height: sizes.md),

        // 2. Open Days Cost
        _buildFinanceCard(
          title: 'Open Days Cost',
          value: 'PKR 96,000',
          subTitle: 'Extra Open Days: 420',
          gradient: [UColors.gradientOrange1, UColors.gradientOrange2], // Red theme
          icon: Image.asset('lib/core/assets/icons/bar_bg2.png'),
          footerLabel: '/ Month Loss',
        ),

        const SizedBox(height: sizes.md),

        // 3. Expected Calves
        _buildFinanceCard(
          title: 'Expected Calves',
          value: '18 Calves',
          subTitle: 'Next 60 Days Pipeline',
          gradient: [UColors.gradientDarkBlue1, UColors.gradientDarkBlue2], // Blue theme
          icon: Image.asset('lib/core/assets/icons/bar_bg3.png'),
        ),

        const SizedBox(height: sizes.md),

      ],
    ),
    );
  }

  Widget _buildGreeting() {
    return RichText(
      text: const TextSpan(
        style: TextStyle(color: UColors.textDark, fontSize: sizes.fontSizeLg),
        children: [
          TextSpan(
            text: 'Breeding Finance',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildFinanceCard({
    required String title,
    required String value,
    required String subTitle,
    required List<Color> gradient,
    required Widget icon,
    String? footerLabel,
  }) {
    return Container(
      width: double.infinity,
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(sizes.cardRadiusLg), //
        gradient: LinearGradient(
          colors: gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: gradient[0].withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background Decorative Wave Pattern
          Positioned(
            right: -1, // Pushes it off the right edge
            bottom: -10, // Pushes it off the bottom edge
            child: Opacity(
              opacity: 0.15, // Subtle transparency
              child: icon
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(sizes.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title.toUpperCase(),
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        letterSpacing: 1.2,
                        fontSize: sizes.fontSizeSm - 2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          value, //
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: sizes.fontSizeHeadingsLg,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        if (footerLabel != null)
                          Padding(
                            padding: const EdgeInsets.only(left: 6, bottom: 6),
                            child: Text(
                              footerLabel,
                              style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.w500),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),

                // Bottom Info Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(sizes.borderRadiusMd),
                  ),
                  child: Text(
                    subTitle, //
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: sizes.fontSizeSm,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}



