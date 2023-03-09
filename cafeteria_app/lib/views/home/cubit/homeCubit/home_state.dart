// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cafeteria_app/views/home/model/items_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Foods?> items;
  final int index;
  HomeLoaded(
    this.items,
    this.index,
  );
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}
