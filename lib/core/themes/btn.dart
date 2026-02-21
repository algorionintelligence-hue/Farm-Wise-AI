import 'package:flutter/material.dart';

import '../constants/device_helper.dart';
import '../constants/sizes.dart';
import 'app_colors.dart';

class PlantaPrimaryButton extends StatelessWidget {
  const PlantaPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: UDeviceHelper.getScreenWidth(context),
      height: USizes.buttonHeight,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: UColors.plantaGreen,
          disabledBackgroundColor: UColors.buttonDisabled,
          foregroundColor: UColors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(USizes.buttonRadius),
          ),
        ),
        child: isLoading
            ? const SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: UColors.white,
          ),
        )
            : Text(
          label,
          style: const TextStyle(
            fontSize: USizes.fontSizeMd,
            fontWeight: FontWeight.w600,
            color: UColors.white,
            letterSpacing: 0.3,
          ),
        ),
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════
// 6. PlantaOrDivider
// ═════════════════════════════════════════════════════════════
class PlantaOrDivider extends StatelessWidget {
  const PlantaOrDivider({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(color: UColors.borderPrimary, thickness: 1),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: USizes.md),
          child: Text(
            text,
            style: TextStyle(
              fontSize: USizes.fontSizeSm,
              color: UColors.textSecondary,
            ),
          ),
        ),
        const Expanded(
          child: Divider(color: UColors.borderPrimary, thickness: 1),
        ),
      ],
    );
  }
}

// ═════════════════════════════════════════════════════════════
// 7. PlantaSocialButton — Google / Facebook
// ═════════════════════════════════════════════════════════════
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
        icon: icon,
        label: Text(
          label,
          style: const TextStyle(
            fontSize: USizes.fontSizeSm,
            fontWeight: FontWeight.w500,
            color: UColors.textPrimary,
          ),
        ),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: UColors.borderPrimary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(USizes.borderRadiusLg),
          ),
        ),
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════
// VSpace / HSpace utilities
// ═════════════════════════════════════════════════════════════
class VSpace extends StatelessWidget {
  const VSpace(this.h, {super.key});
  final double h;
  @override
  Widget build(BuildContext context) => SizedBox(height: h);
}

class HSpace extends StatelessWidget {
  const HSpace(this.w, {super.key});
  final double w;
  @override
  Widget build(BuildContext context) => SizedBox(width: w);
}