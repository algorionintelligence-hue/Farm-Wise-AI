import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/auth_providers.dart';
import '../../../core/themes/app_colors.dart';
import '../../../core/utils/sizes.dart';
import '../../../core/utils/utils.dart';
import '../../../core/widgets/AppScaffoldBgBasic.dart';
import '../../../core/widgets/FTextField.dart';
import '../../../core/widgets/PasswordField.dart';
import '../../../core/widgets/PrimaryButton.dart';
import '../../../l10n/AppLocalizations.dart';
import 'LoginScreen.dart';
import 'otp/OtpScreen.dart';

class SignUpScreen extends ConsumerWidget {
  SignUpScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(signupLoadingProvider);
    final termsAccepted = ref.watch(termsAcceptedProvider);
    final l10n = AppLocalizations.of(context)!;

    return AppScaffoldBgBasic(
      showBackButton: Navigator.canPop(context),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.signupTitle,
                style: const TextStyle(
                  fontSize: sizes.fontSizeHeadings,
                  fontWeight: FontWeight.bold,
                  color: UColors.colorPrimary,
                ),
              ),
              const VSpace(sizes.sm),
              Text(
                l10n.signupSubtitle,
                style: const TextStyle(
                  fontSize: sizes.fontSizeSm,
                  color: UColors.textSecondary,
                  height: 1.5,
                ),
              ),
              const VSpace(sizes.defaultSpace),
              Row(
                children: [
                  Expanded(
                    child: FTextField(
                      labelText: l10n.firstName,
                      hintText: 'John',
                      controller: _firstNameController,
                      validator: (v) => v == null || v.isEmpty ? l10n.requiredField : null,
                    ),
                  ),
                  const HSpace(sizes.spaceBtwItems),
                  Expanded(
                    child: FTextField(
                      labelText: l10n.lastName,
                      hintText: 'Doe',
                      controller: _lastNameController,
                      validator: (v) => v == null || v.isEmpty ? l10n.requiredField : null,
                    ),
                  ),
                ],
              ),
              const VSpace(sizes.spaceBtwInputFields),
              FTextField(
                labelText: l10n.emailLabel,
                hintText: l10n.emailHint,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (v) => v == null || !v.contains('@') ? l10n.enterValidEmail : null,
              ),
              const VSpace(sizes.spaceBtwInputFields),
              FTextField(
                labelText: l10n.phoneNumber,
                hintText: '+92 300 0000000',
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                validator: (v) => v == null || v.length < 10 ? l10n.enterValidPhone : null,
              ),
              const VSpace(sizes.spaceBtwInputFields),
              PasswordField(
                labelText: l10n.passwordLabel,
                hintText: l10n.passwordHint,
                controller: _passwordController,
                validator: (v) => validatePassword(v),
              ),
              const VSpace(sizes.defaultSpace),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                    width: 20,
                    child: Checkbox(
                      value: termsAccepted,
                      activeColor: UColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(sizes.borderRadiusSm),
                      ),
                      onChanged: (val) {
                        ref.read(termsAcceptedProvider.notifier).state = val ?? false;
                      },
                    ),
                  ),
                  const HSpace(sizes.sm),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: '${l10n.iAgreeTo} ',
                        style: const TextStyle(
                          fontSize: sizes.fontSizeSm,
                          color: UColors.textSecondary,
                        ),
                        children: [
                          TextSpan(
                            text: l10n.privacyPolicy,
                            style: const TextStyle(
                              color: UColors.linkColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(text: ' ${l10n.and} '),
                          TextSpan(
                            text: l10n.termsOfUse,
                            style: const TextStyle(
                              color: UColors.linkColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const VSpace(sizes.defaultSpace),
              PrimaryButton(
                label: l10n.createAccount,
                isLoading: isLoading,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final success = await ref.read(authViewModelProvider).signUp(
                          fName: _firstNameController.text.trim(),
                          lName: _lastNameController.text.trim(),
                          email: _emailController.text.trim(),
                          phone: _phoneController.text.trim(),
                          password: _passwordController.text.trim(),
                        );

                    if (success && context.mounted) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => OtpScreen(email: _emailController.text.trim()),
                        ),
                      );
                    }
                  }
                },
              ),
              const VSpace(sizes.spaceBtwItems),
              Center(
                child: GestureDetector(
                  onTap: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => LoginScreen()),
                      );
                    }
                  },
                  child: RichText(
                    text: TextSpan(
                      text: l10n.alreadyHaveAccount,
                      style: const TextStyle(
                        fontSize: sizes.fontSizeSm,
                        color: UColors.textSecondary,
                      ),
                      children: [
                        TextSpan(
                          text: l10n.logIn,
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
              const VSpace(sizes.defaultSpace),
            ],
          ),
        ),
      ),
    );
  }
}
