// lib/providers/auth_providers.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/repository/auth_repository.dart';
import '../../features/auth/viewmodel/viewmodel.dart';


// Repository Provider
final authRepositoryProvider = Provider((ref) => AuthRepository());

// ViewModel Provider
final authViewModelProvider = Provider((ref) => AuthViewModel(ref));

// State Providers for UI
final loginLoadingProvider = StateProvider<bool>((ref) => false);
final signupLoadingProvider = StateProvider<bool>((ref) => false);
final passwordVisibilityProvider = StateProvider<bool>((ref) => false);