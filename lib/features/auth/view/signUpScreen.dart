import 'package:farm_wise_ai/features/farm_registration/view/FarmRegistrationScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/Utils/sizes.dart';
import '../../../core/Utils/utils.dart';
import '../../../core/providers/auth_providers.dart';
import '../../../core/themes/app_colors.dart';
import '../../../core/utils/Constants.dart';
import '../../../core/widgets/AppScaffoldBgBasic.dart';
import '../../../core/widgets/PrimaryButton.dart';
import '../../../core/widgets/PasswordField.dart';
import '../../../core/widgets/FTextField.dart';
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

      return AppScaffoldBgBasic(
        showBackButton: Navigator.canPop(context),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Title ──
                Text(
                  Constants.signupTitle,
                  style: TextStyle(
                    fontSize: sizes.fontSizeHeadings,
                    fontWeight: FontWeight.bold,
                    color: UColors.colorPrimary,
                  ),
                ),
                const VSpace(sizes.sm),
                Text(
                  Constants.signupSubTitle,
                  style: TextStyle(
                    fontSize: sizes.fontSizeSm,
                    color: UColors.textSecondary,
                    height: 1.5,
                  ),
                ),
                const VSpace(sizes.defaultSpace),

                // ── First + Last Name (Row) ──
                Row(
                  children: [
                    Expanded(
                      child: FTextField(
                        labelText: Constants.firstName,
                        hintText: 'John',
                        controller: _firstNameController,
                        validator: (v) =>
                            v == null || v.isEmpty ? 'Required' : null,
                      ),
                    ),
                    const HSpace(sizes.spaceBtwItems),
                    Expanded(
                      child: FTextField(
                        labelText: Constants.lastName,
                        hintText: 'Doe',
                        controller: _lastNameController,
                        validator: (v) =>
                            v == null || v.isEmpty ? 'Required' : null,
                      ),
                    ),
                  ],
                ),
                const VSpace(sizes.spaceBtwInputFields),

                // ── Email ──
                FTextField(
                  labelText: Constants.emailLabel,
                  hintText: Constants.emailHint,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) =>
                      v == null || !v.contains('@') ? 'Enter valid email' : null,
                ),
                const VSpace(sizes.spaceBtwInputFields),

                // ── Phone ──
                FTextField(
                  labelText: Constants.phoneNumber,
                  hintText: '+92 300 0000000',
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  validator: (v) =>
                      v == null || v.length < 10 ? 'Enter valid phone' : null,
                ),
                const VSpace(sizes.spaceBtwInputFields),

                // ── Password ──
                PasswordField(
                  controller: _passwordController,
                  validator: (v) => validatePassword(v),
                ),
                const VSpace(sizes.defaultSpace),

                // ── Terms & Privacy ──
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                      width: 20,
                      child: Checkbox(
                        value: termsAccepted,  // ✅ driven by state
                        activeColor: UColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(sizes.borderRadiusSm),
                        ),
                        onChanged: (val) {
                          ref.read(termsAcceptedProvider.notifier).state = val ?? false;  // ✅ updates state
                        },
                      ),
                    ),
                    const HSpace(sizes.sm),
                    Expanded(
                      child: RichText(
                        text: const TextSpan(
                          text: '${Constants.iAgreeTo} ',
                          style: TextStyle(
                            fontSize: sizes.fontSizeSm,
                            color: UColors.textSecondary,
                          ),
                          children: [
                            TextSpan(
                              text: Constants.privacyPolicy,
                              style: TextStyle(
                                color: UColors.linkColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(text: ' ${Constants.and} '),
                            TextSpan(
                              text: Constants.termsOfUse,
                              style: TextStyle(
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

                // ── Create Account Button ──
                PrimaryButton(
                  label: Constants.createAccount,
                  isLoading: isLoading,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final success =
                          await ref.read(authViewModelProvider).signUp(
                                fName: _firstNameController.text.trim(),
                                lName: _lastNameController.text.trim(),
                                email: _emailController.text.trim(),
                                phone: _phoneController.text.trim(),
                                password: _passwordController.text.trim(),
                              );

                      if (success && context.mounted) {
                        // Navigator.pushReplacementNamed(context, '/login');
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => FarmRegistrationScreen()),
                        );
                        // Navigator.pushReplacementNamed(context, '/login');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                OtpScreen(email: _emailController.text.trim()),
                          ),
                        );
                      }
                    }
                  },
                ),
                const VSpace(sizes.spaceBtwItems),

                // ── Already have account? ──
                Center(
                  child: GestureDetector(
                    onTap: () {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);  // if login is in stack, just go back
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => LoginScreen()),
                        );  // if no back stack, replace with login
                      }
                    },
                    child: RichText(
                      text: TextSpan(
                        text: Constants.alreadyHaveAccount,
                        style: TextStyle(
                          fontSize: sizes.fontSizeSm,
                          color: UColors.textSecondary,
                        ),
                        children: const [
                          TextSpan(
                            text: Constants.logIn,
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
                const VSpace(sizes.defaultSpace),
              ],
            ),
          ),
        ),
      );
    }
  }
