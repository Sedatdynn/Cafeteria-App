import 'package:flutter/material.dart';

extension ResponsiveExtension on BuildContext {
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
  double dynamicHeight(double value) => height * value;
  double dynamicWidth(double value) => width * value;
}

extension AllPaddings on BuildContext {
  EdgeInsets get zeroAllPadding => const EdgeInsets.all(0);
  EdgeInsets get minAllPadding => const EdgeInsets.all(8);
  EdgeInsets get midAllPadding => const EdgeInsets.all(16);
}

extension SymetricPadding on BuildContext {
  EdgeInsets get minHorizontal => const EdgeInsets.symmetric(horizontal: 8.0);
  EdgeInsets get minVertical => const EdgeInsets.symmetric(vertical: 8.0);
}
