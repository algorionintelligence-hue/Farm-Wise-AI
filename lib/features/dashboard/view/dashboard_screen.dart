import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  // Theme Colors
  static const Color primaryDarkGreen = Color(0xFF1B4E31);
  static const Color primaryGreen = Color(0xFF3C9C50);
  static const Color textDark = Color(0xFF2E384D);
  static const Color textLight = Color(0xFF8798AD);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildGreeting(),
              const SizedBox(height: 16),
              _buildCashRunwayCard(),
              const SizedBox(height: 16),
              _buildThisMonthCard(),
              const SizedBox(height: 16),
              _buildForecastCard(),
              const SizedBox(height: 16),
              _buildTopActionsCard(),
              const SizedBox(height: 20), // Bottom padding
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: primaryDarkGreen,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Colors.white, size: 28),
        onPressed: () {},
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Farm ka ',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              const Text(
                'CFO',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Positioned(
                top: -8,
                left: -8,
                child: Icon(
                  Icons.eco_outlined,
                  color: primaryGreen.withOpacity(0.8),
                  size: 16,
                ),
              )
            ],
          ),
        ],
      ),
      actions: [
        const CircleAvatar(
          radius: 16,
          backgroundColor: Colors.white24,
          child: Icon(Icons.person, color: Colors.white, size: 20),
        ),
        IconButton(
          icon: const Icon(Icons.menu, color: Colors.white, size: 28),
          onPressed: () {},
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildGreeting() {
    return RichText(
      text: const TextSpan(
        style: TextStyle(color: textDark, fontSize: 18),
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

  Widget _buildCashRunwayCard() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF459A4D), Color(0xFF388540)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: const [
                  Text(
                    'PKR ',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '320,000',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              const Text(
                'Cash Runway',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: const [
                  Text(
                    '47 ',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Days',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Container(
                width: 65,
                height: 2,
                color: Colors.white.withOpacity(0.8),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildThisMonthCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'This Month:',
            style: TextStyle(
                color: textDark, fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSummaryMetric('Revenue', '680,000', textDark),
                const VerticalDivider(color: Colors.grey, thickness: 0.5),
                _buildSummaryMetric('Cost', '560,000', textDark),
                const VerticalDivider(color: Colors.grey, thickness: 0.5),
                _buildSummaryMetric('Profit', '120,000', primaryDarkGreen),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSummaryMetric(String label, String value, Color valueColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
              color: textLight, fontSize: 13, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              'PKR ',
              style: TextStyle(
                  color: valueColor, fontSize: 11, fontWeight: FontWeight.w600),
            ),
            Text(
              value,
              style: TextStyle(
                  color: valueColor, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildForecastCard() {
    return Container(
      decoration: _cardDecoration(),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Next 90 Days Forecast >',
                style: TextStyle(
                    color: primaryDarkGreen,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              Icon(Icons.keyboard_arrow_down, color: textDark.withOpacity(0.6)),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 180,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Y-Axis Labels
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Text('3.0M', style: TextStyle(color: textLight, fontSize: 12)),
                    Text('2.0M', style: TextStyle(color: textLight, fontSize: 12)),
                    Text('1.0M', style: TextStyle(color: textLight, fontSize: 12)),
                    Text('0.0M', style: TextStyle(color: textLight, fontSize: 12)),
                  ],
                ),
                const SizedBox(width: 8),
                // Chart Area
                Expanded(
                  child: Stack(
                    children: [
                      // Horizontal Grid Lines
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                            4,
                                (index) => const Divider(
                                color: Color(0xFFE2E8F0), thickness: 1)),
                      ),
                      // Bars
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _buildMonthBarGroup(
                              'April', 140, 80, 40), // Heights mapped visually
                          _buildMonthBarGroup('May', 170, 95, 55),
                          _buildMonthBarGroup('June', 135, 80, 45),
                        ],
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
            Container(width: 24, height: h1, color: const Color(0xFF429B4A)),
            Container(width: 24, height: h2, color: const Color(0xFF33A3D3)),
            Container(width: 24, height: h3, color: const Color(0xFF889AD3)),
          ],
        ),
        const SizedBox(height: 8),
        Text(month, style: const TextStyle(color: textDark, fontSize: 13)),
      ],
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
                color: primaryDarkGreen,
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
                      color: textDark,
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