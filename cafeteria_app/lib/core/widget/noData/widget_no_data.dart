import 'package:cafeteria_app/product/constant/product_const_shelf.dart';
import 'package:flutter/material.dart';

class NoDataView extends StatelessWidget {
  const NoDataView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text(ErrorTexts.wrongText));
  }
}
