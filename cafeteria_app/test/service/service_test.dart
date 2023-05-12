import 'package:cafeteria_app/views/home/home_shelf.dart';
import 'package:cafeteria_app/views/home/service/i_home_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late IHomeService service;
  setUp(() {
    service = HomeService(ProjectNetworkManager.instance.service);
  });
  test('Fetch foods service test', () async {
    final response = await service.fetchProductItems(1);
    expect(response, isNotEmpty);
  });

  test('Datetime day test', () {
    HomeCubit cubit = HomeCubit(service);
    final response = cubit.checkDay();
    expect(response.toLowerCase().toString() == "friday", true);
    expect(response.isNotEmpty, true);
  });
}
