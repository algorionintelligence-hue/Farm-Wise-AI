import 'package:farm_wise_ai/core/themes/app_theme.dart';
import 'package:farm_wise_ai/features/auth/view/loginScreen.dart';
import 'package:farm_wise_ai/features/auth/view/signUpScreen.dart';
import 'package:farm_wise_ai/features/entry_point/view/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/ai/view/ai_qna.dart';
import 'features/bottom_navigation_bar/view/bottomNavigation.dart';
import 'features/cost/view/cost.dart';
import 'features/farm_registration/view/FarmRegistrationScreen.dart';
import 'features/herd/view/herd_stepper_screen.dart';
import 'features/revenue/view/revenue.dart';
import 'features/working_capital/view/working_capital.dart';

void main() {
  runApp(
    ProviderScope(
      child: FarmWiseAiApp(),
    ),
  );
}

class FarmWiseAiApp extends StatelessWidget {
  const FarmWiseAiApp({super.key});

  @override
  Widget build(BuildContext context) {

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Farm Wise AI',
          theme: AppTheme.light,
          // home: FarmRegistrationScreen(),
          // home: HerdStepperScreen(),
          home: BottomNavigation(),
          // home: SplashScreen(),
        );
  }
}