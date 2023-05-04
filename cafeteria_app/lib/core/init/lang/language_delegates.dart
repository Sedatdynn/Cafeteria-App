import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../../../product/init/app_localization.dart';

class LanguageCore {
  static LanguageCore? _instance;
  static LanguageCore get instance {
    _instance ??= LanguageCore._init();
    return _instance!;
  }

  LanguageCore._init();

  Iterable<LocalizationsDelegate<dynamic>>? get delegateList => _delegateList;
  List<Locale> get supportedLocales => _supportedLocales;

  final Iterable<LocalizationsDelegate<dynamic>> _delegateList = [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate
  ];

  final List<Locale> _supportedLocales = const [Locale('en'), Locale('tr')];
}
