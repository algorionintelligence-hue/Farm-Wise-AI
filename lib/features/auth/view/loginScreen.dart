import 'package:farm_wise_ai/features/auth/repository/auth_repository.dart';
import 'package:farm_wise_ai/features/auth/view/signUpScreen.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/device_helper.dart';
import '../../../core/constants/sizes.dart';
import '../../../core/constants/texts.dart';
import '../../../core/providers/auth_providers.dart';
import '../../../core/themes/app_colors.dart';
import '../../../core/widgets/bg.dart';

import '../../../core/widgets/btn.dart';
import '../../../core/widgets/passwordfield.dart';
import '../../../core/widgets/textfield.dart';

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
                fontSize: Size.fontSizeHeadings,
                fontWeight: FontWeight.bold,
                color: UColors.colorPrimary,
              ),
            ),
            const VSpace(Size.sm),

            // ── Sub Title ──
            Text(
              UTexts.loginSubTitle,
              style: TextStyle(
                fontSize: Size.fontSizeSm,
                color: UColors.textSecondary,
                height: 1.5,
              ),
            ),
            const VSpace(Size.defaultSpace),

            // ── Email Field ──
            PlantaTextField(
              labelText: UTexts.emailLabel,
              hintText: UTexts.emailHint,
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (v) =>
              v == null || !v.contains('@') ? 'Enter valid email' : null,
            ),
            const VSpace(Size.spaceBtwInputFields),

            // ── Password Field ──
            PlantaPasswordField(
              labelText: UTexts.passwordLabel,
              hintText: UTexts.passwordHint,
              controller: _passwordController,
              validator: (v) =>
              v == null || v.length < 6 ? 'Min 6 characters' : null,
            ),
            const VSpace(Size.spaceBtwSections),

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
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => SignUpScreen()),
                  );
                }
              },

            ),
            const VSpace(Size.spaceBtwSections),

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
                      fontSize: Size.fontSizeSm,
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
            const VSpace(Size.spaceBtwSections),

            // ── Or Sign up with ──
            const PlantaOrDivider(text: UTexts.orSignWith),
            const VSpace(Size.spaceBtwSections),
            PlantaSocialButton(
              label: "Sign up with Google",
              icon: Image.asset(
                'lib/core/assets/images/google_icon.png',
                height: Size.iconMd
              ),
              onPressed: () {
                },
            )

          ],
        ),
      ),
    );
  }
}