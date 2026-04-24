// lib/providers/auth_providers.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/ai/model/message_model.dart';
import '../../features/ai/view/ChatNotifier.dart';
import '../../features/auth/model/OtpModel.dart';
import '../../features/auth/repository/auth_repository.dart';
import '../../features/auth/viewmodel/otp_viewmodel.dart';
import '../../features/auth/viewmodel/viewmodel.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository());
final termsAcceptedProvider = StateProvider<bool>((ref) => false);
final herdStepProvider = StateProvider<int>((ref) => 0);

final authViewModelProvider = Provider((ref) => AuthViewModel(ref));
final otpProvider = StateNotifierProvider<OtpViewModel, OtpModel>(
  (ref) => OtpViewModel(ref), // ✅ ref pass kiya — real API calls ke liye
);

final chatProvider = StateNotifierProvider<ChatNotifier, List<ChatMessage>>(
  (ref) => ChatNotifier(ref),
);

final loginLoadingProvider = StateProvider<bool>((ref) => false);
final signupLoadingProvider = StateProvider<bool>((ref) => false);
final forgotPasswordLoadingProvider = StateProvider<bool>((ref) => false);
final resetPasswordLoadingProvider = StateProvider<bool>((ref) => false);
final passwordVisibilityProvider = StateProvider<bool>((ref) => false);
