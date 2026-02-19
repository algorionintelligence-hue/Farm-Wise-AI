import 'package:farm_wise_ai/core/themes/app_theme.dart';
import 'package:farm_wise_ai/features/entry_point/view/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    return ScreenUtilInit(
      designSize: const Size(375, 812), // iPhone X size (standard reference)
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Farm Wise AI',
          theme: AppTheme.light,
          home: const SplashScreen(),
        );
      },
    );
  }
}