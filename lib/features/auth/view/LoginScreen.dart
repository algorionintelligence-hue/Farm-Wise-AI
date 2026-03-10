import 'package:farm_wise_ai/features/auth/view/signUpScreen.dart';
import 'package:farm_wise_ai/features/bottom_navigation_bar/view/BottomNavigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/auth_providers.dart';
import '../../../core/themes/app_colors.dart';
import '../../../core/utils/sizes.dart';
import '../../../core/widgets/AppScaffoldBgBasic.dart';
import '../../../core/widgets/FTextField.dart';
import '../../../core/widgets/PasswordField.dart';
import '../../../core/widgets/PrimaryButton.dart';
import '../../../core/widgets/SocialButton.dart';
import '../../../l10n/app_localizations.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(loginLoadingProvider);
    final l10n = AppLocalizations.of(context)!;

    return AppScaffoldBgBasic(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.loginTitle,
                style: const TextStyle(
                  fontSize: sizes.fontSizeHeadings,
                  fontWeight: FontWeight.bold,
                  color: UColors.colorPrimary,
                ),
              ),
              const VSpace(sizes.sm),
              Text(
                l10n.loginSubtitle,
                style: const TextStyle(
                  fontSize: sizes.fontSizeSm,
                  color: UColors.textSecondary,
                  height: 1.5,
                ),
              ),
              const VSpace(sizes.defaultSpace),
              FTextField(
                labelText: l10n.emailLabel,
                hintText: l10n.emailHint,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (v) =>
                    v == null || !v.contains('@') ? 'Enter valid email' : null,
              ),
              const VSpace(sizes.spaceBtwInputFields),
              PasswordField(
                labelText: l10n.passwordLabel,
                hintText: l10n.passwordHint,
                controller: _passwordController,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Password is required';
                  if (v.length < 6) return 'Min 6 characters';
                  return null;
                },
              ),
              const VSpace(sizes.spaceBtwSections),
              PrimaryButton(
                label: l10n.continueButton,
                isLoading: isLoading,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    ref.read(loginLoadingProvider.notifier).state = true;
                    await Future.delayed(const Duration(seconds: 2));
                    ref.read(loginLoadingProvider.notifier).state = false;
                    if (context.mounted) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const BottomNavigation()),
                      );
                    }
                  }
                },
              ),
              const VSpace(sizes.spaceBtwSections),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()),
                    );
                  },
                  child: RichText(
                    text: TextSpan(
                      text: l10n.noAccount,
                      style: const TextStyle(
                        fontSize: sizes.fontSizeSm,
                        color: UColors.textSecondary,
                      ),
                      children: [
                        TextSpan(
                          text: l10n.signUp,
                          style: const TextStyle(
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
              OrDivider(text: l10n.orSignWith),
              const VSpace(sizes.spaceBtwSections),
              SocialButton(
                label: l10n.signUpWithGoogle,
                icon: Image.asset(
                  'lib/core/assets/images/google_icon.png',
                  height: sizes.iconMd,
                ),
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
