import 'package:farm_wise_ai/features/Auth/view/Otp/widgets/OtpInputBox.dart';
import 'package:flutter/foundation.dart';
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
import '../ResetPasswordScreen.dart';

enum OtpFlow { signup, passwordReset }

class OtpScreen extends ConsumerStatefulWidget {
  const OtpScreen({
    super.key,
    required this.email,
    this.flow = OtpFlow.signup,
    this.initialUserId,
    this.initialToken,
  });

  final String email;
  final OtpFlow flow;
  final String? initialUserId;
  final String? initialToken;

  @override
  ConsumerState<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      ref.read(otpProvider.notifier).resetState();
    });
  }

  void _showSignupSuccessDialog(BuildContext context) {
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

  Future<void> _handleVerify() async {
    final vm = ref.read(otpProvider.notifier);
    final fullOtp = vm.controllers.map((controller) => controller.text).join();
    vm.onOtpChanged(fullOtp);
    final isPasswordResetFlow = widget.flow == OtpFlow.passwordReset;

    final response = await vm.verifyOtp(
      email: widget.email,
      isPasswordResetFlow: isPasswordResetFlow,
    );
    if (!mounted || !response.success) {
      return;
    }

    if (!isPasswordResetFlow) {
      _showSignupSuccessDialog(context);
      return;
    }

    final resolvedUserId =
        (response.userId ?? widget.initialUserId ?? '').trim();
    final resolvedToken =
        (response.token ?? widget.initialToken ?? fullOtp).trim();

    if (kDebugMode) {
      print('RESET USER ID: $resolvedUserId');
      print('RESET TOKEN: $resolvedToken');
    }

    if (resolvedUserId.isEmpty || resolvedToken.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'OTP verified, but UserId is missing from the server response. Please check the forgot-password and VerifyOTP response logs.',
          ),
        ),
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ResetPasswordScreen(
          initialUserId: resolvedUserId,
          initialToken: resolvedToken,
          initialEmail: widget.email,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final otpState = ref.watch(otpProvider);
    final vm = ref.read(otpProvider.notifier);
    final isPasswordResetFlow = widget.flow == OtpFlow.passwordReset;

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
            Text(
              isPasswordResetFlow ? 'Verify OTP' : 'Verify Your Email',
              style: const TextStyle(
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
                  TextSpan(
                    text: isPasswordResetFlow
                        ? 'We sent a 6-digit reset code to '
                        : 'We sent a 6-digit code to ',
                  ),
                  TextSpan(
                    text: widget.email,
                    style: const TextStyle(
                      color: UColors.colorPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text: isPasswordResetFlow
                        ? '. Enter it below to continue resetting your password.'
                        : '. Enter it below to continue.',
                  ),
                ],
              ),
            ),
            const VSpace(sizes.spaceBtwSections),
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
                    onChanged: (value) => vm.onDigitEntered(index, value),
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
                  Expanded(
                    child: Text(
                      otpState.errorMessage!,
                      style: const TextStyle(
                        color: UColors.error,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ],
            const VSpace(sizes.spaceBtwSections),
            PrimaryButton(
              label: isPasswordResetFlow ? 'Continue' : 'Verify',
              isLoading: otpState.isLoading,
              onPressed: _handleVerify,
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
                              : () => vm.resendOtp(
                                    email: widget.email,
                                    isPasswordResetFlow: isPasswordResetFlow,
                                  ),
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
