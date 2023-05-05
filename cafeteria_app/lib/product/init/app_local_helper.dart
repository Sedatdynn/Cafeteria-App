import 'package:cafeteria_app/core/init/cache/cache_manager.dart';

class LanguageCacheHelper {
  Future<void> cacheLanguageCode(String languageCode) async {
    LocaleManager.instance.setStringValue("LOCALE", languageCode);
  }

  Future<String> getCachedLanguageCode() async {
    final cachedLanguageCode =
        await LocaleManager.instance.getStringValue("LOCALE");
    if (cachedLanguageCode != null) {
      return cachedLanguageCode;
    } else {
      return "tr";
    }
  }
}
