import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/OtpModel.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/OtpModel.dart';

import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/OtpModel.dart';

class OtpViewModel extends StateNotifier<OtpModel> {
  OtpViewModel() : super(const OtpModel()) {
    _startCountdown(); // start countdown on screen open
  }

  final List<TextEditingController> controllers =
  List.generate(6, (_) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());

  Timer? _timer;

  // ── Countdown ──
  void _startCountdown() {
    _timer?.cancel();
    state = state.copyWith(resendCountdown: 10); // 10 sec
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

  Future<void> verifyOtp() async {
    if (state.otp.length < 6) {
      state = state.copyWith(errorMessage: 'Please enter complete 6-digit OTP');
      return;
    }
    state = state.copyWith(isLoading: true, errorMessage: null);
    await Future.delayed(const Duration(seconds: 2));

    if (state.otp == '123456') {
      state = state.copyWith(isLoading: false, isSuccess: true);
    } else {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Invalid OTP. Please try again.',
      );
    }
  }

  Future<void> resendOtp() async {
    clearBoxes();
    state = state.copyWith(isLoading: true, errorMessage: null, otp: '');
    await Future.delayed(const Duration(seconds: 1));
    state = state.copyWith(isLoading: false);
    _startCountdown(); // ✅ restart countdown after resend
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final c in controllers) c.dispose();
    for (final f in focusNodes) f.dispose();
    super.dispose();
  }
}