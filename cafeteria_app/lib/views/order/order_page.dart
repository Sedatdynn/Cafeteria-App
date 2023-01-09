import 'dart:math';

import 'package:cafeteria_app/core/const/responsive/responsive.dart';
import 'package:cafeteria_app/core/theme/color/colors.dart';
import 'package:cafeteria_app/product/constant/duration.dart';
import 'package:cafeteria_app/product/constant/warning_message.dart';
import 'package:cafeteria_app/views/home/view/home_view.dart';
import 'package:cafeteria_app/views/payment/payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/const/border/border_radi.dart';
import '../home/cubit/home_cubit.dart';
import '../home/service/items_service.dart';
import '../home/service/network_manager.dart';

class OrderView extends StatefulWidget {
  final totalMoney;
  final List isSelectedFood;
  final List eachFoodPrice;

  const OrderView(
      {Key? key,
      this.totalMoney,
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
      appBar: AppBar(
        title: Text("Total price is: ${widget.totalMoney} tl"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                height: context.dynamicHeight(0.8),
                width: context.width,
                child: ListView.builder(
                    itemCount: widget.isSelectedFood.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(
                            vertical: context.dynamicHeight(0.005)),
                        height: context.dynamicHeight(0.15),
                        width: context.width,
                        decoration: const BoxDecoration(
                            color: AppColors.lightIndigo,
                            borderRadius: BorderRadi.LowCircular),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadi.midCircular,
                              child: Image.asset(
                                "assets/meals/${widget.isSelectedFood[index].toString()}.png",
                                height: context.dynamicHeight(0.1),
                                width: context.dynamicWidth(0.3),
                              ),
                            ),
                            Text(widget.isSelectedFood[index].toString()),
                            Text("${widget.eachFoodPrice[index]} tl"),
                          ],
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: context.dynamicHeight(0.005),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: context.dynamicHeight(0.05),
                    width: context.dynamicWidth(0.4),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        widget.isSelectedFood.length <= 3
                            ? checkEmployee()
                            : warningToast(context,
                                "3'den fazla yemek secmeniz durumunda kredi karti ile odeme yapmalisiniz!");
                        ;
                      },
                      icon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                            Image.asset("assets/button/gunsel.png", height: 30),
                      ),
                      label: const Text('GunselCard'), // <-- Text
                    ),
                  ),
                  SizedBox(
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
                        child:
                            Image.asset("assets/button/card.png", height: 30),
                      ),
                      label: const Text('CreditCard'), // <-- Text
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: context.dynamicHeight(0.01),
              ),
            ],
          ),
        ),
      ),
    );
  }

  checkEmployee() async {
    final random = new Random();
    var values = allEmployees.keys.toList();
    String element = values[random.nextInt(values.length)];
    int freeFoodCount = allEmployees[element] ?? 0;
    print(element);
    print(freeFoodCount);
    if (freeFoodCount > 0) {
      if (widget.isSelectedFood.length <= 3) {
        if (widget.isSelectedFood.contains("Dana eti") &&
            widget.isSelectedFood.contains("Tavuk eti")) {
          await warningToast(context, "Hatali  ET Secimi!!");
        } else if (widget.isSelectedFood.contains("Makarna") &&
            widget.isSelectedFood.contains("Pilav")) {
          await warningToast(context, "Hatali makarna pilav secimi!!");
        } else if (freeFoodCount >= 0) {
          await warningToast(context, "$element odeme islemi basarili.");
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
      await warningToast(context, "$element  yemek hakkin bulunmamaktadir.");
    }
  }
}
