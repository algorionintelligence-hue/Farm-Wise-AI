import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import '../constants/sizes.dart';
import 'app_colors.dart';


class PlantaScaffold extends StatelessWidget {
  final Widget child;
  const PlantaScaffold({super.key, required this.child, required bool showBackButton});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UColors.plantaGreen,
      body: Column(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const BackButton(color: Colors.white),
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
                  topLeft: Radius.circular(USizes.scaffoldTopRadius),
                  topRight: Radius.circular(USizes.scaffoldTopRadius),
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