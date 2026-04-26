import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/JwtTokenService.dart';
import '../../../core/providers/auth_providers.dart';
import '../model/LoginModel.dart';
import '../model/SignupModel.dart';
import '../model/ForgotPasswordModel.dart';
import '../model/ResetPasswordModel.dart';
import '../model/ChangePasswordModel.dart';
import '../model/LogoutModel.dart';

class AuthViewModel {
  final Ref ref;
  AuthViewModel(this.ref);

  // ── Login ──
  Future<bool> login(String email, String password) async {
    if (ref.read(loginLoadingProvider)) {
      return false;
    }

    try {
      ref.read(loginLoadingProvider.notifier).state = true;
      final repository = ref.read(authRepositoryProvider);
      final response = await repository.login(
        LoginModel(email: email, password: password),
      );

      if (!response.success || response.accessToken == null) {
        return false;
      }

      await JwtTokenService.persistSession(
        accessToken: response.accessToken!,
        refreshToken: response.refreshToken,
      );
      print('JWT Token: ${response.accessToken}');
      if (response.refreshToken != null) {
        print('Refresh Token: ${response.refreshToken}');
      }
      return true;
    } catch (e) {
      return false;
    } finally {
      ref.read(loginLoadingProvider.notifier).state = false;
    }
  }

  // ── SignUp ──
  Future<SignupResponse> signUp({
    required String fName,
    required String lName,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      ref.read(signupLoadingProvider.notifier).state = true;
      final repository = ref.read(authRepositoryProvider);
      final response = await repository.signUp(SignupModel(
        firstName: fName,
        lastName: lName,
        email: email,
        phoneNumber: phone,
        password: password,
        agreeToTerms: true,
      ));
      print(
        response.success
            ? 'Signup success: ${response.message}'
            : 'Signup failed: ${response.message}',
      );
      return response;
    } catch (e) {
      print('Signup error: $e');
      return const SignupResponse(
        success: false,
        message: 'Signup failed. Please try again.',
      );
    } finally {
      ref.read(signupLoadingProvider.notifier).state = false;
    }
  }

  // ── Forgot Password ──
  Future<ForgotPasswordResponse> forgotPassword(String email) async {
    try {
      ref.read(forgotPasswordLoadingProvider.notifier).state = true;
      final repository = ref.read(authRepositoryProvider);
      return await repository.forgotPassword(ForgotPasswordModel(email: email));
    } catch (_) {
      rethrow;
    } finally {
      ref.read(forgotPasswordLoadingProvider.notifier).state = false;
    }
  }

  // ── Reset Password ──
  Future<bool> resetPassword({
    required String userId,
    required String token,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      ref.read(resetPasswordLoadingProvider.notifier).state = true;
      final repository = ref.read(authRepositoryProvider);
      await repository.resetPassword(ResetPasswordModel(
        userId: userId,
        token: token,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      ));
      return true;
    } catch (_) {
      rethrow;
    } finally {
      ref.read(resetPasswordLoadingProvider.notifier).state = false;
    }
  }

  // ── Change Password ──
  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      final repository = ref.read(authRepositoryProvider);
      await repository.changePassword(ChangePasswordModel(
        currentPassword: currentPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      ));
      return true;
    } catch (_) {
      rethrow;
    }
  }

  // ── Logout ──
  Future<bool> logout() async {
    try {
      final refreshToken = JwtTokenService.getRefreshToken();
      final repository = ref.read(authRepositoryProvider);
      if (refreshToken != null && refreshToken.trim().isNotEmpty) {
        await repository.logout(LogoutModel(refreshToken: refreshToken));
      }
      await JwtTokenService.clearSession();
      return true;
    } catch (_) {
      await JwtTokenService.clearSession();
      return false;
    }
  }
}
