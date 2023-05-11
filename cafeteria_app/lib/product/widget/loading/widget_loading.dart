import 'package:auto_route/auto_route.dart';
import 'package:cafeteria_app/core/theme/color/colors.dart';
import 'package:flutter/material.dart';

@RoutePage()
class LoadingView extends StatelessWidget {
  const LoadingView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.mainPrimary,
      ),
    );
  }
}
