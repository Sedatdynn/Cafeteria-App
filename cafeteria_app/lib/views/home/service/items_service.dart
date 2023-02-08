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
        final modelData = ItemsModel.fromJson(jsonBody);
        final DateTime now = DateTime.now();
        String today = DateFormat('EEEEE', 'en_US').format(now);
        final List days = [
          "monday",
          "tuesday",
          "wednesday",
          "thursday",
          "friday"
        ];

        int dayIndex = days.indexOf(today.toLowerCase());
        return modelData.days![dayIndex].contents![index].foods;
      }
    }
    throw 'Something went wrong';
  }
}
