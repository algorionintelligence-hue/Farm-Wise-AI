import 'package:farm_wise_ai/core/themes/app_theme.dart';
import 'package:farm_wise_ai/features/bottom_navigation_bar/view/BottomNavigation.dart';
import 'package:farm_wise_ai/features/farm_registration/view/FarmRegistrationScreen.dart';
import 'package:farm_wise_ai/features/herd_form/view/HerdStepperScreen.dart';
import 'package:farm_wise_ai/features/revenue_form/view/RevenueInputsScreen.dart';
import 'package:farm_wise_ai/features/splash_screen/view/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/providers/locale_provider.dart';
import 'l10n/app_localizations.dart';
import 'l10n/app_localizations_override.dart';

void main() {
  runApp(
    const ProviderScope(
      child: FarmWiseAiApp(),
    ),
  );
}

class FarmWiseAiApp extends ConsumerWidget {
  const FarmWiseAiApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedLocale = ref.watch(localeProvider);
    final appLocale = selectedLocale ?? const Locale('en');
    final materialLocale =
        appLocale.languageCode == 'sd' ? const Locale('ur') : appLocale;
    final initialRouteName =
        WidgetsBinding.instance.platformDispatcher.defaultRouteName;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: materialLocale,
      localizationsDelegates: [
        AppLocalizationsOverrideDelegate(appLocale),
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appName,
      theme: AppTheme.light,
    //   initialRoute: initialRouteName,
    //   onGenerateRoute: (settings) => _buildRoute(settings),
    // );

        initialRoute: '/',
        routes: {
          '/': (context) => FarmRegistrationScreen(),
        },
    );
  }

  // Route<dynamic> _buildRoute(RouteSettings settings) {
  //   final incomingUri = _parseIncomingUri(settings.name);
  //
  //   if (incomingUri.path.startsWith(_resetPasswordRoute)) {
  //     return MaterialPageRoute(
  //       settings: settings,
  //       builder: (_) => ResetPasswordScreen(
  //         initialUserId: _readQueryParameter(
  //           incomingUri,
  //           const ['userId', 'userID', 'UserId', 'UserID'],
  //         ),
  //         initialToken: _readQueryParameter(
  //           incomingUri,
  //           const ['token', 'Token', 'resetToken', 'ResetToken'],
  //         ),
  //       ),
  //     );
  //   }
  //
  //   return MaterialPageRoute(
  //     settings: const RouteSettings(name: _homeRoute),
  //     builder: (_) => const SplashScreen(),
  //   );
  // }
}