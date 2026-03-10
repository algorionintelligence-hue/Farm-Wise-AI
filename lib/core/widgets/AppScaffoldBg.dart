import 'package:flutter/material.dart';

import '../themes/app_colors.dart';
import '../utils/sizes.dart';
import 'CustomHeaderRowDashboard.dart';
import '../../features/SideDrawer/View/SideDrawer.dart';

class AppScaffoldBg extends StatelessWidget {
  final Widget child;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  AppScaffoldBg({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const SideDrawer(),
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
