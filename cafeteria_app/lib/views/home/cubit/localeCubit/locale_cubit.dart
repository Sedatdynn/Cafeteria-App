import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../product/init/app_local_helper.dart';
import 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit() : super(const LocaleState());

  Future<void> getSavedLanguage() async {
    final String cachedLanguageCode =
        await LanguageCacheHelper().getCachedLanguageCode();
    emit(state.copyWith(locale: Locale(cachedLanguageCode)));
    // emit(ChangeLocaleState(locale: Locale(cachedLanguageCode)));
  }

  Future changeLanguage(String languageCode) async {
    changeLoading();
    await LanguageCacheHelper().cacheLanguageCode(languageCode);
    emit(state.copyWith(locale: Locale(languageCode)));
    changeLoading();
  }

  // emit(ChangeLocaleState(locale: Locale(languageCode)));
  void changeLoading() {
    emit(state.copyWith(isLoading: !(state.isLoading ?? false)));
  }
}
