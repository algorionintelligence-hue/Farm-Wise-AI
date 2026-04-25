import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/auth_providers.dart';
import '../../../core/themes/app_colors.dart';
import '../../../core/utils/sizes.dart';
import '../../../core/utils/utils.dart';
import '../../../core/widgets/AppScaffoldBgBasic.dart';
import '../../../core/widgets/FTextField.dart';
import '../../../core/widgets/PrimaryButton.dart';
import 'LoginScreen.dart';

class ResetPasswordScreen extends ConsumerStatefulWidget {
  const ResetPasswordScreen({
    super.key,
    this.initialUserId,
    this.initialToken,
  });

  final String? initialUserId;
  final String? initialToken;

  @override
  ConsumerState<ResetPasswordScreen> createState() =>
      _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _newPasswordController;
  late final TextEditingController _confirmPasswordController;

  bool _showNewPassword = false;
  bool _showConfirmPassword = false;

  @override
  void initState() {
    super.initState();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(resetPasswordLoadingProvider);

    return AppScaffoldBgBasic(
      showBackButton: true,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Reset Password',
                style: TextStyle(
                  fontSize: sizes.fontSizeHeadings,
                  fontWeight: FontWeight.bold,
                  color: UColors.colorPrimary,
                ),
              ),
              const VSpace(sizes.spaceBtwInputFields),
              FTextField(
                labelText: 'New Password',
                hintText: 'Create a strong password',
                controller: _newPasswordController,
                obscureText: !_showNewPassword,
                validator: validatePassword,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _showNewPassword = !_showNewPassword;
                    });
                  },
                  icon: Icon(
                    _showNewPassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    size: sizes.iconSm,
                    color: UColors.colorPrimary,
                  ),
                ),
              ),
              const VSpace(sizes.spaceBtwInputFields),
              FTextField(
                labelText: 'Confirm Password',
                hintText: 'Re-enter your new password',
                controller: _confirmPasswordController,
                obscureText: !_showConfirmPassword,
                validator: (value) {
                  final validation = validatePassword(value);
                  if (validation != null) {
                    return validation;
                  }
                  if (value != _newPasswordController.text.trim()) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _showConfirmPassword = !_showConfirmPassword;
                    });
                  },
                  icon: Icon(
                    _showConfirmPassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    size: sizes.iconSm,
                    color: UColors.colorPrimary,
                  ),
                ),
              ),
              const VSpace(sizes.spaceBtwSections),
              PrimaryButton(
                label: 'Reset Password',
                isLoading: isLoading,
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }

                  try {
                    final success = await ref
                        .read(authViewModelProvider)
                        .resetPassword(
                          userId: widget.initialUserId?.trim() ?? '',
                          token: widget.initialToken?.trim() ?? '',
                          newPassword: _newPasswordController.text.trim(),
                          confirmPassword:
                              _confirmPasswordController.text.trim(),
                        );

                    if (!mounted || !success) {
                      return;
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Password reset successful. Please log in.',
                        ),
                      ),
                    );

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => LoginScreen()),
                      (route) => false,
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
