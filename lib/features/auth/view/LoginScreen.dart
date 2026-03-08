import 'package:farm_wise_ai/core/utils/Constants.dart';
import 'package:farm_wise_ai/features/auth/repository/auth_repository.dart';
import 'package:farm_wise_ai/features/auth/view/signUpScreen.dart';
import 'package:farm_wise_ai/features/bottom_navigation_bar/view/BottomNavigation.dart';
import 'package:farm_wise_ai/features/dashboard/view/DashboardScreen.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/Utils/sizes.dart';
import '../../../core/providers/auth_providers.dart';
import '../../../core/themes/app_colors.dart';
import '../../../core/widgets/AppScaffoldBgBasic.dart';

import '../../../core/widgets/PrimaryButton.dart';
import '../../../core/widgets/PasswordField.dart';
import '../../../core/widgets/SocialButton.dart';
import '../../../core/widgets/FTextField.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(loginLoadingProvider);

    return AppScaffoldBgBasic(

      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Title ──
              Text(
                Constants.loginTitle,
                style: TextStyle(
                  fontSize: sizes.fontSizeHeadings,
                  fontWeight: FontWeight.bold,
                  color: UColors.colorPrimary,
                ),
              ),
              const VSpace(sizes.sm),
                     // ── Sub Title ──
              Text(
                Constants.loginSubTitle,
                style: TextStyle(
                  fontSize: sizes.fontSizeSm,
                  color: UColors.textSecondary,
                  height: 1.5,
                ),
              ),
              const VSpace(sizes.defaultSpace),
        
              // ── Email Field ──
              FTextField(
                labelText: Constants.emailLabel,
                hintText: Constants.emailHint,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (v) =>
                v == null || !v.contains('@') ? 'Enter valid email' : null,
              ),
              const VSpace(sizes.spaceBtwInputFields),
        
              // ── Password Field ──
              PasswordField(
                labelText: Constants.passwordLabel,
                hintText: Constants.passwordHint,
                controller: _passwordController,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Password is required';
                  if (v.length < 6) return 'Min 6 characters';
                  return null;
                },
              ),
              const VSpace(sizes.spaceBtwSections),
        
              // ── Continue Button ──
              PrimaryButton(
                label: Constants.continueBtn,
                isLoading: isLoading,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    ref.read(loginLoadingProvider.notifier).state = true;
                    await Future.delayed(const Duration(seconds: 2));
                    ref.read(loginLoadingProvider.notifier).state = false;
                    // TODO: navigate or auth
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) =>BottomNavigation()),
                    );
                  }
                },

              ),
              const VSpace(sizes.spaceBtwSections),
                     // ── Don't have an account? Sign up ──
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()),
                    );                  },
                  child: RichText(
                    text: TextSpan(
                      text: Constants.noAccount,
                      style: TextStyle(
                        fontSize: sizes.fontSizeSm,
                        color: UColors.textSecondary,
                      ),
                      children: [
                        TextSpan(
                          text: Constants.signUp,
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
              const VSpace(sizes.spaceBtwSections),
        
              // ── Or Sign up with ──
              const OrDivider(text: Constants.orSignWith),
              const VSpace(sizes.spaceBtwSections),
              SocialButton(
                label: "Sign up with Google",
                icon: Image.asset(
                  'lib/core/assets/images/google_icon.png',
                  height: sizes.iconMd
                ),
                onPressed: () {
                  },
              )
        
            ],
          ),
        ),
      ),
    );
  }
}