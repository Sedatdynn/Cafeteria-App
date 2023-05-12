import 'package:cafeteria_app/core/init/base/service/base_service.dart';
import 'package:cafeteria_app/views/home/home_shelf.dart';
import 'package:cafeteria_app/views/home/service/i_home_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Fetch foods service test', () async {
    BaseService service = HomeService(ProjectNetworkManager.instance.service);
    final response = await service.fetchProductItems(1);
    expect(response, isNotEmpty);
  });

  test('Datetime day test', () {
    IHomeService service = HomeService(ProjectNetworkManager.instance.service);
    HomeCubit cubit = HomeCubit(service);
    final response = cubit.checkDay();
    expect(response.toLowerCase().toString() == "friday", true);
    expect(response.isNotEmpty, true);
  });
}
