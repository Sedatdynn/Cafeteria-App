import 'package:cafeteria_app/product/init/app_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/color/colors.dart';
import '../../loading/widget_loading.dart';

class LoadingMaterial extends StatelessWidget {
  const LoadingMaterial({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "cafeteria".tr(context),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: AppColors.primarySwatch,
      ),
      home: const LoadingView(),
    );
  }
}
