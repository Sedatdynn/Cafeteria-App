import 'package:cafeteria_app/product/constant/product_const_shelf.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/color/colors.dart';
import '../../constant/border/shape_border.dart';

class ActiveButton extends StatelessWidget {
  const ActiveButton(
      {super.key, required this.label, required this.onPressed, this.width});
  final String label;
  final double? width;

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? context.dynamicWidth(0.4),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: ShapedBorders.roundedLow,
          padding: context.midAllPadding,
          backgroundColor: AppColors.mainPrimary,
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w500,
                color: onPressed == null
                    ? AppColors.mainPrimary.withOpacity(0.5)
                    : AppColors.white,
              ),
        ),
      ),
    );
  }
}
