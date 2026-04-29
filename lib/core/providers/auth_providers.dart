
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/Ai/model/ChatMessage.dart';
import '../../features/Ai/view/ChatNotifier.dart';
import '../../features/Auth/model/OtpModel.dart';
import '../../features/Auth/repository/AuthRepository.dart';
import '../../features/Auth/viewmodel/OtpViewmodel.dart';
import '../../features/Auth/viewmodel/ViewModel.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository());
final termsAcceptedProvider = StateProvider<bool>((ref) => false);
final herdStepProvider = StateProvider<int>((ref) => 0);

final authViewModelProvider = Provider((ref) => AuthViewModel(ref));
final otpProvider = StateNotifierProvider<OtpViewModel, OtpModel>(
  (ref) => OtpViewModel(ref), // ✅ ref pass kiya — real API calls ke liye
);

final forgotPasswordOtpProvider = StateNotifierProvider<OtpViewModel, OtpModel>(
  (ref) => OtpViewModel(ref),
);

final chatProvider = StateNotifierProvider<ChatNotifier, List<ChatMessage>>(
  (ref) => ChatNotifier(ref),
);

final loginLoadingProvider = StateProvider<bool>((ref) => false);
final signupLoadingProvider = StateProvider<bool>((ref) => false);
final forgotPasswordLoadingProvider = StateProvider<bool>((ref) => false);
final resetPasswordLoadingProvider = StateProvider<bool>((ref) => false);
final passwordVisibilityProvider = StateProvider<bool>((ref) => false);
