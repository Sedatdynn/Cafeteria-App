import 'package:cafeteria_app/core/init/cache/cache_manager.dart';
import 'package:cafeteria_app/product/enums/cache/cache_keys.dart';

class LanguageCacheHelper {
  Future<void> cacheLanguageCode(String languageCode) async {
    LocaleManager.instance
        .setStringValue(CacheKeys.LOCALE.rawValue, languageCode);
  }

  Future<String> getCachedLanguageCode() async {
    final cachedLanguageCode =
        await LocaleManager.instance.getStringValue(CacheKeys.LOCALE.rawValue);
    if (cachedLanguageCode != null) {
      return cachedLanguageCode;
    } else {
      return "tr";
    }
  }
}
