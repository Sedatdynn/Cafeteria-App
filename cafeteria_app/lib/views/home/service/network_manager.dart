import 'package:dio/dio.dart';

class ProjectNetworkManager {
  ProjectNetworkManager._() {
    _dio = Dio(BaseOptions(baseUrl: "https://api.jsonserve.com"));
  }
  late final Dio _dio;

  static ProjectNetworkManager instance = ProjectNetworkManager._();

  Dio get service => _dio;
}
