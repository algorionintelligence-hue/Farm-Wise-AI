import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/themes/app_colors.dart';
import '../../../core/utils/sizes.dart';
import '../../../core/widgets/DropDownFieldWithBg.dart';
import '../../../l10n/AppLocalizations.dart';

class ForecastData {
  final String month;
  final double h1;
  final double h2;
  final double h3;

  ForecastData(this.month, this.h1, this.h2, this.h3);
}

final selectedMonthsProvider = StateProvider<int>((ref) => 3);

final forecastDataProvider = Provider<List<ForecastData>>((ref) {
  return [
    ForecastData('Apr', 130, 80, 40),
    ForecastData('May', 160, 95, 55),
    ForecastData('Jun', 125, 80, 45),
    ForecastData('Jul', 140, 90, 60),
    ForecastData('Aug', 170, 110, 70),
    ForecastData('Sep', 150, 100, 50),
    ForecastData('Oct', 165, 105, 65),
    ForecastData('Nov', 180, 120, 80),
    ForecastData('Dec', 190, 130, 90),
    ForecastData('Jan', 145, 85, 45),
    ForecastData('Feb', 155, 95, 55),
    ForecastData('Mar', 175, 115, 75),
  ];
});

class AdvancedForecastCard extends ConsumerWidget {
  const AdvancedForecastCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedMonths = ref.watch(selectedMonthsProvider);
    final allData = ref.watch(forecastDataProvider);
    final visibleData = allData.take(selectedMonths).toList();
    final l10n = AppLocalizations.of(context)!;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(sizes.cardRadiusLg),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(sizes.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.forecast,
                style: const TextStyle(
                  color: UColors.colorPrimary,
                  fontSize: sizes.fontSizeLg,
                  fontWeight: FontWeight.bold,
                ),
              ),
              DropDownFieldWithBg(
                value: selectedMonths,
                items: const [3, 6, 9, 12],
                itemLabelBuilder: (val) => l10n.nextMonths(val),
                onChanged: (newValue) {
                  if (newValue != null) {
                    ref.read(selectedMonthsProvider.notifier).state = newValue;
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: sizes.defaultSpace),
          SizedBox(
            height: 200,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: ['4.0M', '3.0M', '2.0M', '1.0M', '0.0M']
                      .map(
                        (label) => Text(
                          label,
                          style: TextStyle(
                            color: UColors.darkGrey,
                            fontSize: sizes.fontSizeSm - 2,
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(width: sizes.sm),
                Expanded(
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          5,
                          (index) => Container(height: 1, color: UColors.grey),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: sizes.sm),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: visibleData
                                .map(
                                  (data) => Padding(
                                    padding: const EdgeInsets.only(right: sizes.lg),
                                    child: _buildMonthBarGroup(data),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthBarGroup(ForecastData data) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _gradientBar(data.h1, [UColors.gradientBarGreen1, UColors.gradientBarGreen2]),
              _gradientBar(data.h2, [UColors.gradientBarBlue1, UColors.gradientBarBlue2]),
              _gradientBar(data.h3, [UColors.gradientBarPurple1, UColors.gradientBarPurple2]),
            ],
          ),
        ),
        const SizedBox(height: sizes.sm),
        Text(
          data.month,
          style: const TextStyle(
            color: Color(0xFF4A5568),
            fontSize: sizes.fontSizeSm,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _gradientBar(double targetHeight, List<Color> colors) {
    return TweenAnimationBuilder<double>(
      key: ValueKey(targetHeight),
      tween: Tween<double>(begin: 0.0, end: targetHeight),
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeOutBack,
      builder: (context, height, child) {
        return Container(
          width: sizes.xl,
          height: height,
          margin: const EdgeInsets.symmetric(horizontal: 1),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: colors,
            ),
          ),
        );
      },
    );
  }
}
