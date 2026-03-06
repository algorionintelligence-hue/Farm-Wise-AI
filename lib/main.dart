import 'package:farm_wise_ai/core/themes/app_theme.dart';
import 'package:farm_wise_ai/features/bottom_navigation_bar/view/BottomNavigation.dart';
import 'package:flutter/material.dart';
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

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Farm Wise AI',
          theme: AppTheme.light,
           home: BottomNavigation(),
        );
  }
}