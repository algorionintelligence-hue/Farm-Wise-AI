import 'package:farm_wise_ai/core/widgets/CustomHeaderRowDashboard.dart';
import 'package:farm_wise_ai/features/SideDrawer/View/SideDrawer.dart';
import 'package:flutter/material.dart';

import '../Utils/sizes.dart';
import '../themes/app_colors.dart';

class AppScaffoldBg extends StatelessWidget {
  Widget child;

  AppScaffoldBg({super.key, required this.child});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: SideDrawer(),
      backgroundColor: UColors.colorPrimary,
      body: Column(
        children: [
          SafeArea(
            child: CustomHeaderRowDashboard(scaffoldKey: _scaffoldKey),
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
