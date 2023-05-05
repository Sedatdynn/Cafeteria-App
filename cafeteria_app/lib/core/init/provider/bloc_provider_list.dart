import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../views/home/cubit/homeCubit/home_cubit.dart';
import '../../../views/home/cubit/internetCubit/internet_cubit.dart';
import '../../../views/home/cubit/localeCubit/locale_cubit.dart';
import '../../../views/home/service/items_service.dart';
import '../../../views/home/service/network_manager.dart';

class ProviderList {
  static get providers => [
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
      ];
}
