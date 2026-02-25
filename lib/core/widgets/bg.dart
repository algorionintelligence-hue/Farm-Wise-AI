import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import '../constants/sizes.dart';
import '../themes/app_colors.dart';


class PlantaScaffold extends StatelessWidget {
  final Widget child;
  const PlantaScaffold({super.key, required this.child, required bool showBackButton});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UColors.colorPrimary,
      body: Column(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const BackButton(color: Colors.white),
                  SizedBox(
                    height: 50,
                    child: Image.asset(
                      'lib/core/assets/images/logo_without_bg.png', // your logo path
                      fit: BoxFit.contain,
                    ),
                  ),
                  // PlantaLogo(),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: UColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Size.scaffoldTopRadius),
                  topRight: Radius.circular(Size.scaffoldTopRadius),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: child,
              ),
            ),
          )
        ],
      ),
    );
  }
}