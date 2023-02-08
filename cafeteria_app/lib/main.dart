import 'dart:io';
import 'package:cafeteria_app/core/theme/theme_color_shelf.dart';
import 'package:cafeteria_app/product/constant/product_const_shelf.dart';
import 'package:cafeteria_app/views/home/home_shelf.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'product/navigator/app_router.dart';

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
    return BlocProvider(
        create: (context) {
          return HomeCubit(
              GeneralService(ProjectNetworkManager.instance.service, "EL0E"))
            ..fetchAllProduct();
        },
        child: MaterialApp.router(
          routerDelegate: _appRouter.delegate(),
          routeInformationParser: _appRouter.defaultRouteParser(),
          debugShowCheckedModeBanner: false,
          title: MainTexts.appTitle,
          theme: ThemeData(
            primarySwatch: AppColors.primarySwatch,
          ),
        ));
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
