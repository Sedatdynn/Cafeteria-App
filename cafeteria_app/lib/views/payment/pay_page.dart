import 'package:flutter/material.dart';

class PaymentView extends StatefulWidget {
  final totalMoney;
  final List isSelectedFood;
  final List eachFoodPrice;

  const PaymentView(
      {Key? key,
      this.totalMoney,
      required this.isSelectedFood,
      required this.eachFoodPrice})
      : super(key: key);
  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  TextEditingController _controller = TextEditingController();
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
                height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    itemCount: widget.isSelectedFood.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(12)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(widget.isSelectedFood[index].toString()),
                            Text(
                                widget.eachFoodPrice[index].toString() + " tl"),
                          ],
                        ),
                      );
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: Image.asset("assets/category/meat.jpg", height: 30),
                      label: Text('GunselCard'), // <-- Text
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: Image.asset("assets/category/meat.jpg", height: 30),
                      label: Text('CreditCard'), // <-- Text
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
