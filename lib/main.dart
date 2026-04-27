import 'package:farm_wise_ai/core/themes/app_theme.dart';
<<<<<<< Updated upstream
import 'package:farm_wise_ai/features/auth/view/loginScreen.dart';
import 'package:farm_wise_ai/features/auth/view/signUpScreen.dart';
import 'package:farm_wise_ai/features/dashboard/view/dashboard_screen.dart';
import 'package:farm_wise_ai/features/entry_point/view/splashScreen.dart';
=======
import 'package:farm_wise_ai/features/FarmRegistration/view/FarmRegistrationScreen.dart';
import 'package:farm_wise_ai/features/auth/view/ResetPasswordScreen.dart';
>>>>>>> Stashed changes
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

<<<<<<< Updated upstream
import 'features/bottom_navigation_bar/view/bottomNavigation.dart';
import 'features/farm_registration/view/FarmRegistrationScreen.dart';
=======
import 'features/SplashScreen/view/SplashScreen.dart';
import 'l10n/AppLocalizations.dart';
import 'l10n/AppLocalizationsOverrideDelegate.dart';


>>>>>>> Stashed changes

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
<<<<<<< Updated upstream
}
=======

  Route<dynamic> _buildRoute(RouteSettings settings) {
    final incomingUri = _parseIncomingUri(settings.name);

    if (incomingUri.path.startsWith(_resetPasswordRoute)) {
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => ResetPasswordScreen(
          initialUserId: _readQueryParameter(
            incomingUri,
            const ['userId', 'userID', 'UserId', 'UserID'],
          ),
          initialToken: _readQueryParameter(
            incomingUri,
            const ['token', 'Token', 'resetToken', 'ResetToken'],
          ),
        ),
      );
    }

    return MaterialPageRoute(
      settings: const RouteSettings(name: _homeRoute),
      builder: (_) =>  FarmRegistrationScreen(),
    );
  }

  Uri _parseIncomingUri(String? routeName) {
    final trimmedRoute = routeName?.trim();
    if (trimmedRoute == null || trimmedRoute.isEmpty) {
      return Uri(path: _homeRoute);
    }

    final parsedUri = Uri.tryParse(trimmedRoute);
    if (parsedUri == null) {
      return Uri(path: _homeRoute);
    }

    if (parsedUri.hasScheme && parsedUri.host.isNotEmpty) {
      return parsedUri;
    }

    if (trimmedRoute.startsWith('/')) {
      return parsedUri;
    }

    return Uri(path: '$_homeRoute$trimmedRoute');
  }

  String? _readQueryParameter(Uri uri, List<String> keys) {
    for (final key in keys) {
      final value = uri.queryParameters[key];
      if (value != null && value.trim().isNotEmpty) {
        return value.trim();
      }
    }

    return null;
  }
}
>>>>>>> Stashed changes
