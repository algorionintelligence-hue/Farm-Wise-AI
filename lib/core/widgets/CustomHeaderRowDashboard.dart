import 'package:flutter/material.dart';

import '../Utils/sizes.dart';
import '../themes/app_colors.dart';

class CustomHeaderRowDashboard extends StatelessWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey; // Add this
  const CustomHeaderRowDashboard({super.key, this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: UColors.colorPrimary,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: sizes.md),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white, size: 28),
            onPressed: () {
              scaffoldKey?.currentState?.openDrawer();
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

  }
}
