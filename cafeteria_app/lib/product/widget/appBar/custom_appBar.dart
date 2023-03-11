import '../../../core/theme/color/colors.dart';
import '../../constant/product_const_shelf.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final BuildContext context;
  final String title;
  final bool? isBack;
  const CustomAppBar(
      {super.key, required this.context, required this.title, this.isBack});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      backgroundColor: AppColors.mainPrimary,
      centerTitle: true,
      leading: (isBack ?? true)
          ? IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_left_outlined,
                color: AppColors.white,
                size: context.dynamicHeight(0.04),
              ))
          : null,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(context.dynamicHeight(0.07));
}
