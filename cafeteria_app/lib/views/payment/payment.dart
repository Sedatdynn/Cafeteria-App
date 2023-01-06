import 'package:cafeteria_app/core/const/responsive/responsive.dart';
import 'package:cafeteria_app/views/home/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/const/border/border_radi.dart';
import '../../product/constant/warning_message.dart';
import '../home/cubit/home_cubit.dart';

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
  final String paymentCompletedSuccessfully = 'Payment completed successfully';
  final String completePayment = 'Complete Payment';
  final String cardNumber = 'Card number';
  final String cardInformation = 'Card information';
  final String mmyy = 'MM/YY';
  final String cvc = 'CVC';
  TextEditingController cardController = TextEditingController();
  TextEditingController cvcContoller = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
      ),
      body: Padding(
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
      cardInformation,
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
      decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadi.midCircular,
          ),
          labelText: cardNumber),
    );
  }

  TextFormField buildDateTextformField() {
    return TextFormField(
      maxLength: 5,
      keyboardType: TextInputType.datetime,

      // validator: (value) =>
      //     (value ?? "").length > 3 ? null : "",
      controller: dateController,

      decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadi.midCircular,
          ),
          labelText: "${mmyy} "),
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
      decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadi.midCircular,
          ),
          labelText: cvc),
    );
  }

  Center buildButton(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          warningToast(context, paymentCompletedSuccessfully);
          Future.delayed(const Duration(seconds: 2));
          context.read<HomeCubit>().isSelectFood.clear();
          context.read<HomeCubit>().eachFoodPrice.clear();
          context.read<HomeCubit>().totalPay = 0;
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomeView()),
              (route) => false);
        },
        child: Container(
          padding: context.minAllPadding,
          decoration: const BoxDecoration(
              color: Colors.orange, borderRadius: BorderRadi.midCircular),
          height: context.dynamicHeight(0.08),
          width: context.dynamicWidth(0.6),
          child: Center(
            child: Text(
              completePayment,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
