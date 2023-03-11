import 'package:cafeteria_app/core/theme/color/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

warningToast(BuildContext context, String text,
    {Color? color = AppColors.green}) {
  return Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 3,
      backgroundColor: color,
      textColor: AppColors.black,
      fontSize: 16.0);
}
