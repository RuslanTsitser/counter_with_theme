import 'package:counter_with_theme/core/services/base_init_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalStorageService implements BaseInitService {
  Future<void> setLocale(String locale);
  String? get locale;
}

class LocalStorageServiceImpl implements LocalStorageService {
  LocalStorageServiceImpl();
  late SharedPreferences preferences;

  @override
  Future<void> init() async => preferences = await SharedPreferences.getInstance();

  @override
  // TODO: implement locale
  String? get locale => throw UnimplementedError();

  @override
  Future<void> setLocale(String locale) {
    // TODO: implement setLocale
    throw UnimplementedError();
  }
}
