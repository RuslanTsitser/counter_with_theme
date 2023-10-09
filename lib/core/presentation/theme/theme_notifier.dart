import 'package:counter_with_theme/core/services/local_storage_service/local_storage_service.dart';
import 'package:counter_with_theme/core/utils/logging/change_notifier_observer_mixin.dart';
import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier with ChangeNotifierObserverMixin {
  final LocalStorageService _localStorageService;
  ThemeNotifier(this._localStorageService);

  bool get isLightTheme => _localStorageService.isLightTheme;

  Future<void> toggleTheme() async {
    await _localStorageService.setLightTheme(!isLightTheme);
    notifyListeners();
  }

  @override
  Map<String, dynamic> get properties => {
        'isLightTheme': isLightTheme,
      };
}
