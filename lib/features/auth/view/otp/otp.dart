import 'package:farm_wise_ai/features/auth/view/otp/widgets/otp_btn.dart';
import 'package:farm_wise_ai/features/auth/view/otp/widgets/otp_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/providers/auth_providers.dart';
import '../../../../core/themes/app_colors.dart';
import '../../model/otp_model.dart';

class OtpScreen extends ConsumerStatefulWidget {
  final String email;

  const OtpScreen({super.key, required this.email});

  @override
  ConsumerState<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  // 6 boxes ke liye 6 controllers aur 6 focus nodes
  final List<TextEditingController> _controllers =
  List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  @override
  void initState() {
    super.initState();
    // Har focus node change par screen rebuild karo (border color update ke liye)
    for (final node in _focusNodes) {
      node.addListener(() => setState(() {}));
    }
  }

  @override
  void dispose() {
    // Memory leak rokne ke liye dispose karo
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  // Jab koi box mein digit type ho
  void _onDigitEntered(int index, String value) {
    if (value.isNotEmpty && index < 5) {
      // Agla box focus karo
      _focusNodes[index + 1].requestFocus();
    }

    // Saare boxes ka OTP combine karo aur ViewModel ko do
    final fullOtp = _controllers.map((c) => c.text).join();
    ref.read(otpProvider.notifier).onOtpChanged(fullOtp);
  }

  // Backspace dabane par pichla box focus karo
  void _onKeyEvent(int index, RawKeyEvent event) {
    if (event is RawKeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace &&
        _controllers[index].text.isEmpty &&
        index > 0) {
      _focusNodes[index - 1].requestFocus();
      _controllers[index - 1].clear();
      final fullOtp = _controllers.map((c) => c.text).join();
      ref.read(otpProvider.notifier).onOtpChanged(fullOtp);
    }
  }

  // Success dialog dikhao
  void _showSuccessDialog() {
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
              text: 'Continue',
              onPressed: () {
                Navigator.pop(context);
                // Yahan next screen pe navigate karo
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Riverpod se current state lo
    final otpState = ref.watch(otpProvider);

    // Jab success ho jaye, dialog dikhao
    ref.listen<OtpModel>(otpProvider, (prev, next) {
      if (next.isSuccess && !(prev?.isSuccess ?? false)) {
        _showSuccessDialog();
      }
    });

    return Scaffold(
      backgroundColor: UColors.white,
      appBar: AppBar(
        backgroundColor: UColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: UColors.primary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // Lottie
              Center(
                child: Container(

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Lottie.asset(
                      'lib/core/assets/animations/otp.json',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // Heading
              const Text(
                'Verify Your Email',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: UColors.primary,
                ),
              ),

              const SizedBox(height: 10),

              // Sub-heading — email show karo
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
                      text: widget.email,
                      style: const TextStyle(
                        color: UColors.colorPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const TextSpan(text: '. Enter it below to continue.'),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // ---- OTP Boxes ----
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (index) {
                  return RawKeyboardListener(
                    focusNode: FocusNode(), // Sirf key events ke liye
                    onKey: (event) => _onKeyEvent(index, event),
                    child: OtpInputBox(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      hasError: otpState.errorMessage != null,
                    ),
                  );
                }),
              ),

              // Error message
              if (otpState.errorMessage != null) ...[
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.error_outline,
                        color: UColors.error, size: 16),
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

              const SizedBox(height: 32),

              // Verify Button
              PrimaryButton(
                text: 'Verify',
                isLoading: otpState.isLoading,
                onPressed: () {
                  // OTP boxes ka text manually attach karo (onChange ke saath)
                  final fullOtp = _controllers.map((c) => c.text).join();
                  ref.read(otpProvider.notifier).onOtpChanged(fullOtp);
                  ref.read(otpProvider.notifier).verifyOtp();
                },
              ),

              const SizedBox(height: 28),

              // Resend OTP
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
                    GestureDetector(
                      onTap: otpState.isLoading
                          ? null
                          : () {
                        // Boxes clear karo
                        for (final c in _controllers) {
                          c.clear();
                        }
                        ref.read(otpProvider.notifier).resendOtp();
                      },
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

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
