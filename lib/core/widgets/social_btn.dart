// ═════════════════════════════════════════════════════════════
// SocialButton — Google / Facebook
// ═════════════════════════════════════════════════════════════
import 'package:flutter/material.dart';

import '../constants/device_helper.dart';
import '../constants/sizes.dart';
import '../themes/app_colors.dart';

class PlantaSocialButton extends StatelessWidget {
  const PlantaSocialButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final Widget icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: UDeviceHelper.getScreenWidth(context),
      height: 50,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: SizedBox(
          width: USizes.iconMd,
          height: USizes.iconMd,
          child: icon,
        ),
        label: Padding(
          padding: const EdgeInsets.only(left: 12), // space between icon and text
          child: Text(
            label,
            style:  TextStyle(
              fontSize: USizes.fontSizeSm,
              fontWeight: FontWeight.w500,
              color: UColors.textPrimary,
            ),
          ),
        ),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: UColors.borderPrimary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(USizes.buttonRadius),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16), // optional internal padding
        ),
      ),
    );
  }}