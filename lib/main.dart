import 'package:farm_wise_ai/core/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/navigation/app_navigator.dart';
import 'core/providers/locale_provider.dart';
import 'features/SplashScreen/view/SplashScreen.dart';
import 'l10n/AppLocalizations.dart';
import 'l10n/AppLocalizationsOverrideDelegate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const ProviderScope(
      child: FarmWiseAiApp(),
    ),
  );
}

class FarmWiseAiApp extends ConsumerStatefulWidget {
  const FarmWiseAiApp({
    super.key,
  });

  @override
  ConsumerState<FarmWiseAiApp> createState() => _FarmWiseAiAppState();
}

class _FarmWiseAiAppState extends ConsumerState<FarmWiseAiApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final selectedLocale = ref.watch(localeProvider);
    final appLocale = selectedLocale ?? const Locale('en');
    final materialLocale =
        appLocale.languageCode == 'sd' ? const Locale('ur') : appLocale;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: rootNavigatorKey,
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
