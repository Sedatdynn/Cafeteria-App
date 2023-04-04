import 'package:auto_route/auto_route.dart';
import 'package:cafeteria_app/product/init/app_localization.dart';
import 'package:flutter/material.dart';

@RoutePage()
class NoDataView extends StatelessWidget {
  const NoDataView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("wrongText".tr(context)));
  }
}
