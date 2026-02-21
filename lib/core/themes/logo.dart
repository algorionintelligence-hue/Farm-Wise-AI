import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/sizes.dart';
import '../constants/texts.dart';
import 'app_colors.dart';

class PlantaLogo extends StatelessWidget {
  const PlantaLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Replace with: Image.asset('assets/icons/leaf.png', height: 22)
        const Icon(
          Icons.eco_rounded,
          color: UColors.white,
          size: USizes.logoIconSize,
        ),
        const SizedBox(width: USizes.xs),
        Text(
          UTexts.appName,
          style: const TextStyle(
            fontSize: USizes.fontSizeLg,
            fontWeight: FontWeight.w700,
            color: UColors.white,
            fontStyle: FontStyle.italic,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}


