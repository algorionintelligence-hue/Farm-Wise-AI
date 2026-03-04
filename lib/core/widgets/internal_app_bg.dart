import 'package:farm_wise_ai/core/widgets/custom_header_row_dashboard.dart';
import 'package:flutter/material.dart';

import '../constants/sizes.dart';
import '../themes/app_colors.dart';

class InternalAppBg extends StatelessWidget {
  Widget child;

  InternalAppBg({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UColors.colorPrimary,
      body: Column(
        children: [
          SafeArea(
            child: CustomHeaderRowDashboard(),
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
                  child: child,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
