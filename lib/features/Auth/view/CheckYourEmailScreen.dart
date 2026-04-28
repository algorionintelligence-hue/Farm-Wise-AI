import 'package:flutter/material.dart';

import '../../../core/themes/app_colors.dart';
import '../../../core/utils/sizes.dart';
import '../../../core/widgets/AppScaffoldBgBasic.dart';
import '../../../core/widgets/PrimaryButton.dart';
import 'LoginScreen.dart';

class CheckYourEmailScreen extends StatelessWidget {
  const CheckYourEmailScreen({
    super.key,
    required this.email,
    this.message,
  });

  final String email;
  final String? message;

  @override
  Widget build(BuildContext context) {
    final trimmedEmail = email.trim();
    final infoMessage = (message ?? '').trim().isNotEmpty
        ? message!.trim()
        : 'We sent a password reset link to your email. Open the email and tap the reset button to continue in the app.';

    return AppScaffoldBgBasic(
      showBackButton: true,
      child: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: UColors.colorPrimary,
                  ),
                  child: const Icon(
                    Icons.mark_email_read_outlined,
                    color: Colors.white,
                    size: 34,
                  ),
                ),
                const VSpace(sizes.defaultSpace),
                const Text(
                  'Check Your Email',
                  style: TextStyle(
                    fontSize: sizes.fontSizeHeadings,
                    fontWeight: FontWeight.bold,
                    color: UColors.colorPrimary,
                  ),
                ),
                const VSpace(sizes.spaceBtwItems),
                Text(
                  infoMessage,
                  style: const TextStyle(
                    fontSize: sizes.fontSizeMd,
                    color: UColors.textSecondary,
                    height: 1.6,
                  ),
                ),
                if (trimmedEmail.isNotEmpty) ...[
                  const VSpace(sizes.spaceBtwSections),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(sizes.md),
                    decoration: BoxDecoration(
                      color: UColors.colorPrimary.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(sizes.cardRadiusMd),
                      border: Border.all(
                        color: UColors.colorPrimary.withOpacity(0.16),
                      ),
                    ),
                    child: Text(
                      trimmedEmail,
                      style: const TextStyle(
                        fontSize: sizes.fontSizeMd,
                        fontWeight: FontWeight.w700,
                        color: UColors.colorPrimary,
                      ),
                    ),
                  ),
                ],
                const VSpace(sizes.spaceBtwSections),
                const Text(
                  'Once you tap "Reset Password" in the email, the app will open your password reset screen automatically.',
                  style: TextStyle(
                    fontSize: sizes.fontSizeSm,
                    color: UColors.textSecondary,
                    height: 1.6,
                  ),
                ),
                const VSpace(sizes.spaceBtwSections),
                PrimaryButton(
                  label: 'Back to Login',
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => LoginScreen()),
                      (route) => false,
                    );
                  },
                ),
                const VSpace(sizes.spaceBtwItems),
                Center(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Use another email',
                      style: TextStyle(
                        color: UColors.linkColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
