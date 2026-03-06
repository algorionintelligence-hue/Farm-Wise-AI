import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import '../Utils/sizes.dart';
import '../themes/app_colors.dart';

class AppScaffoldBgBasic extends StatelessWidget {
  final Widget child;
  final bool showBackButton;

  const AppScaffoldBgBasic({
    super.key,
    required this.child,
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UColors.colorPrimary,
      body: Column(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 16 , right: 16),
              child:


              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (showBackButton)
                    BackButton(
                      color: Colors.white,
                      onPressed: () => Navigator.pop(context),
                    )
                  else
                    const SizedBox(width: 48),
                  const Spacer(), // pushes logo to the right
                  SizedBox(
                    height: 50,
                    child: Image.asset(
                      'lib/core/assets/images/logo_without_bg.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: UColors.screenBackground,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(sizes.scaffoldTopRadius),
                  topRight: Radius.circular(sizes.scaffoldTopRadius),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: child,
              ),
            ),
          )
        ],
      ),
    );
  }
}