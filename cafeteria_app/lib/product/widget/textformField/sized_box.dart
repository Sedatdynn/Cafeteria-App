import 'package:cafeteria_app/product/constant/product_const_shelf.dart';
import 'package:flutter/material.dart';

class ConstSpace extends StatelessWidget {
  final double? height;
  const ConstSpace({
    super.key,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? context.dynamicHeight(0.01),
      width: context.dynamicWidth(0.01),
    );
  }
}
