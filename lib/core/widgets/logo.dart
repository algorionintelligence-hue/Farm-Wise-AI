import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/sizes.dart';
import '../constants/texts.dart';
import '../themes/app_colors.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Replace with: Image.asset('assets/icons/leaf.png', height: 22)
        const Icon(
          Icons.eco_rounded,
          color: UColors.white,
          size: sizes.logoIconSize,
        ),
        const SizedBox(width: sizes.xs),
        Text(
          UTexts.appName,
          style: const TextStyle(
            fontSize: sizes.fontSizeLg,
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


