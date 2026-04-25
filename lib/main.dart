import 'package:farm_wise_ai/core/providers/locale_provider.dart';
import 'package:farm_wise_ai/core/themes/app_theme.dart';
import 'package:farm_wise_ai/features/auth/view/ResetPasswordScreen.dart';
import 'package:farm_wise_ai/features/splash_screen/view/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  static const _homeRoute = '/';
  static const _resetPasswordRoute = '/reset-password';

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
      initialRoute: initialRouteName,
      onGenerateRoute: (settings) => _buildRoute(settings),
    );
  }

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
      builder: (_) => const SplashScreen(),
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
