import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../product/constant/product_const_shelf.dart';
import '../../product/widget/widgets_shelf.dart';
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
  TextEditingController cvcController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        title: MainTexts.appTitle,
      ),
      body: buildMainBody(context),
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
            ConstSpace(height: context.dynamicHeight(0.1)),
            const TextFormTitle(PaymentTexts.cardNumber),
            const ConstSpace(),
            buildCardNumberTextformField(),
            SizedBox(
              height: context.dynamicHeight(0.03),
            ),
            const TextFormTitle(PaymentTexts.dateText),
            const ConstSpace(),
            buildDateTextformField(),
            SizedBox(
              height: context.dynamicHeight(0.03),
            ),
            const TextFormTitle(PaymentTexts.securityCode),
            const ConstSpace(),
            buildCvcTextformField(),
            const ConstSpace(),
            buildButton(context)
          ],
        ),
      ),
    );
  }

  Text buildTitleText(BuildContext context) {
    return Text(
      " Total Price:  ${widget.totalFee.toString()} tl  ",
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }

  buildCardNumberTextformField() {
    return PaymentTextField(
        controller: cardController,
        validator: (p0) {},
        maxLength: 16,
        keyboardType: TextInputType.number,
        mainIcon: Icons.credit_card_outlined,
        labelText: PaymentTexts.cardNumber);
  }

  buildDateTextformField() {
    return PaymentTextField(
      controller: dateController,
      validator: (p0) {},
      maxLength: 5,
      keyboardType: TextInputType.datetime,
      labelText: PaymentTexts.mmyyText,
      mainIcon: Icons.date_range,
    );
  }

  buildCvcTextformField() {
    return PaymentTextField(
        controller: cvcController,
        validator: (p0) {},
        maxLength: 3,
        keyboardType: TextInputType.number,
        mainIcon: Icons.security_outlined,
        labelText: PaymentTexts.cvcText);
  }

  buildButton(BuildContext context) {
    return Center(
      child: ActiveButton(
        width: context.dynamicWidth(0.7),
        label: PaymentTexts.payComplete,
        onPressed: () {
          warningToast(context, PaymentTexts.paySuccess);
          Future.delayed(CustomDuration.lowDuration);
          context.read<HomeCubit>().isSelectFood.clear();
          context.read<HomeCubit>().eachFoodPrice.clear();
          context.read<HomeCubit>().totalPay = 0;
          context.router.pushNamed('/home');
        },
      ),
    );
  }
}
