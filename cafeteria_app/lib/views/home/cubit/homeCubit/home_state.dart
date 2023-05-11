import 'package:equatable/equatable.dart';

import '../../model/items_model.dart';

class HomeState extends Equatable {
  final List<Foods?>? items;
  final String? message;
  final bool? isLoading;
  final int? index;

  const HomeState({
    this.items,
    this.message,
    this.isLoading,
    this.index,
  });

  @override
  List<Object?> get props => [items, message, isLoading, index];

  HomeState copyWith({
    List<Foods?>? items,
    String? message,
    bool? isLoading,
    int? index,
  }) {
    return HomeState(
      items: items ?? this.items,
      message: message ?? this.message,
      isLoading: isLoading ?? this.isLoading,
      index: index ?? this.index,
    );
  }
}
