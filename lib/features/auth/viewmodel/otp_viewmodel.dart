import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/otp_model.dart';

class OtpViewModel extends StateNotifier<OtpModel> {
  OtpViewModel() : super(const OtpModel());

  // Jab user koi digit type kare
  void onOtpChanged(String value) {
    state = state.copyWith(
      otp: value,
      errorMessage: null, // Error clear kar do
    );
  }

  // Verify button dabane par
  Future<void> verifyOtp() async {
    // Validation: 6 digits hone chahiye
    if (state.otp.length < 6) {
      state = state.copyWith(errorMessage: 'Please enter complete 6-digit OTP');
      return;
    }

    // Loading start
    state = state.copyWith(isLoading: true, errorMessage: null);

    // Yahan apna API call lagao — abhi sirf delay simulate kar rahe hain
    await Future.delayed(const Duration(seconds: 2));

    // Demo: "123456" sahi OTP maan lo
    if (state.otp == '123456') {
      state = state.copyWith(isLoading: false, isSuccess: true);
    } else {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Invalid OTP. Please try again.',
      );
    }
  }

  // Resend OTP button
  Future<void> resendOtp() async {
    state = state.copyWith(isLoading: true, errorMessage: null, otp: '');
    await Future.delayed(const Duration(seconds: 1));
    state = state.copyWith(isLoading: false);
    // Yahan resend API call lagao
  }
}