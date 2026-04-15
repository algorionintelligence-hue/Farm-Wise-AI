import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

import '../../../core/themes/app_colors.dart';
import '../../../core/utils/sizes.dart';
import '../viewmodel/herd_viewmodel.dart';
import 'CustomInput.dart';

class ProductionStep extends ConsumerStatefulWidget {
  const ProductionStep({super.key});

  @override
  ConsumerState<ProductionStep> createState() => _ProductionStepState();
}

class _ProductionStepState extends ConsumerState<ProductionStep> {
  DateTime selectedDate = DateTime.now();
  bool isMorningSession = true;
  bool soldToBuyer = true;

  @override
  Widget build(BuildContext context) {
    ref.watch(herdProvider);
    final vm = ref.watch(herdProvider.notifier);

    final litres = double.tryParse(vm.avgMilkController.text) ?? 0;
    final price = double.tryParse(vm.milkPriceController.text) ?? 0;
    final transport = double.tryParse(vm.feedCostController.text) ?? 0;
    final gross = soldToBuyer ? litres * price : 0;
    final net = gross - transport;

    final weekData = <double>[28, 36, 30, 40, 33, 35, litres];
    final day = DateFormat('EEE').format(selectedDate);
    final dateText = DateFormat('dd MMM yyyy').format(selectedDate);

    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: sizes.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Daily Milk Entry',
            style: TextStyle(
              fontSize: sizes.fontSizeLg,
              fontWeight: FontWeight.w800,
              color: UColors.textPrimary,
            ),
          ),
          const SizedBox(height: 2),
          const Text(
            'Record morning & evening sessions',
            style: TextStyle(fontSize: 12, color: UColors.textSecondary),
          ),
          const SizedBox(height: sizes.sm),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: sizes.sm, vertical: sizes.xs),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(sizes.cardRadiusMd),
              border: Border.all(color: UColors.borderPrimary),
            ),
            child: Row(
              children: [
                _circleIconButton(
                  icon: Icons.chevron_left_rounded,
                  onTap: () => setState(
                    () => selectedDate = selectedDate.subtract(const Duration(days: 1)),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        '$day - $dateText',
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: UColors.colorPrimary,
                        ),
                      ),
                      const Text(
                        'Tap to change date',
                        style: TextStyle(fontSize: 11, color: UColors.textSecondary),
                      ),
                    ],
                  ),
                ),
                _circleIconButton(
                  icon: Icons.chevron_right_rounded,
                  onTap: () => setState(
                    () => selectedDate = selectedDate.add(const Duration(days: 1)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: sizes.sm),
          Row(
            children: [
              Expanded(
                child: _statCard(
                  title: 'Today total',
                  value: litres.toStringAsFixed(0),
                  unit: 'litres',
                  dark: true,
                ),
              ),
              const SizedBox(width: sizes.xs),
              Expanded(
                child: _statCard(
                  title: 'This week avg',
                  value: (weekData.reduce((a, b) => a + b) / weekData.length)
                      .toStringAsFixed(0),
                  unit: 'L/day',
                ),
              ),
              const SizedBox(width: sizes.xs),
              Expanded(
                child: _statCard(
                  title: 'Revenue today',
                  value: gross.toStringAsFixed(0),
                  unit: 'PKR',
                ),
              ),
            ],
          ),
          const SizedBox(height: sizes.sm),
          Container(
            padding: const EdgeInsets.all(sizes.sm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(sizes.cardRadiusMd),
              border: Border.all(color: UColors.borderPrimary),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Last 7 days production',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
                ),
                const SizedBox(height: sizes.sm),
                SizedBox(
                  height: 86,
                  child: BarChart(
                    BarChartData(
                      maxY: (weekData.reduce((a, b) => a > b ? a : b) + 10)
                          .clamp(10, 9999)
                          .toDouble(),
                      minY: 0,
                      alignment: BarChartAlignment.spaceAround,
                      gridData: const FlGridData(show: false),
                      borderData: FlBorderData(show: false),
                      barTouchData: BarTouchData(enabled: false),
                      titlesData: FlTitlesData(
                        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        rightTitles:
                            const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 18,
                            getTitlesWidget: (value, _) {
                              const labels = [
                                'Mon',
                                'Tue',
                                'Wed',
                                'Thu',
                                'Fri',
                                'Sat',
                                'Today',
                              ];
                              final i = value.toInt();
                              if (i < 0 || i >= labels.length) return const SizedBox.shrink();
                              final isToday = i == labels.length - 1;
                              return Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(
                                  labels[i],
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: isToday
                                        ? UColors.colorPrimary
                                        : UColors.textSecondary,
                                    fontWeight:
                                        isToday ? FontWeight.w700 : FontWeight.w500,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      barGroups: List.generate(weekData.length, (i) {
                        final isToday = i == weekData.length - 1;
                        return BarChartGroupData(
                          x: i,
                          barsSpace: 4,
                          barRods: [
                            BarChartRodData(
                              toY: weekData[i],
                              width: 14,
                              borderRadius: const BorderRadius.all(Radius.circular(4)),
                              color: isToday ? UColors.colorPrimary : UColors.grey,
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: sizes.md),
          Container(
            padding: const EdgeInsets.all(sizes.sm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(sizes.cardRadiusMd),
              border: Border.all(color: UColors.borderPrimary),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _sessionChip(
                        title: 'Morning session',
                        active: isMorningSession,
                        onTap: () => setState(() => isMorningSession = true),
                      ),
                    ),
                    const SizedBox(width: sizes.xs),
                    Expanded(
                      child: _sessionChip(
                        title: 'Evening session',
                        active: !isMorningSession,
                        onTap: () => setState(() => isMorningSession = false),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: sizes.sm),
                CustomInput(
                  label: 'Total litres collected *',
                  controller: vm.avgMilkController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                ),
                const SizedBox(height: sizes.xs),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Sold to buyer?',
                    style: TextStyle(
                      fontSize: 12,
                      color: UColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Expanded(
                      child: _sessionChip(
                        title: 'Yes - sold',
                        active: soldToBuyer,
                        onTap: () => setState(() => soldToBuyer = true),
                      ),
                    ),
                    const SizedBox(width: sizes.xs),
                    Expanded(
                      child: _sessionChip(
                        title: 'No - kept',
                        active: !soldToBuyer,
                        onTap: () => setState(() => soldToBuyer = false),
                      ),
                    ),
                  ],
                ),
                if (soldToBuyer) ...[
                  const SizedBox(height: sizes.sm),
                  Row(
                    children: [
                      Expanded(
                        child: CustomInput(
                          label: 'Litres sold *',
                          controller: vm.avgMilkController,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        ),
                      ),
                      const SizedBox(width: sizes.sm),
                      Expanded(
                        child: CustomInput(
                          label: 'Price / litre (PKR)',
                          controller: vm.milkPriceController,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        ),
                      ),
                    ],
                  ),
                  CustomInput(
                    label: 'Transport cost (PKR)',
                    controller: vm.feedCostController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: sizes.sm),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(sizes.md),
            decoration: BoxDecoration(
              color: UColors.colorPrimary,
              borderRadius: BorderRadius.circular(sizes.cardRadiusMd),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Net revenue (this session)',
                  style: TextStyle(color: Colors.white70, fontSize: 11),
                ),
                Text(
                  'PKR ${net.toStringAsFixed(0)}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const Text(
                  'Gross - transport cost',
                  style: TextStyle(color: Colors.white70, fontSize: 11),
                ),
              ],
            ),
          ),
          const SizedBox(height: sizes.sm),
          Row(
            children: [
              const Expanded(
                child: _smallMetaField(
                  label: 'Linked to farm record',
                  value: 'Main Farm',
                ),
              ),
              const SizedBox(width: sizes.sm),
              Expanded(
                child: _smallMetaField(
                  label: 'Record date',
                  value: dateText,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _circleIconButton({required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: UColors.borderPrimary),
        ),
        child: Icon(icon, size: 16, color: UColors.textSecondary),
      ),
    );
  }

  Widget _statCard({
    required String title,
    required String value,
    required String unit,
    bool dark = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(sizes.sm),
      decoration: BoxDecoration(
        color: dark ? UColors.colorPrimary : Colors.white,
        borderRadius: BorderRadius.circular(sizes.borderRadiusMd),
        border: Border.all(color: dark ? UColors.colorPrimary : UColors.borderPrimary),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              color: dark ? Colors.white70 : UColors.textSecondary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: dark ? Colors.white : UColors.textPrimary,
            ),
          ),
          Text(
            unit,
            style: TextStyle(
              fontSize: 10,
              color: dark ? Colors.white70 : UColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _sessionChip({
    required String title,
    required bool active,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: active ? UColors.colorPrimaryLight : UColors.inputBg,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: active ? UColors.colorPrimary : UColors.borderPrimary,
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: active ? UColors.colorPrimary : UColors.textSecondary,
          ),
        ),
      ),
    );
  }
}

class _smallMetaField extends StatelessWidget {
  final String label;
  final String value;

  const _smallMetaField({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: UColors.textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: sizes.sm, vertical: 10),
          decoration: BoxDecoration(
            color: UColors.inputBg,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: UColors.borderPrimary),
          ),
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
