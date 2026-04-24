import 'package:dio/dio.dart';

import '../../../core/network/network.dart';
import '../model/forgot_password_result.dart';

class AuthRepository {
  AuthRepository({Dio? dio}) : _dio = dio ?? ApiConfig.createDio();

  final Dio _dio;

  // Login Logic
  Future<bool> login(String email, String password) async {
    // Yahan actual API call hogi (e.g. Firebase ya Node.js)
    await Future.delayed(const Duration(seconds: 2)); // Simulating network
    return true; // Agar success ho
  }

  // SignUp Logic
  Future<bool> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }

  Future<ForgotPasswordResult> forgotPassword(String email) async {
    if (ApiConfig.baseUrl.isEmpty) {
      await Future.delayed(const Duration(seconds: 1));
      return ForgotPasswordResult(
        message: 'Reset request created. Enter userId and token to continue.',
      );
    }

    final response = await _dio.post(
      '/api/UserAuth/forgot-password',
      data: {'email': email},
    );

    return ForgotPasswordResult.fromResponse(response.data);
  }

  Future<bool> resetPassword({
    required String userId,
    required String token,
    required String newPassword,
    required String confirmPassword,
  }) async {
    if (ApiConfig.baseUrl.isEmpty) {
      await Future.delayed(const Duration(seconds: 1));
      return true;
    }

    await _dio.post(
      '/api/UserAuth/reset-password',
      data: {
        'userId': userId,
        'token': token,
        'newPassword': newPassword,
        'confirmPassword': confirmPassword,
      },
    );

    return true;
  }
}
