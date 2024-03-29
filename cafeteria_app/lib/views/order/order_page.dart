import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/theme/theme_color_shelf.dart';
import '../../product/constant/product_const_shelf.dart';
import '../../product/enums/imageEnum/image_enums.dart';
import '../../product/extension/images/png_extension.dart';
import '../../product/init/app_localization.dart';
import '../../product/navigator/app_router.gr.dart';
import '../../product/widget/widgets_shelf.dart';
import '../home/home_shelf.dart';

@RoutePage()
class OrderView extends StatefulWidget {
  final int totalMoney;
  final List isSelectedFood;
  final List eachFoodPrice;

  const OrderView(
      {Key? key,
      required this.totalMoney,
      required this.isSelectedFood,
      required this.eachFoodPrice})
      : super(key: key);
  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  final allEmployees = {
    "Harun": 5,
    "Serge": 1,
    "Can": 10,
    "Hanifi": 9,
    "Mete": 4,
    "Abdul": 6,
    "Moise": 6,
    "Evey": 4,
    "Hemedi": 6,
    "Kevin": 2,
    "Saba": 6,
    "Firat": 4,
    "Mert": 4,
    "Asma": 8,
    "Olusegun": 1,
    "Sedat": 10,
    "Rami": 0,
    "Tuna": 8
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        title: "${"totalPrice".tr(context) + widget.totalMoney.toString()} tl",
      ),
      body: buildBodyField(context),
    );
  }

  Padding buildBodyField(BuildContext context) {
    return Padding(
      padding: context.minAllPadding,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildMainFoodField(context),
            SizedBox(
              height: context.dynamicHeight(0.005),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildGunselButton(context),
                buildCreditCardButton(context),
              ],
            ),
            SizedBox(
              height: context.dynamicHeight(0.01),
            ),
          ],
        ),
      ),
    );
  }

  buildMainFoodField(BuildContext context) {
    return SizedBox(
      height: context.dynamicHeight(0.8),
      width: context.width,
      child: ListView.builder(
          itemCount: widget.isSelectedFood.length,
          itemBuilder: (context, index) {
            return buildFoodInfoField(context, index);
          }),
    );
  }

  Container buildFoodInfoField(BuildContext context, int index) {
    return Container(
      padding: context.midAllPadding,
      margin: context.minVertical,
      height: context.dynamicHeight(0.15),
      width: context.width,
      decoration: const BoxDecoration(
          color: AppColors.lightIndigo, borderRadius: BorderRadi.lowCircular),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRectImage(
              imagePath: widget.isSelectedFood[index] ??
                  AppConstantImage.instance.constImagePath),
          Text(widget.isSelectedFood[index].toString()),
          Text("${widget.eachFoodPrice[index]} tl"),
        ],
      ),
    );
  }

  buildGunselButton(BuildContext context) {
    return CardButton(
        text: "gunselCard".tr(context),
        onPressed: () {
          widget.isSelectedFood.length <= 3
              ? checkEmployee()
              : warningToast(context, "totalPrice".tr(context));
          // : warningToast(context, CheckFoodText.totalFoodControl);
        },
        icon: ImagePaths.gunsel.toPngImage(context));
  }

  buildCreditCardButton(BuildContext context) {
    return CardButton(
        text: "creditCard".tr(context),
        onPressed: () =>
            context.pushRoute(PaymentPageRoute(totalFee: widget.totalMoney)),
        icon: ImagePaths.card.toPngImage(context));
  }

  checkEmployee() async {
    HomeCubit cubit = context.read<HomeCubit>();
    final clearSelectedFood = cubit.isSelectFood.clear();
    final clearEachFoodPrice = cubit.eachFoodPrice.clear();
    final random = Random();
    var values = allEmployees.keys.toList();
    String element = values[random.nextInt(values.length)];
    int freeFoodCount = allEmployees[element] ?? 0;
    if (freeFoodCount > 0) {
      if (widget.isSelectedFood.length <= 3) {
        if (widget.isSelectedFood.contains("veal".tr(context)) &&
            widget.isSelectedFood.contains("chickenMeat".tr(context))) {
          await warningToast(context, "wrongMeat".tr(context));
        } else if (widget.isSelectedFood.contains("pasta".tr(context)) &&
            widget.isSelectedFood.contains("rice".tr(context))) {
          await warningToast(context, "wrongPasta".tr(context));
        } else if (freeFoodCount >= 0) {
          await warningToast(context,
              "$element ${"paySuccess".tr(context) + "remainRight".tr(context) + (freeFoodCount - 1).toString()}");
          Future.delayed(CustomDuration.lowDuration);
          clearSelectedFood;
          clearEachFoodPrice;
          cubit.totalPay = 0;

          if (context.mounted) {
            context.pushRoute(const HomeRoute());
          }
        }
      }
    } else {
      await warningToast(context, element + "noFee".tr(context));
    }
  }
}
