import 'package:farm_wise_ai/core/providers/locale_provider.dart';
import 'package:farm_wise_ai/core/themes/app_theme.dart';
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedLocale = ref.watch(localeProvider);
    final appLocale = selectedLocale ?? const Locale('en');
    final materialLocale =
        appLocale.languageCode == 'sd' ? const Locale('ur') : appLocale;

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
      home: const SplashScreen(),
    );
  }
}
