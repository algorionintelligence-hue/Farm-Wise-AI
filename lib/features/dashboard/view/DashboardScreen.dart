import 'package:farm_wise_ai/core/widgets/AppScaffoldBg.dart';
import 'package:farm_wise_ai/features/dashboard/view/top_ai_actions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/Utils/sizes.dart';
import '../../../core/themes/app_colors.dart';
import 'ForecastData.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppScaffoldBg(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildGreeting(),
          const SizedBox(height: sizes.md),
          _buildCombinedFinancialCard(),
          // const SizedBox(height: sizes.md),
          // _buildThisMonthCard(),
          const SizedBox(height: sizes.md),
          AdvancedForecastCard(),
          const SizedBox(height: sizes.md),
          AiActionsCard(
            actions: [
              {
                'title': 'Reduce open days',
                'subtitle': 'PKR 120k/month loss',
                'icon': Icons.trending_down,
                'color': UColors.error,
                'subtitleTextColor': UColors.error
              },
              {
                'title': 'Feed cost_form high, milk flat',
                'subtitle': 'Optimize ration balance',
                'icon': Icons.warning_amber_rounded,
                'color': UColors.warning,
                'subtitleTextColor': UColors.warning
              },
              {
                'title': 'Sell male calves in April',
                'subtitle': 'Forecasted cash injection',
                'icon': Icons.sell_outlined,
                'color': UColors.success,
                'subtitleTextColor': UColors.success
              },
            ],
          ),
          const SizedBox(height: sizes.lg), // Bottom padding
        ],
      ),
    );
  }

  Widget _buildGreeting() {
    return RichText(
      text: const TextSpan(
        style: TextStyle(color: UColors.textDark, fontSize: sizes.fontSizeLg),
        children: [
          TextSpan(text: 'Welcome, '),
          TextSpan(
            text: 'Ahmed Farm',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildCombinedFinancialCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        // Keep your provided colors
        gradient: const LinearGradient(
          colors: [Color(0xFF384A24), Color(0xFF388540)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(sizes.scaffoldTopRadius), // 28.0
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: sizes.sm, // 8.0
            offset: const Offset(0, sizes.xs), // 4.0
          ),
        ],
      ),
      child: Column(
        children: [
          // Top Section: Information
          Padding(
            padding: const EdgeInsets.all(sizes.lg), // 24.0
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Cash Runway',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: sizes.fontSizeMd, // 16.0
                  ),
                ),
                const SizedBox(height: sizes.sm), // 8.0
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'PKR 320,000',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: sizes.lg,
                        // 32.0 (using xl as it matches 32.0)
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // The "Days" Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: sizes.md,
                        vertical: sizes.xs,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius:
                            BorderRadius.circular(sizes.buttonRadius), // 20.0
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.arrow_drop_up,
                              color: Colors.white, size: sizes.iconSm),
                          Text(
                            '47 Days',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: sizes.fontSizeSm, // 14.0
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: sizes.spaceBtwItems), // 16.0
                Row(
                  children: [
                    const Icon(Icons.trending_up,
                        color: Colors.white70, size: sizes.iconSm),
                    const SizedBox(width: sizes.xs),
                    Text(
                      'PKR 1,896 Today\'s Growth',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: sizes.fontSizeSm,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Bottom Section: The White "Action" Bar
          _cashDetails()
        ],
      ),
    );
  }

  Widget _cashDetails() {
    return Container(
      margin: const EdgeInsets.fromLTRB(sizes.md, 0, sizes.md, sizes.md),
      padding: const EdgeInsets.symmetric(vertical: sizes.spaceBtwItems),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(sizes.cardRadiusLg), // 16.0
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildModernAction(Icons.analytics_outlined, 'Revenue', '680k'),
          _buildVerticalDivider(),
          _buildModernAction(Icons.arrow_upward, 'Cost', '560k'),
          _buildVerticalDivider(),
          _buildModernAction(Icons.arrow_forward, 'Profit', '120k'),
        ],
      ),
    );
  }

  Widget _buildModernAction(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFF388540), size: sizes.iconMd), // 24.0
        const SizedBox(height: sizes.xs),
        Text(
          label,
          style:
              const TextStyle(color: Colors.grey, fontSize: sizes.fontSizeSm),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Color(0xFF384A24),
            fontWeight: FontWeight.bold,
            fontSize: sizes.fontSizeSm,
          ),
        ),
      ],
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      height: sizes.xl, // 32.0
      width: 1,
      color: Colors.grey.withOpacity(0.3),
    );
  }
}

final Widget customHeaderRow = Container(
  color: UColors.colorPrimary,
  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: sizes.md),
  child: Row(
    children: [
      /// Leading menu icon
      IconButton(
        icon: const Icon(Icons.menu, color: Colors.white, size: 28),
        onPressed: () {
          print('Menu tapped');
        },
      ),

      /// Title
      Expanded(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Farm ka ',
              style: TextStyle(
                color: UColors.white,
                fontSize: sizes.fontSizeHeadings,
                fontWeight: FontWeight.w700,
              ),
            ),
            Stack(
              clipBehavior: Clip.none,
              children: [
                const Text(
                  'CFO',
                  style: TextStyle(
                    color: UColors.white,
                    fontSize: sizes.fontSizeHeadings,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                // Positioned(
                //   top: -8,
                //   left: -8,
                //   child: Icon(
                //     Icons.eco_outlined,
                //     color: UColors.colorPrimary.withOpacity(0.8),
                //     size: 16,
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),

      /// Actions
      GestureDetector(
        onTap: () {
          print('Profile tapped');
        },
        child: const CircleAvatar(
          radius: sizes.circularImageRadius,
          backgroundColor: Colors.white24,
          child: Icon(Icons.person,
              color: Colors.white, size: sizes.circularImageIcon),
        ),
      ),
    ],
  ),
);
