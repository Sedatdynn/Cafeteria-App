import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../../model/items_model.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  StreamSubscription? _subscription;
  InternetCubit() : super(InternetInitial());

  void connected() {
    emit(InternetConnected(message: "Connected"));
  }

  void notConnected() {
    emit(InternetNotConnected(message: "Don't have a connection!"));
  }

  void checkConnection() {
    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile) {
        connected();
      } else {
        notConnected();
      }
    });
  }

  @override
  Future<void> close() {
    _subscription!.cancel();
    return super.close();
  }
}
