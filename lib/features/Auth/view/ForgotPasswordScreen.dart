import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/auth_providers.dart';
import '../../../core/themes/app_colors.dart';
import '../../../core/utils/sizes.dart';
import '../../../core/widgets/AppScaffoldBgBasic.dart';
import '../../../core/widgets/FTextField.dart';
import '../../../core/widgets/PrimaryButton.dart';
import 'ResetPasswordScreen.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({
    super.key,
    this.initialEmail,
  });

  final String? initialEmail;

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: widget.initialEmail ?? '');
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(forgotPasswordLoadingProvider);

    return AppScaffoldBgBasic(
      showBackButton: true,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Forgot Password',
                style: TextStyle(
                  fontSize: sizes.fontSizeHeadings,
                  fontWeight: FontWeight.bold,
                  color: UColors.colorPrimary,
                ),
              ),
              const VSpace(sizes.defaultSpace),
              FTextField(
                labelText: 'Email',
                hintText: 'Enter your email',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Email is required';
                  }
                  if (!value.contains('@')) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),
              const VSpace(sizes.spaceBtwSections),
              PrimaryButton(
                label: 'Continue to Reset',
                isLoading: isLoading,
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }

                  try {
                    final result = await ref
                        .read(authViewModelProvider)
                        .forgotPassword(_emailController.text.trim());

                    if (!mounted) {
                      return;
                    }

                    if ((result?.message ?? '').isNotEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(result!.message!)),
                      );
                    }

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ResetPasswordScreen(
                          initialUserId: result?.userId,
                          initialToken: result?.token,
                        ),
                      ),
                    );
                  } catch (error) {
                    if (!mounted) {
                      return;
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          error.toString().replaceFirst('Exception: ', ''),
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
