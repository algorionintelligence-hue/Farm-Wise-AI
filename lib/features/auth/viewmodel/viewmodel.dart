// lib/features/auth/viewmodel/viewmodel.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/auth_providers.dart';

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
}
