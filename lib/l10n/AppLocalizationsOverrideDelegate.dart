import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'AppLocalizations.dart';

/// Delegate that forces AppLocalizations to load a specific locale.
class AppLocalizationsOverrideDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsOverrideDelegate(this.appLocale);

  final Locale appLocale;

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(
      lookupAppLocalizations(appLocale),
    );
  }

  @override
  bool isSupported(Locale locale) => true;

  @override
  bool shouldReload(AppLocalizationsOverrideDelegate old) =>
      old.appLocale != appLocale;
}
