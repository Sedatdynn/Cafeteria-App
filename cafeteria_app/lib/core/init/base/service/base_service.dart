import 'package:dio/dio.dart';

abstract class BaseService<T> {
  final Dio dio;

  BaseService(this.dio);
  Future<T> fetchProductItems(int index);
}
