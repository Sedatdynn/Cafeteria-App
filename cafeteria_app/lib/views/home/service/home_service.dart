import 'dart:io';
import 'package:cafeteria_app/product/constant/app/app_constant.dart';
import 'package:cafeteria_app/views/home/service/i_home_service.dart';
import 'package:intl/intl.dart';
import '../model/items_model.dart';

class HomeService extends IHomeService with AppConstants {
  HomeService(super.dio);

  @override
  Future<dynamic> fetchProductItems(int index) async {
    try {
      final response = await dio.get(itemValue);
      if (response.statusCode == HttpStatus.ok) {
        final jsonBody = response.data;
        if (jsonBody is Map<String, dynamic>) {
          final modelData = ItemsModel().fromJson(jsonBody);
          final DateTime now = DateTime.now();
          String today = DateFormat('EEEEE', 'en_US').format(now);
          final List days = [
            "Monday",
            "Tuesday",
            "Wednesday",
            "Thursday",
            "Friday"
          ];

          int dayIndex = days.indexOf(today.toLowerCase());
          if (dayIndex >= 0) {
            return modelData.days![dayIndex].contents![index].foods;
          } else {
            return modelData.days![0].contents![index].foods;
          }
        }
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
