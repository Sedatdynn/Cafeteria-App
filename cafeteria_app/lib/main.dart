import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/theme/theme_color_shelf.dart';
import 'product/init/app_localization.dart';
import 'product/navigator/app_router.dart';
import 'product/widget/widgets_shelf.dart';
import 'views/home/cubit/localeCubit/locale_cubit.dart';
import 'views/home/home_shelf.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              return LocaleCubit()..getSavedLanguage();
            },
          ),
          BlocProvider(
            create: (context) {
              return InternetCubit()..checkConnection();
            },
          ),
          BlocProvider(
            create: (context) {
              return HomeCubit(GeneralService(
                  ProjectNetworkManager.instance.service, "QFj-hS"))
                ..fetchAllProduct();
            },
          ),
        ],
        child: BlocBuilder<LocaleCubit, LocaleState>(
          builder: (context, state) {
            if (state is LocaleInitial) {
              return MaterialApp(
                title: "cafeteria".tr(context),
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  primarySwatch: AppColors.primarySwatch,
                ),
                home: const LoadingView(),
              );
            } else if (state is ChangeLocaleState) {
              return MaterialApp.router(
                locale: state.locale,
                routerConfig: _appRouter.config(),
                debugShowCheckedModeBanner: false,
                title: "cafeteria".tr(context),
                supportedLocales: const [Locale('en'), Locale('tr')],
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate
                ],
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
            return const NoDataView();
          },
        ));
  }
}
