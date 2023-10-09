import 'package:counter_with_theme/core/services/base_init_service.dart';
import 'package:counter_with_theme/core/services/local_storage_service/config.dart';
import 'package:counter_with_theme/core/utils/logging/app_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalStorageService implements BaseInitService {
  Future<void> setLocale(String locale);
  String? get locale;
  Future<void> setLightTheme(bool isLightTheme);
  bool get isLightTheme;
}

class LocalStorageServiceImpl implements LocalStorageService {
  LocalStorageServiceImpl();
  late SharedPreferences preferences;

  @override
  Future<void> init() async => preferences = await SharedPreferences.getInstance();

  @override
  String? get locale => preferences.getString(StorageKeys.localeKey);

  @override
  Future<void> setLocale(String locale) =>
      preferences.setString(StorageKeys.localeKey, locale).whenComplete(() => logLocalStorage({
            'locale': locale,
          }));

  @override
  bool get isLightTheme => preferences.getBool(StorageKeys.isLightThemeKey) ?? true;

  @override
  Future<void> setLightTheme(bool isLightTheme) =>
      preferences.setBool(StorageKeys.isLightThemeKey, isLightTheme).whenComplete(() => logLocalStorage({
            'isLightTheme': isLightTheme,
          }));
}
