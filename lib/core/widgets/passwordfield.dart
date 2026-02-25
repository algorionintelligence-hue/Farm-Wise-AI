import 'package:farm_wise_ai/core/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/sizes.dart';
import '../providers/auth_providers.dart';
import '../themes/app_colors.dart';

class PlantaPasswordField extends ConsumerWidget {
  const PlantaPasswordField({
    super.key,
    this.labelText = 'Choose your password',
    this.hintText = 'Min 6 characters',
    this.controller,
    this.validator,
  });

  final String labelText;
  final String hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isVisible = ref.watch(passwordVisibilityProvider);

    return PlantaTextField(
      labelText: labelText,
      hintText: hintText,
      controller: controller,
      obscureText: !isVisible,
      validator: validator,
      suffixIcon: IconButton(
        icon: Icon(
          isVisible
              ? Icons.visibility_outlined
              : Icons.visibility_off_outlined,
          size: Size.iconSm,
          color: UColors.colorPrimary,
        ),
        onPressed: () {
          ref.read(passwordVisibilityProvider.notifier).state = !isVisible;
        },
      ),
    );
  }
}
