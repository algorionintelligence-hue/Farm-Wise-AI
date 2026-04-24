// lib/features/auth/viewmodel/viewmodel.dart

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/auth_providers.dart';
import '../model/forgot_password_result.dart';

class AuthViewModel {

  final Ref ref;
  AuthViewModel(this.ref);

  // Login Function
  Future<bool> login(String email, String password) async {
    try {
      ref.read(loginLoadingProvider.notifier).state = true;

      final repository = ref.read(authRepositoryProvider);
      final success = await repository.login(email, password);

      return success;
    } catch (e) {
      return false;
    } finally {
      ref.read(loginLoadingProvider.notifier).state = false;
    }
  }

  // Signup Function
  Future<bool> signUp({
    required String fName,
    required String lName,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      ref.read(signupLoadingProvider.notifier).state = true;

      final repository = ref.read(authRepositoryProvider);
      final success = await repository.signUp(
        firstName: fName,
        lastName: lName,
        email: email,
        phone: phone,
        password: password,
      );

      return success;
    } catch (e) {
      return false;
    } finally {
      ref.read(signupLoadingProvider.notifier).state = false;
    }
  }

  Future<ForgotPasswordResult?> forgotPassword(String email) async {
    try {
      ref.read(forgotPasswordLoadingProvider.notifier).state = true;

      final repository = ref.read(authRepositoryProvider);
      return await repository.forgotPassword(email);
    } on DioException catch (e) {
      throw Exception(
        e.response?.data is Map && e.response?.data['message'] != null
            ? e.response!.data['message'].toString()
            : 'Unable to request password reset right now.',
      );
    } catch (_) {
      rethrow;
    } finally {
      ref.read(forgotPasswordLoadingProvider.notifier).state = false;
    }
  }

  Future<bool> resetPassword({
    required String userId,
    required String token,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      ref.read(resetPasswordLoadingProvider.notifier).state = true;

      final repository = ref.read(authRepositoryProvider);
      return await repository.resetPassword(
        userId: userId,
        token: token,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );
    } on DioException catch (e) {
      throw Exception(
        e.response?.data is Map && e.response?.data['message'] != null
            ? e.response!.data['message'].toString()
            : 'Unable to reset password right now.',
      );
    } catch (_) {
      rethrow;
    } finally {
      ref.read(resetPasswordLoadingProvider.notifier).state = false;
    }
  }
}
