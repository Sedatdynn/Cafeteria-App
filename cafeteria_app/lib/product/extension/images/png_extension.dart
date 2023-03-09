import 'package:cafeteria_app/product/constant/product_const_shelf.dart';
import 'package:flutter/material.dart';

import '../../enums/imageEnum/image_enums.dart';

extension ImagePathExtension on ImagePaths {
  String get rawValue => "assets/button/$name.png";

  Widget toPngImage(
    BuildContext context,
  ) {
    return ClipRRect(
      borderRadius: BorderRadi.midCircular,
      child: Image.asset(
        rawValue,
        height: context.dynamicHeight(0.1),
      ),
    );
  }
}
