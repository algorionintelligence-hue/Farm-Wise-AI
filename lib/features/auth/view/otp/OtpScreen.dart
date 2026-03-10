import 'package:farm_wise_ai/features/auth/view/otp/widgets/otp_btn.dart' hide PrimaryButton;
import 'package:farm_wise_ai/features/auth/view/otp/widgets/otp_input.dart';
import 'package:farm_wise_ai/features/bottom_navigation_bar/view/BottomNavigation.dart';
import 'package:farm_wise_ai/features/farm_registration/view/FarmRegistrationScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/utils/sizes.dart';
import '../../../../core/providers/auth_providers.dart';
import '../../../../core/themes/app_colors.dart';
import '../../model/OtpModel.dart';

import '../../../../core/widgets/AppScaffoldBgBasic.dart';
import '../../../../core/widgets/PrimaryButton.dart';


class OtpScreen extends ConsumerWidget {
  final String email;
  const OtpScreen({super.key, required this.email});

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: UColors.plantaGreen, size: 64),
            const SizedBox(height: 16),
            const Text(
              'Verified!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: UColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Your account has been successfully verified.',
              textAlign: TextAlign.center,
              style: TextStyle(color: UColors.textSecondary),
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              label: 'Continue',
              onPressed: () {
                Navigator.pop(context); // dialog band karo
                // ✅ BottomNavigation screen pe jao — purani history hata do
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>  FarmRegistrationScreen(), // apna class name yahan
                  ),
                      (route) => false, // back press pe login pe wapas na jaye
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final otpState = ref.watch(otpProvider);
    final vm = ref.read(otpProvider.notifier);

    ref.listen<OtpModel>(otpProvider, (prev, next) {
      if (next.isSuccess && !(prev?.isSuccess ?? false)) {
        _showSuccessDialog(context);
      }
    });

    return AppScaffoldBgBasic(
      showBackButton: Navigator.canPop(context),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Animation ──
            Center(
              child: Lottie.asset(
                'lib/core/assets/animations/otp.json',
                height: 200,
                fit: BoxFit.contain,
              ),
            ),
            const VSpace(sizes.defaultSpace),

            // ── Title ──
            const Text(
              'Verify Your Email',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: UColors.colorPrimary,
              ),
            ),
            const VSpace(sizes.sm),

            // ── Subtitle ──
            RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 14,
                  color: UColors.textSecondary,
                  height: 1.5,
                ),
                children: [
                  const TextSpan(text: 'We sent a 6-digit code to '),
                  TextSpan(
                    text: email,
                    style: const TextStyle(
                      color: UColors.colorPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const TextSpan(text: '. Enter it below to continue.'),
                ],
              ),
            ),
            VSpace(sizes.spaceBtwSections),

            // ── OTP Boxes ──
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(6, (index) {
                return RawKeyboardListener(
                  focusNode: FocusNode(),
                  onKey: (event) {
                    if (event is RawKeyDownEvent &&
                        event.logicalKey == LogicalKeyboardKey.backspace) {
                      vm.onBackspace(index);
                    }
                  },
                  child: OtpInputBox(
                    controller: vm.controllers[index],
                    focusNode: vm.focusNodes[index],
                    hasError: otpState.errorMessage != null,
                    onChanged: (val) => vm.onDigitEntered(index, val),
                  ),
                );
              }),
            ),

            // ── Error ──
            if (otpState.errorMessage != null) ...[
              const VSpace(sizes.sm),
              Row(
                children: [
                  const Icon(Icons.error_outline, color: UColors.error, size: 16),
                  const SizedBox(width: 6),
                  Text(
                    otpState.errorMessage!,
                    style: const TextStyle(color: UColors.error, fontSize: 13),
                  ),
                ],
              ),
            ],
            const VSpace(sizes.spaceBtwSections),

            // ── Verify Button ──
            PrimaryButton(
              label: 'Verify',
              isLoading: otpState.isLoading,
              onPressed: () {
                final fullOtp = vm.controllers.map((c) => c.text).join();
                vm.onOtpChanged(fullOtp);
                vm.verifyOtp();
              },
            ),
            const VSpace(sizes.spaceBtwSections),

            // ── Resend ──

            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Didn't receive the code? ",
                    style: TextStyle(color: UColors.textSecondary, fontSize: 14),
                  ),
                  otpState.resendCountdown > 0
                  // ✅ Show countdown — not tappable
                      ? Text(
                    'Resend in ${otpState.resendCountdown}s',
                    style: const TextStyle(
                      color: UColors.textSecondary,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                  // ✅ Show tappable Resend when countdown done
                      : GestureDetector(
                    onTap: otpState.isLoading ? null : vm.resendOtp,
                    child: const Text(
                      'Resend',
                      style: TextStyle(
                        color: UColors.linkColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const VSpace(sizes.defaultSpace),
          ],
        ),
      ),
    );
  }
}

