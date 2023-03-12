part of 'locale_cubit.dart';

@immutable
abstract class LocaleState {}

class LocaleInitial extends LocaleState {}

class ChangeLocaleState extends LocaleState {
  final Locale locale;
  ChangeLocaleState({
    required this.locale,
  });
}
