import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cafeteria_app/views/payment/payment.dart';
import '../../core/theme/theme_color_shelf.dart';
import '../../product/constant/product_const_shelf.dart';
import '../home/home_shelf.dart';
import 'package:cafeteria_app/core/const/border_responsive_shelf.dart';

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
      appBar: buildAppBar(),
      body: buildBodyField(context),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text("Total price is: ${widget.totalMoney} tl"),
    );
  }

  Padding buildBodyField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
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

  Container buildMainFoodField(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
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
      margin: EdgeInsets.symmetric(vertical: context.dynamicHeight(0.005)),
      height: context.dynamicHeight(0.15),
      width: context.width,
      decoration: const BoxDecoration(
          color: AppColors.lightIndigo, borderRadius: BorderRadi.LowCircular),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildEachFoodImage(index, context),
          Text(widget.isSelectedFood[index].toString()),
          Text("${widget.eachFoodPrice[index]} tl"),
        ],
      ),
    );
  }

  ClipRRect buildEachFoodImage(int index, BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadi.midCircular,
      child: Image.asset(
        "assets/meals/${widget.isSelectedFood[index].toString()}.png",
        height: context.dynamicHeight(0.1),
        width: context.dynamicWidth(0.3),
      ),
    );
  }

  SizedBox buildGunselButton(BuildContext context) {
    return SizedBox(
      height: context.dynamicHeight(0.05),
      width: context.dynamicWidth(0.4),
      child: ElevatedButton.icon(
        onPressed: () {
          widget.isSelectedFood.length <= 3
              ? checkEmployee()
              : warningToast(context, CheckFoodText.totalFoodControl);
        },
        icon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ImagePaths.gunsel.cardToWidget()),
        label: const Text(OrderTexts.gunselButtonText),
      ),
    );
  }

  SizedBox buildCreditCardButton(BuildContext context) {
    return SizedBox(
      height: context.dynamicHeight(0.05),
      width: context.dynamicWidth(0.4),
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    PaymentPageView(totalFee: widget.totalMoney),
              ));
        },
        icon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ImagePaths.card.cardToWidget(),
        ),
        label: const Text(OrderTexts.creditButtonText),
      ),
    );
  }

  checkEmployee() async {
    final random = Random();
    var values = allEmployees.keys.toList();
    String element = values[random.nextInt(values.length)];
    int freeFoodCount = allEmployees[element] ?? 0;
    print(element);
    print(freeFoodCount);
    if (freeFoodCount > 0) {
      if (widget.isSelectedFood.length <= 3) {
        if (widget.isSelectedFood.contains(CheckFoodText.danaEti) &&
            widget.isSelectedFood.contains(CheckFoodText.tavukEti)) {
          await warningToast(context, CheckFoodText.hataliEt);
        } else if (widget.isSelectedFood.contains(CheckFoodText.makarna) &&
            widget.isSelectedFood.contains(CheckFoodText.pilav)) {
          await warningToast(context, CheckFoodText.hatalimakarna);
        } else if (freeFoodCount >= 0) {
          await warningToast(
              context,
              element +
                  CheckFoodText.basariliOdeme +
                  "Kalan hak: ${freeFoodCount - 1}");
          Future.delayed(CustomDuration.lowDuration);
          context.read<HomeCubit>().isSelectFood.clear();
          context.read<HomeCubit>().eachFoodPrice.clear();
          context.read<HomeCubit>().totalPay = 0;
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomeView()),
              (route) => false);
        }
      }
    } else {
      await warningToast(context, element + CheckFoodText.gecersiz);
    }
  }
}

enum ImagePaths { gunsel, card }

extension ImagePathExtesion on ImagePaths {
  String gunselPath() {
    return "assets/button/${ImagePaths.gunsel.name}.png";
  }

  String cardPath() {
    return "assets/button/${ImagePaths.card.name}.png";
  }

  Widget gunselToWidget() {
    return Image.asset(gunselPath(), height: 30);
  }

  Widget cardToWidget() {
    return Image.asset(cardPath(), height: 30);
  }
}
