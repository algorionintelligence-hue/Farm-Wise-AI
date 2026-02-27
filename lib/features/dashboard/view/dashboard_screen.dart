import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/sizes.dart';
import '../../../core/themes/app_colors.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UColors.colorPrimary,
      body: Column(
        children: [
          SafeArea(
            child: customHeaderRow,
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: UColors.screenBackground,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(sizes.scaffoldTopRadius),
                  topRight: Radius.circular(sizes.scaffoldTopRadius),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildGreeting(),
                      const SizedBox(height: sizes.md),
                      _buildCombinedFinancialCard(),
                      // const SizedBox(height: sizes.md),
                      // _buildThisMonthCard(),
                      const SizedBox(height: sizes.md),
                      _buildForecastCard(),
                      const SizedBox(height: sizes.md),
                      _buildTopActionsCard(),
                      const SizedBox(height: sizes.lg), // Bottom padding
                    ],
                  ),
                ),
              ),
            ),
          )
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
                        fontSize: sizes.xl, // 32.0 (using xl as it matches 32.0)
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
                        borderRadius: BorderRadius.circular(sizes.buttonRadius), // 20.0
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.arrow_drop_up, color: Colors.white, size: sizes.iconSm),
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
                    const Icon(Icons.trending_up, color: Colors.white70, size: sizes.iconSm),
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

  Widget _cashDetails(){
    return   Container(
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
          style: const TextStyle(color: Colors.grey, fontSize: sizes.fontSizeSm),
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



  Widget _buildForecastCard() {
    return Container(
      decoration: _cardDecoration(), // Assuming this uses sizes.cardRadiusLg
      padding: const EdgeInsets.all(sizes.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Text(
                    'Next 90 Days Forecast',
                    style: TextStyle(
                        color: Color(0xFF1A2B4C),
                        fontSize: sizes.fontSizeMd,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: sizes.xs),
                  Icon(Icons.chevron_right, size: sizes.iconSm, color: Color(0xFF1A2B4C)),
                ],
              ),
              Icon(Icons.keyboard_arrow_down,
                  color: Colors.grey.shade400,
                  size: sizes.iconMd),
            ],
          ),
          const SizedBox(height: sizes.defaultSpace),
          SizedBox(
            height: 200,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Y-Axis Labels
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: ['4.0M', '3.0M', '2.0M', '1.0M', '0.0M']
                      .map((label) => Text(
                    label,
                    style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: sizes.fontSizeSm - 2 // Adjusting for small axis text
                    ),
                  ))
                      .toList(),
                ),
                const SizedBox(width: sizes.sm),
                // Chart Area
                Expanded(
                  child: Stack(
                    children: [
                      // Horizontal Grid Lines
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          5,
                              (index) => Container(height: 1, color: Colors.grey.shade200),
                        ),
                      ),
                      // Bars and Month Labels
                      Padding(
                        padding: const EdgeInsets.only(top: sizes.sm),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            _buildMonthBarGroup('April', 130, 80, 40),
                            _buildMonthBarGroup('May', 160, 95, 55),
                            _buildMonthBarGroup('June', 125, 80, 45),
                          ],
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

  Widget _buildMonthBarGroup(String month, double h1, double h2, double h3) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _gradientBar(h1, [const Color(0xFF429B4A), const Color(0xFF2E7D32)]),
            _gradientBar(h2, [const Color(0xFF33A3D3), const Color(0xFF1E88E5)]),
            _gradientBar(h3, [const Color(0xFF889AD3), const Color(0xFF5C6BC0)]),
          ],
        ),
        const SizedBox(height: sizes.sm),
        Text(
          month,
          style: const TextStyle(
              color: Color(0xFF4A5568),
              fontSize: sizes.fontSizeSm
          ),
        ),
      ],
    );
  }

  Widget _gradientBar(double height, List<Color> colors) {
    return Container(
      width: sizes.xl, // Using Extra Large for the bar width (32.0)
      height: height,
      margin: const EdgeInsets.symmetric(horizontal: 1),
      decoration: BoxDecoration(
        // Match image with a slight radius if preferred, or keep sharp
        borderRadius: const BorderRadius.vertical(top: Radius.circular(2)),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: colors,
        ),
      ),
    );
  }
  Widget _buildTopActionsCard() {
    return Container(
      decoration: _cardDecoration(),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Top Actions >',
            style: TextStyle(
                color: UColors.colorPrimary,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _buildActionItem('Reduce Open Days', isLast: false),
          _buildActionItem('Adjust Feed Mix', isLast: false),
          _buildActionItem('Schedule Vaccination', isLast: true),
        ],
      ),
    );
  }

  Widget _buildActionItem(String title, {required bool isLast}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            children: [
              const Icon(Icons.check_circle,
                  color: Color(0xFF429B4A), size: 28),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                      color: UColors.textDark,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
        if (!isLast) const Divider(color: Color(0xFFE2E8F0), thickness: 1),
      ],
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.04),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }
}


// PreferredSizeWidget _buildAppBar() {
//   return AppBar(
//     backgroundColor: primaryDarkGreen,
//     elevation: 0,
//     leading: IconButton(
//       icon: const Icon(Icons.menu, color: Colors.white, size: 28),
//       onPressed: () {},
//     ),
//     title: Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         const Text(
//           'Farm ka ',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 20,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         Stack(
//           clipBehavior: Clip.none,
//           children: [
//             const Text(
//               'CFO',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Positioned(
//               top: -8,
//               left: -8,
//               child: Icon(
//                 Icons.eco_outlined,
//                 color: primaryGreen.withOpacity(0.8),
//                 size: 16,
//               ),
//             )
//           ],
//         ),
//       ],
//     ),
//     actions: [
//       const CircleAvatar(
//         radius: 16,
//         backgroundColor: Colors.white24,
//         child: Icon(Icons.person, color: Colors.white, size: 20),
//       ),
//       IconButton(
//         icon: const Icon(Icons.menu, color: Colors.white, size: 28),
//         onPressed: () {},
//       ),
//       const SizedBox(width: 8),
//     ],
//   );
// }


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
          child: Icon(Icons.person, color: Colors.white, size: sizes.circularImageIcon),
        ),
      ),

    ],
  ),
);

