import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/init/provider/bloc_provider_list.dart';
import 'product/navigator/app_router.dart';
import 'product/widget/materialApp/materialLoaded/material_loaded.dart';
import 'product/widget/materialApp/loadingMaterial/loading_material.dart';
import 'product/widget/widgets_shelf.dart';
import 'views/home/cubit/localeCubit/locale_cubit.dart';

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
        providers: ProviderList.instance.providerList,
        child: BlocBuilder<LocaleCubit, LocaleState>(
          builder: (context, state) {
            if (state is LocaleInitial) {
              return const LoadingMaterial();
            } else if (state is ChangeLocaleState) {
              return MaterialLoaded(state: state, appRouter: _appRouter);
            }
            return const NoDataView();
          },
        ));
  }
}
