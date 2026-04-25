import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';

import '../../../core/providers/auth_providers.dart';
import '../model/OtpModel.dart';

class OtpViewModel extends StateNotifier<OtpModel> {
  OtpViewModel(this.ref) : super(const OtpModel()) {
    _startCountdown();
  }

  final Ref ref;

  final List<TextEditingController> controllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());

  Timer? _timer;

  // ── Countdown ──
  void _startCountdown() {
    _timer?.cancel();
    state = state.copyWith(resendCountdown: 60);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.resendCountdown <= 0) {
        timer.cancel();
      } else {
        state = state.copyWith(resendCountdown: state.resendCountdown - 1);
      }
    });
  }

  void onDigitEntered(int index, String value) {
    if (value.isNotEmpty && index < 5) {
      focusNodes[index + 1].requestFocus();
    }
    final fullOtp = controllers.map((c) => c.text).join();
    onOtpChanged(fullOtp);
  }

  void onBackspace(int index) {
    if (controllers[index].text.isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
      controllers[index - 1].clear();
      final fullOtp = controllers.map((c) => c.text).join();
      onOtpChanged(fullOtp);
    }
  }

  void onOtpChanged(String value) {
    state = state.copyWith(otp: value, errorMessage: null);
  }

  void clearBoxes() {
    for (final c in controllers) c.clear();
  }

  // ── Verify OTP (Real API) ──
  Future<bool> verifyOtp(String email) async {
    if (state.otp.length < 6) {
      state = state.copyWith(errorMessage: 'Please enter complete 6-digit OTP');
      return false;
    }

    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final repository = ref.read(authRepositoryProvider);
      final success = await repository.verifyOtp(
        email: email,
        otpCode: state.otp,
      );
      state = state.copyWith(isLoading: false, isSuccess: success);
      return success;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Invalid OTP. Please try again.',
      );
      return false;
    }
  }

  // ── Resend OTP (Real API) ──
  Future<void> resendOtp(String email) async {
    clearBoxes();
    state = state.copyWith(isLoading: true, errorMessage: null, otp: '');

    try {
      final repository = ref.read(authRepositoryProvider);
      await repository.resendOtp(email);
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to resend OTP. Please try again.',
      );
    }

    _startCountdown();
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final c in controllers) c.dispose();
    for (final f in focusNodes) f.dispose();
    super.dispose();
  }
}
