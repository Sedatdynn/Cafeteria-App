part of 'internet_cubit.dart';

class InternetState extends Equatable {
  const InternetState({this.message, this.isConnect});
  final String? message;
  final bool? isConnect;

  @override
  List<Object?> get props => [message, isConnect];

  InternetState copyWith({
    String? message,
    bool? isConnect,
  }) {
    return InternetState(
      message: message ?? this.message,
      isConnect: isConnect ?? this.isConnect,
    );
  }
}
