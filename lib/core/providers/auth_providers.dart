import 'package:flutter_riverpod/flutter_riverpod.dart';

final passwordVisibilityProvider = StateProvider<bool>((ref) => false);
final loginLoadingProvider = StateProvider<bool>((ref) => false);
final signupLoadingProvider = StateProvider<bool>((ref) => false);