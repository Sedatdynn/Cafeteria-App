import 'package:cafeteria_app/core/init/base/service/base_service.dart';
import 'package:dio/dio.dart';

abstract class IHomeService extends BaseService {
  IHomeService(Dio dio) : super(dio);
}
