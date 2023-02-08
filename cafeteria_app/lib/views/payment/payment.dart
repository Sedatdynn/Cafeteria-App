import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cafeteria_app/core/const/border_responsive_shelf.dart';
import 'package:cafeteria_app/core/theme/theme_color_shelf.dart';
import '../../product/constant/product_const_shelf.dart';
import '../home/home_shelf.dart';

class PaymentPageView extends StatefulWidget {
  int totalFee = 0;
  PaymentPageView({
    Key? key,
    required this.totalFee,
  }) : super(key: key);
  @override
  State<PaymentPageView> createState() => _PaymentPageViewState();
}

class _PaymentPageViewState extends State<PaymentPageView> {
  TextEditingController cardController = TextEditingController();
  TextEditingController cvcContoller = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(),
      body: buildMainBody(context),
    );
  }

  AppBar buildCustomAppBar() {
    return AppBar(
      backgroundColor: AppColors.mainPrimary,
      title: const Text(MainTexts.appTitle),
    );
  }

  Padding buildMainBody(BuildContext context) {
    return Padding(
      padding: context.midAllPadding,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: buildTitleText(context),
            ),
            SizedBox(
              height: context.dynamicHeight(0.1),
            ),
            buildCardInfoText(context),
            SizedBox(
              height: context.dynamicHeight(0.01),
            ),
            buildCardNumberTextformField(),
            SizedBox(
              height: context.dynamicHeight(0.03),
            ),
            buildDateTextformField(),
            SizedBox(
              height: context.dynamicHeight(0.03),
            ),
            buildCvcTextformField(),
            SizedBox(
              height: context.dynamicHeight(0.03),
            ),
            buildButton(context)
          ],
        ),
      ),
    );
  }

  Text buildTitleText(BuildContext context) {
    return Text(
      " Total Price:  ${widget.totalFee.toString()} tl  ",
      style: Theme.of(context).textTheme.headline4,
    );
  }

  Text buildCardInfoText(BuildContext context) {
    return Text(
      PaymentTexts.cardInfo,
      style: Theme.of(context).textTheme.bodyLarge,
    );
  }

  TextFormField buildCardNumberTextformField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      ],
      maxLength: 16,
      controller: cardController,
      decoration: const InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadi.midCircular,
          ),
          labelText: PaymentTexts.cardNumber),
    );
  }

  TextFormField buildDateTextformField() {
    return TextFormField(
      maxLength: 5,
      keyboardType: TextInputType.datetime,
      controller: dateController,
      decoration: const InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadi.midCircular,
          ),
          labelText: PaymentTexts.mmyyText),
    );
  }

  TextFormField buildCvcTextformField() {
    return TextFormField(
      maxLength: 3,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      ],
      controller: cvcContoller,
      decoration: const InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadi.midCircular,
          ),
          labelText: PaymentTexts.cvcText),
    );
  }

  Center buildButton(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          warningToast(context, PaymentTexts.paySuccess);
          Future.delayed(CustomDuration.lowDuration);
          context.read<HomeCubit>().isSelectFood.clear();
          context.read<HomeCubit>().eachFoodPrice.clear();
          context.read<HomeCubit>().totalPay = 0;
          context.router.popUntilRouteWithName('HomeRoute');
        },
        child: Container(
          padding: context.minAllPadding,
          decoration: const BoxDecoration(
              color: AppColors.mainPrimary,
              borderRadius: BorderRadi.midCircular),
          height: context.dynamicHeight(0.08),
          width: context.dynamicWidth(0.6),
          child: Center(
            child: Text(
              PaymentTexts.payComplete,
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                  color: AppColors.black, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
