part of 'internet_cubit.dart';

abstract class InternetState {}

class InternetInitial extends InternetState {}

class InternetConnected extends InternetState {
  final String message;

  InternetConnected({required this.message});
}

class InternetNotConnected extends InternetState {
  final String message;

  InternetNotConnected({required this.message});
}
