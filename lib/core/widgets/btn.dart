import 'package:flutter/material.dart';

import '../constants/device_helper.dart';
import '../constants/sizes.dart';
import '../themes/app_colors.dart';

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
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: UColors.colorPrimary,
          disabledBackgroundColor: UColors.buttonDisabled,
          foregroundColor: UColors.white,
          padding: EdgeInsets.symmetric(
            vertical: 13,
          ),
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