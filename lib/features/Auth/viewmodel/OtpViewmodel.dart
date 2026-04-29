import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/auth_providers.dart';
import '../model/ForgotPasswordModel.dart';
import '../model/OtpModel.dart';
import '../model/ResendOtpModel.dart';
import '../model/VerifyOtpModel.dart';

class OtpViewModel extends StateNotifier<OtpModel> {
  OtpViewModel(this.ref) : super(const OtpModel()) {
    _startCountdown();
  }

  final Ref ref;

  final List<TextEditingController> controllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());

  Timer? _timer;

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

  void resetState() {
    _timer?.cancel();
    clearBoxes();
    state = const OtpModel();
    _startCountdown();
    if (focusNodes.isNotEmpty) {
      focusNodes.first.requestFocus();
    }
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
    state = state.copyWith(
      otp: value,
      errorMessage: null,
      isSuccess: false,
      verifiedUserId: null,
      verifiedToken: null,
    );
  }

  void clearBoxes() {
    for (final controller in controllers) {
      controller.clear();
    }
  }

  Future<VerifyOtpResponse> verifyOtp({
    required String email,
    bool isPasswordResetFlow = false,
  }) async {
    if (state.isLoading) {
      return const VerifyOtpResponse(success: false);
    }

    if (state.otp.length < 6) {
      const message = 'Please enter complete 6-digit OTP';
      state = state.copyWith(
        isSuccess: false,
        errorMessage: message,
        verifiedUserId: null,
        verifiedToken: null,
      );
      return const VerifyOtpResponse(success: false, message: message);
    }

    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
      isSuccess: false,
      verifiedUserId: null,
      verifiedToken: null,
    );

    try {
      final repository = ref.read(authRepositoryProvider);
      final request = VerifyOtpModel(email: email, otpCode: state.otp);
      final response = isPasswordResetFlow
          ? await repository.verifyResetOtp(request)
          : await repository.verifyOtp(request);

      if (!response.success) {
        state = state.copyWith(
          isLoading: false,
          isSuccess: false,
          errorMessage: response.message ?? 'Invalid OTP. Please try again.',
          verifiedUserId: null,
          verifiedToken: null,
        );
        return response;
      }

      state = state.copyWith(
        isLoading: false,
        isSuccess: true,
        errorMessage: null,
        verifiedUserId: response.userId,
        verifiedToken: response.token,
      );
      return response;
    } catch (_) {
      const message = 'Invalid OTP. Please try again.';
      state = state.copyWith(
        isLoading: false,
        isSuccess: false,
        errorMessage: message,
        verifiedUserId: null,
        verifiedToken: null,
      );
      return const VerifyOtpResponse(success: false, message: message);
    }
  }

  Future<void> resendOtp({
    required String email,
    bool isPasswordResetFlow = false,
  }) async {
    if (state.isLoading) {
      return;
    }

    clearBoxes();
    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
      otp: '',
      isSuccess: false,
      verifiedUserId: null,
      verifiedToken: null,
    );

    try {
      final repository = ref.read(authRepositoryProvider);
      late final bool isSuccess;
      late final String? message;

      if (isPasswordResetFlow) {
        final response = await repository.forgotPassword(
          ForgotPasswordModel(email: email),
        );
        isSuccess = response.success;
        message = response.message;
      } else {
        final response = await repository.resendOtp(
          ResendOtpModel(email: email),
        );
        isSuccess = response.success;
        message = response.message;
      }

      if (!isSuccess) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: message ?? 'Failed to resend OTP. Please try again.',
        );
        return;
      }

      state = state.copyWith(isLoading: false, errorMessage: null);
      _startCountdown();
      if (focusNodes.isNotEmpty) {
        focusNodes.first.requestFocus();
      }
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to resend OTP. Please try again.',
      );
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final controller in controllers) {
      controller.dispose();
    }
    for (final focusNode in focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }
}
