import 'dart:io';

import 'package:counter_with_theme/core/presentation/localization/generated/l10n.dart';
import 'package:counter_with_theme/core/services/local_storage_service/local_storage_service.dart';
import 'package:counter_with_theme/core/utils/logging/change_notifier_observer_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AppLocalization with ChangeNotifier, ChangeNotifierObserverMixin {
  final LocalStorageService _storage;
  AppLocalization(this._storage);

  Locale? _locale;
  Future<void> setLocale(Locale locale) async {
    if (_locale == locale) return;
    _locale = locale;
    await _storage.setLocale(locale.languageCode);
    notifyListeners();
  }

  Locale get locale {
    final locale = _storage.locale;
    if (locale != null) {
      return Locale(locale);
    }
    return _locale ?? Locale(Platform.localeName.substring(0, 2));
  }

  Iterable<LocalizationsDelegate<dynamic>> get localizationsDelegates => [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ];

  Iterable<Locale> get supportedLocales => S.delegate.supportedLocales;

  @override
  Map<String, dynamic> get properties => {
        "locale": locale,
      };
}
