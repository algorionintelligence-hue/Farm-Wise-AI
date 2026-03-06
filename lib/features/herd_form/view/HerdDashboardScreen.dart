import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/Utils/sizes.dart';
import '../../../core/themes/app_colors.dart';
import '../../../core/widgets/AppScaffoldBgBasic.dart';
import '../viewmodel/herd_viewmodel.dart';

// ═══════════════════════════════════════════════
// HerdDashboardScreen — Consistent UI
// ═══════════════════════════════════════════════

class HerdDashboardScreen extends ConsumerWidget {
  const HerdDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(herdProvider.notifier);

    final revenue = vm.monthlyRevenue();
    final cost = vm.monthlyCost();
    final profit = vm.monthlyProfit();
    final calves = vm.expectedCalves();

    return AppScaffoldBgBasic(
      showBackButton: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header Title ──────────────────────────
          const Text(
            "Farm Dashboard",
            style: TextStyle(
              fontSize: sizes.fontSizeLg,
              fontWeight: FontWeight.w800,
              color: UColors.colorPrimary,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            "Monthly overview of your herd_form",
            style: TextStyle(
              fontSize: sizes.fontSizeSm,
              color: UColors.textSecondary,
            ),
          ),

          const SizedBox(height: 28),

          // ── Summary Cards Row ─────────────────────
          Row(
            children: [
              Expanded(
                child: _SummaryCard(
                  icon: Icons.trending_up_rounded,
                  label: "Revenue",
                  value: "Rs. ${revenue.toStringAsFixed(0)}",
                  iconColor: UColors.success,
                  bgColor: const Color(0xFFEDF7ED),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _SummaryCard(
                  icon: Icons.trending_down_rounded,
                  label: "Cost",
                  value: "Rs. ${cost.toStringAsFixed(0)}",
                  iconColor: UColors.error,
                  bgColor: const Color(0xFFFDEDED),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // ── Profit Card  ─
          _ProfitCard(profit: profit),

          const SizedBox(height: 12),

          // ── Expected Calves ───────────────────────
          _InfoCard(
            icon: Icons.pets_rounded,
            label: "Expected Calves (next 6 months)",
            value: calves.toString(),
          ),

          const SizedBox(height: 28),

          // ── Section Title ─────────────────────────
          const Text(
            "Monthly Breakdown",
            style: TextStyle(
              fontSize: sizes.fontSizeMd,
              fontWeight: FontWeight.w700,
              color: UColors.colorPrimary,
            ),
          ),
          const SizedBox(height: 12),

          // ── Bar Chart Visual ──────────────────────
          _BarChart(revenue: revenue, cost: cost, profit: profit),
        ],
      ),
    );
  }
}


// ═══════════════════════════════════════════════
// Summary Card (Revenue / Cost)
// ═══════════════════════════════════════════════

class _SummaryCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color iconColor;
  final Color bgColor;

  const _SummaryCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.iconColor,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: iconColor.withOpacity(0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: UColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: sizes.fontSizeMd,
              fontWeight: FontWeight.w800,
              color: iconColor,
            ),
          ),
        ],
      ),
    );
  }
}


// ═══════════════════════════════════════════════
// Profit Card
// ═══════════════════════════════════════════════

class _ProfitCard extends StatelessWidget {
  final double profit;
  const _ProfitCard({required this.profit});

  @override
  Widget build(BuildContext context) {
    final isPositive = profit >= 0;
    final color = isPositive ? UColors.colorPrimary : UColors.error;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        color: isPositive ? UColors.colorPrimary : UColors.error,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Monthly Profit",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white70,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Rs. ${profit.abs().toStringAsFixed(0)}",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              isPositive
                  ? Icons.arrow_upward_rounded
                  : Icons.arrow_downward_rounded,
              color: Colors.white,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}


// ═══════════════════════════════════════════════
// Info Card (Calves)
// ═══════════════════════════════════════════════

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: UColors.inputBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: UColors.borderPrimary),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: UColors.colorPrimary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: UColors.colorPrimary, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: sizes.fontSizeSm,
                color: UColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: sizes.fontSizeMd,
              fontWeight: FontWeight.w800,
              color: UColors.colorPrimary,
            ),
          ),
        ],
      ),
    );
  }
}


// ═══════════════════════════════════════════════
// Simple Bar Chart
// ═══════════════════════════════════════════════

class _BarChart extends StatelessWidget {
  final double revenue;
  final double cost;
  final double profit;

  const _BarChart({
    required this.revenue,
    required this.cost,
    required this.profit,
  });

  @override
  Widget build(BuildContext context) {
    final maxVal = [revenue, cost, profit.abs(), 1.0].reduce(
          (a, b) => a > b ? a : b,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _Bar(label: "Revenue", value: revenue, maxVal: maxVal,
            color: UColors.success),
        _Bar(label: "Cost", value: cost, maxVal: maxVal,
            color: UColors.error),
        _Bar(label: "Profit", value: profit, maxVal: maxVal,
            color: profit >= 0 ? UColors.colorPrimary : UColors.error),
      ],
    );
  }
}

class _Bar extends StatelessWidget {
  final String label;
  final double value;
  final double maxVal;
  final Color color;

  const _Bar({
    required this.label,
    required this.value,
    required this.maxVal,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final height = maxVal == 0 ? 0.0 : (value.abs() / maxVal) * 100;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          value.abs().toStringAsFixed(0),
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        AnimatedContainer(
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOut,
          width: 48,
          height: height.clamp(4.0, 100.0),
          decoration: BoxDecoration(
            color: color.withOpacity(0.85),
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(8),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: UColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}