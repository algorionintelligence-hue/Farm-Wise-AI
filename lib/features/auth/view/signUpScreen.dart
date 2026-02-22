import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/sizes.dart';
import '../../../core/constants/texts.dart';
import '../../../core/providers/auth_providers.dart';
import '../../../core/themes/app_colors.dart';
import '../../../core/widgets/bg.dart';
import '../../../core/widgets/btn.dart';
import '../../../core/widgets/passwordfield.dart';
import '../../../core/widgets/textfield.dart';
import 'loginScreen.dart';


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

    return PlantaScaffold(
      showBackButton: true,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Title ──
            Text(
              UTexts.signupTitle,
              style: TextStyle(
                fontSize: Size.fontSizeHeadings,
                fontWeight: FontWeight.bold,
                color: UColors.colorPrimary,
              ),
            ),
            const VSpace(Size.sm),
            Text(
              UTexts.signupSubTitle,
              style: TextStyle(
                fontSize: Size.fontSizeSm,
                color: UColors.textSecondary,
                height: 1.5,
              ),
            ),
            const VSpace(Size.defaultSpace),

            // ── First + Last Name (Row) ──
            Row(
              children: [
                Expanded(
                  child: PlantaTextField(
                    labelText: UTexts.firstName,
                    hintText: 'John',
                    controller: _firstNameController,
                    validator: (v) =>
                    v == null || v.isEmpty ? 'Required' : null,
                  ),
                ),
                const HSpace(Size.spaceBtwItems),
                Expanded(
                  child: PlantaTextField(
                    labelText: UTexts.lastName,
                    hintText: 'Doe',
                    controller: _lastNameController,
                    validator: (v) =>
                    v == null || v.isEmpty ? 'Required' : null,
                  ),
                ),
              ],
            ),
            const VSpace(Size.spaceBtwInputFields),

            // ── Email ──
            PlantaTextField(
              labelText: UTexts.emailLabel,
              hintText: UTexts.emailHint,
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (v) =>
              v == null || !v.contains('@') ? 'Enter valid email' : null,
            ),
            const VSpace(Size.spaceBtwInputFields),

            // ── Phone ──
            PlantaTextField(
              labelText: UTexts.phoneNumber,
              hintText: '+92 300 0000000',
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              validator: (v) =>
              v == null || v.length < 10 ? 'Enter valid phone' : null,
            ),
            const VSpace(Size.spaceBtwInputFields),

            // ── Password ──
            PlantaPasswordField(
              controller: _passwordController,
              validator: (v) =>
              v == null || v.length < 6 ? 'Min 6 characters' : null,
            ),
            const VSpace(Size.defaultSpace),

            // ── Terms & Privacy ──
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                  width: 20,
                  child: Checkbox(
                    value: false,
                    activeColor: UColors.plantaGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(Size.borderRadiusSm),
                    ),
                    onChanged: (val) {},
                  ),
                ),
                const HSpace(Size.sm),
                Expanded(
                  child: RichText(
                    text: const TextSpan(
                      text: '${UTexts.iAgreeTo} ',
                      style: TextStyle(
                        fontSize: Size.fontSizeSm,
                        color: UColors.textSecondary,
                      ),
                      children: [
                        TextSpan(
                          text: UTexts.privacyPolicy,
                          style: TextStyle(
                            color: UColors.linkColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(text: ' ${UTexts.and} '),
                        TextSpan(
                          text: UTexts.termsOfUse,
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
            const VSpace(Size.defaultSpace),

            // ── Create Account Button ──
            PlantaPrimaryButton(
              label: UTexts.createAccount,
              isLoading: isLoading,
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  ref.read(signupLoadingProvider.notifier).state = true;
                  await Future.delayed(const Duration(seconds: 2));
                  ref.read(signupLoadingProvider.notifier).state = false;
                  // TODO: navigate or auth
                //   Navigator.pushReplacement(
                //     context,
                //     MaterialPageRoute(builder: (_) => LoginScreen()),
                //   );
                 }
              },
            ),
            const VSpace(Size.spaceBtwItems),

            // ── Already have account? ──
            Center(
              child: GestureDetector(
                onTap: () {
                  // Navigator.pop to LoginScreen
                },
                child: RichText(
                  text: TextSpan(
                    text: UTexts.alreadyHaveAccount,
                    style: TextStyle(
                      fontSize: Size.fontSizeSm,
                      color: UColors.textSecondary,
                    ),
                    children: const [
                      TextSpan(
                        text: UTexts.logIn,
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
            const VSpace(Size.defaultSpace),


          ],
        ),
      ),
    );
  }
}
