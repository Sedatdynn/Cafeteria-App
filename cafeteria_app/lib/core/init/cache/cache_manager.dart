import 'package:cafeteria_app/product/enums/cache/cache_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleManager {
  LocaleManager._init() {
    SharedPreferences.getInstance().then((value) {
      _preferences = value;
    });
  }
  static final LocaleManager _instance = LocaleManager._init();

  SharedPreferences? _preferences;
  static LocaleManager get instance => _instance;
  static Future preferencesInit() async {
    instance._preferences ??= await SharedPreferences.getInstance();
  }

  Future<void> clearAll() async {
    await _preferences!.clear();
  }

  Future<void> setStringValue(String key, String value) async {
    await _preferences!.setString(key.toString(), value);
  }

  Future<void> setBoolValue(String key, bool value) async {
    await _preferences!.setBool(key, true);
  }

  Future<void> removeCacheValue(String value) async {
    await _preferences!.remove(value);
  }

  getStringValue(String key) async {
    return _preferences?.getString("LOCALE");
  }

  getBoolValue(String key) => _preferences?.getBool(key) ?? false;
}
