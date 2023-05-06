import 'package:cafeteria_app/product/constant/app/app_constant.dart';
import 'package:dio/dio.dart';

class ProjectNetworkManager with AppConstants {
  ProjectNetworkManager._() {
    _dio = Dio(BaseOptions(baseUrl: baseUrl));
  }
  late final Dio _dio;

  static ProjectNetworkManager instance = ProjectNetworkManager._();

  Dio get service => _dio;
}
