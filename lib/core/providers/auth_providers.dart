// lib/providers/auth_providers.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/model/otp_model.dart';
import '../../features/auth/repository/auth_repository.dart';
import '../../features/auth/viewmodel/otp_viewmodel.dart';
import '../../features/auth/viewmodel/viewmodel.dart';


// Repository Provider
final authRepositoryProvider = Provider((ref) => AuthRepository());

// ViewModel Provider
final authViewModelProvider = Provider((ref) => AuthViewModel(ref));
final otpProvider = StateNotifierProvider<OtpViewModel, OtpModel>(
      (ref) => OtpViewModel(),
);

// State Providers for UI
final loginLoadingProvider = StateProvider<bool>((ref) => false);
final signupLoadingProvider = StateProvider<bool>((ref) => false);
final passwordVisibilityProvider = StateProvider<bool>((ref) => false);