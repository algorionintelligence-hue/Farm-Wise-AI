
import 'package:farm_wise_ai/features/Auth/view/Otp/widgets/OtpInputBox.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/providers/auth_providers.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/utils/sizes.dart';
import '../../../../core/widgets/AppScaffoldBgBasic.dart';
import '../../../../core/widgets/PrimaryButton.dart';
import '../../../FarmRegistration/view/FarmRegistrationScreen.dart';
import '../../model/OtpModel.dart';

class OtpScreen extends ConsumerWidget {
  const OtpScreen({super.key, required this.email});

  final String email;

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.check_circle,
              color: UColors.plantaGreen,
              size: 64,
            ),
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
              'Your account has been successfully verified. Continue to farm registration.',
              textAlign: TextAlign.center,
              style: TextStyle(color: UColors.textSecondary),
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              label: 'Continue',
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => FarmRegistrationScreen()),
                  (route) => false,
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
            Center(
              child: Lottie.asset(
                'lib/core/assets/animations/otp.json',
                height: 200,
                fit: BoxFit.contain,
              ),
            ),
            const VSpace(sizes.defaultSpace),
            const Text(
              'Verify Your Email',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: UColors.colorPrimary,
              ),
            ),
            const VSpace(sizes.sm),
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
            if (otpState.errorMessage != null) ...[
              const VSpace(sizes.sm),
              Row(
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: UColors.error,
                    size: 16,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    otpState.errorMessage!,
                    style: const TextStyle(
                      color: UColors.error,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ],
            const VSpace(sizes.spaceBtwSections),
            PrimaryButton(
              label: 'Verify',
              isLoading: otpState.isLoading,
              onPressed: () {
                final fullOtp = vm.controllers.map((c) => c.text).join();
                vm.onOtpChanged(fullOtp);
                vm.verifyOtp(email);
              },
            ),
            const VSpace(sizes.spaceBtwSections),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Didn't receive the code? ",
                    style: TextStyle(
                      color: UColors.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                  otpState.resendCountdown > 0
                      ? Text(
                          'Resend in ${otpState.resendCountdown}s',
                          style: const TextStyle(
                            color: UColors.textSecondary,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      : GestureDetector(
                          onTap: otpState.isLoading
                              ? null
                              : () => vm.resendOtp(email),
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
