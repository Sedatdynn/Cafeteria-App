import 'dart:io';
import 'product/init/app_localization.dart';
import 'views/home/cubit/localeCubit/locale_cubit.dart';
import 'package:flutter_bloc/src/bloc_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/theme/theme_color_shelf.dart';
import 'product/navigator/app_router.dart';
import 'product/widget/widgets_shelf.dart';
import 'views/home/home_shelf.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: appProviders,
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
                routerDelegate: _appRouter.delegate(),
                routeInformationParser: _appRouter.defaultRouteParser(),
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

  List<BlocProviderSingleChildWidget> get appProviders {
    return [
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
          return HomeCubit(
              GeneralService(ProjectNetworkManager.instance.service, "QFj-hS"))
            ..fetchAllProduct();
        },
      ),
    ];
  }
}
