import 'package:cafeteria_app/product/constant/product_const_shelf.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/color/colors.dart';

class PaymentTextFieldDecoration extends InputDecoration {
  PaymentTextFieldDecoration(BuildContext context, String labelText,
      IconData? mainIcon, VoidCallback? onPressed)
      : super(
            labelText: labelText,
            contentPadding: context.minAllPadding,
            enabledBorder: focusedBorderStyle(context),
            focusedBorder: focusedBorderStyle(context),
            border: standardBorder(context),
            hintStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppColors.mainPrimary,
                ),
            suffixIcon: IconButton(
              icon: Icon(
                mainIcon,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: onPressed,
            ));

  static OutlineInputBorder focusedBorderStyle(BuildContext context) {
    return OutlineInputBorder(
      borderRadius: borderRadius,
      borderSide: BorderSide(
        color: AppColors.darkGrey.withOpacity(0.5),
        width: context.dynamicWidth(0.004),
      ),
    );
  }

  static OutlineInputBorder standardBorder(BuildContext context) =>
      OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(
          color: AppColors.mainPrimary,
          width: context.dynamicWidth(0.1),
        ),
      );

  static BorderRadius get borderRadius => BorderRadi.lowCircular;
}
