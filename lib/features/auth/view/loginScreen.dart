import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/sizes.dart';
import '../../../core/constants/texts.dart';
import '../../../core/providers/auth_providers.dart';
import '../../../core/themes/app_colors.dart';
import '../../../core/themes/bg.dart';
import '../../../core/themes/btn.dart';
import '../../../core/themes/passwordfield.dart';
import '../../../core/themes/textfield.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(loginLoadingProvider);

    return PlantaScaffold(
      showBackButton: true,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Title ──
            Text(
              UTexts.loginTitle,
              style: TextStyle(
                fontSize: USizes.fontSizeLg,
                fontWeight: FontWeight.bold,
                color: UColors.textPrimary,
              ),
            ),
            const VSpace(USizes.sm),

            // ── Sub Title ──
            Text(
              UTexts.loginSubTitle,
              style: TextStyle(
                fontSize: USizes.fontSizeSm,
                color: UColors.textSecondary,
                height: 1.5,
              ),
            ),
            const VSpace(USizes.defaultSpace),

            // ── Email Field ──
            PlantaTextField(
              labelText: UTexts.emailLabel,
              hintText: UTexts.emailHint,
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (v) =>
              v == null || !v.contains('@') ? 'Enter valid email' : null,
            ),
            const VSpace(USizes.spaceBtwInputFields),

            // ── Password Field ──
            PlantaPasswordField(
              labelText: UTexts.passwordLabel,
              hintText: UTexts.passwordHint,
              controller: _passwordController,
              validator: (v) =>
              v == null || v.length < 6 ? 'Min 6 characters' : null,
            ),
            const VSpace(USizes.defaultSpace),

            // ── Continue Button ──
            PlantaPrimaryButton(
              label: UTexts.continueBtn,
              isLoading: isLoading,
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  ref.read(loginLoadingProvider.notifier).state = true;
                  await Future.delayed(const Duration(seconds: 2));
                  ref.read(loginLoadingProvider.notifier).state = false;
                  // TODO: navigate or auth
                }
              },
            ),
            const VSpace(USizes.spaceBtwItems),

            // ── Don't have an account? Sign up ──
            Center(
              child: GestureDetector(
                onTap: () {
                  // Navigator.push to SignUpScreen
                },
                child: RichText(
                  text: TextSpan(
                    text: UTexts.noAccount,
                    style: TextStyle(
                      fontSize: USizes.fontSizeSm,
                      color: UColors.textSecondary,
                    ),
                    children: [
                      TextSpan(
                        text: UTexts.signUp,
                        style: TextStyle(
                          color: UColors.linkColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const VSpace(USizes.defaultSpace),

            // ── Or Sign up with ──
            const PlantaOrDivider(text: UTexts.orSignWith),


          ],
        ),
      ),
    );
  }
}