import 'dart:io';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import '../model/items_model.dart';

abstract class IGeneralService {
  IGeneralService(
    this.dio,
    this.item,
  );
  final Dio dio;
  String item;

  dynamic fetchProductItems(int index);
}

class GeneralService extends IGeneralService {
  GeneralService(
    super.dio,
    super.item,
  );

  @override
  Future<dynamic> fetchProductItems(int index) async {
    final response = await dio.get("/$item");
    if (response.statusCode == HttpStatus.ok) {
      final jsonBody = response.data;
      if (jsonBody is Map<String, dynamic>) {
        final modeldata = ItemsModel.fromJson(jsonBody);
        final DateTime now = DateTime.now();
        String today = DateFormat('EEEEE', 'en_US').format(now);
        final List days = [
          "monday",
          "tuesday",
          "wednesday",
          "thursday",
          "friday"
        ];

        int day_index = days.indexOf(today.toLowerCase());
        final dynamic_contents = modeldata.days![day_index].contents![2].foods;
        final dynamic_day = modeldata.days![day_index].day;

        return modeldata.days![day_index].contents![index].foods;
      }
    }
    throw 'Something went wrong';
  }
}
