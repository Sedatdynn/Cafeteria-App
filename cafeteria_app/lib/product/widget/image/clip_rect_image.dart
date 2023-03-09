import 'package:cafeteria_app/product/constant/product_const_shelf.dart';
import 'package:flutter/material.dart';

class ClipRectImage extends StatelessWidget {
  final String imagePath;
  const ClipRectImage({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadi.midCircular,
      child: Image.asset(
        "assets/meals/$imagePath.png",
        height: context.dynamicHeight(0.1),
        width: context.dynamicWidth(0.3),
      ),
    );
  }
}
