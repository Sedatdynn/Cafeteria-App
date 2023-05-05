import 'package:cafeteria_app/product/init/app_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/init/lang/language_delegates.dart';
import '../../../../core/theme/color/colors.dart';
import '../../../../views/home/cubit/localeCubit/locale_cubit.dart';
import '../../../navigator/app_router.dart';

class MaterialLoaded extends StatelessWidget {
  const MaterialLoaded(
      {super.key, required AppRouter appRouter, required this.state})
      : _appRouter = appRouter;

  final AppRouter _appRouter;
  final ChangeLocaleState state;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      locale: state.locale,
      routerConfig: _appRouter.config(),
      debugShowCheckedModeBanner: false,
      title: "cafeteria".tr(context),
      supportedLocales: LanguageCore.instance.supportedLocales,
      localizationsDelegates: LanguageCore.instance.delegateList,
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        for (var locale in supportedLocales) {
          if (deviceLocale != null &&
              deviceLocale.languageCode == locale.languageCode) {
            return deviceLocale;
          }
        }
        return supportedLocales.first;
      },
      theme: ThemeData(
        primarySwatch: AppColors.primarySwatch,
      ),
    );
  }
}