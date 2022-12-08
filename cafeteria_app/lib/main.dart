import 'dart:io';

import 'package:cafeteria_app/views/home/cubit/home_cubit.dart';
import 'package:cafeteria_app/views/home/home_view.dart';
import 'package:cafeteria_app/views/home/service/items_service.dart';
import 'package:cafeteria_app/views/home/service/network_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) {
          return HomeCubit(
              GeneralService(ProjectNetworkManager.instance.service, "CWZ7"))
            ..fetchAllProduct();
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter ',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const HomeView(),
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
