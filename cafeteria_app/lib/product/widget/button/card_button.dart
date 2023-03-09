import 'package:cafeteria_app/product/constant/product_const_shelf.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/color/colors.dart';
import '../../constant/border/shape_border.dart';

class CardButton extends StatelessWidget {
  const CardButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.width,
      this.height,
      required this.icon});
  final String text;
  final double? width;
  final double? height;
  final Widget icon;

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? context.dynamicWidth(0.4),
      height: context.dynamicHeight(0.06),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: ShapedBorders.roundedLow,
          padding: context.minAllPadding,
          backgroundColor: AppColors.mainPrimary,
        ),
        label: Text(text,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: onPressed == null
                      ? AppColors.mainPrimary.withOpacity(0.5)
                      : AppColors.white,
                )),
        icon: icon,
      ),
    );
  }
}
