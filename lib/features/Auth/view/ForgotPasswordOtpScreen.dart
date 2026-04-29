import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../../../core/providers/auth_providers.dart';
import '../../../core/themes/app_colors.dart';
import '../../../core/utils/sizes.dart';
import '../../../core/widgets/AppScaffoldBgBasic.dart';
import '../../../core/widgets/PrimaryButton.dart';
import '../model/OtpModel.dart';
import 'Otp/widgets/OtpInputBox.dart';
import 'ResetPasswordScreen.dart';

class ForgotPasswordOtpScreen extends ConsumerWidget {
  const ForgotPasswordOtpScreen({
    super.key,
    required this.email,
    this.userId,
  });

  final String email;
  final String? userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final otpState = ref.watch(forgotPasswordOtpProvider);
    final vm = ref.read(forgotPasswordOtpProvider.notifier);

    ref.listen<OtpModel>(forgotPasswordOtpProvider, (prev, next) {
      if (next.isSuccess && !(prev?.isSuccess ?? false)) {
        final otp = vm.controllers.map((c) => c.text).join();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => ResetPasswordScreen(
              initialUserId: next.verifiedUserId ?? userId ?? '',
              initialToken: next.verifiedToken ?? otp,
              initialEmail: email,
            ),
          ),
          (route) => route.isFirst,
        );
      }
    });

    return AppScaffoldBgBasic(
      showBackButton: true,
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
              'Check Your Email',
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
                  const TextSpan(text: '. Enter it below to reset your password.'),
                ],
              ),
            ),
            const VSpace(sizes.spaceBtwSections),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(6, (index) {
                return KeyboardListener(
                  focusNode: FocusNode(),
                  onKeyEvent: (event) {
                    if (event is KeyDownEvent &&
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
            PrimaryButton(
              label: 'Verify OTP',
              isLoading: otpState.isLoading,
              onPressed: () {
                final fullOtp = vm.controllers.map((c) => c.text).join();
                vm.onOtpChanged(fullOtp);
                vm.verifyOtp(email: email, isPasswordResetFlow: true);
              },
            ),
            const VSpace(sizes.spaceBtwSections),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Didn't receive the code? ",
                    style: TextStyle(color: UColors.textSecondary, fontSize: 14),
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
                              : () => vm.resendOtp(email: email, isPasswordResetFlow: true),
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
