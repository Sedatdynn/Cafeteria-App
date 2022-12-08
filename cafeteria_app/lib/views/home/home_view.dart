import 'package:cafeteria_app/views/home/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../payment/pay_page.dart';
import 'cubit/home_state.dart';
import 'drawer/drawer.dart';
import 'model/items_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final String mainTitle = "Menu Category";
  final String meatImage = "assets/category/meat.jpg";
  final String meatText = "Meat";
  final String startersImage = "assets/category/starters.jpg";
  final String startersText = "Starters";
  final String starchesImage = "assets/category/starches.jpg";
  final String starchesText = "Starches";
  final String labelText = "search for food, cafe, etc.";

  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;
    final double _height = MediaQuery.of(context).size.height;
    // DateFormat('EEEE').format(DateTime.now());

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Cafeteria App',
          ),
        ),
        drawer: const NavigationDrawer(),
        backgroundColor: Colors.grey.shade300,
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading || state is HomeInitial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is HomeLoaded) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildMainTextTitle(),
                          buildSearchTextField(context)
                        ],
                      ),
                      SizedBox(
                        height: _height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              context.read<HomeCubit>().changeIndex(0);
                            },
                            child: buildCategoryCard(
                                _width, startersImage, startersText, context),
                          ),
                          InkWell(
                            onTap: () {
                              context.read<HomeCubit>().changeIndex(1);
                            },
                            child: buildCategoryCard(
                                _width, starchesImage, starchesText, context),
                          ),
                          InkWell(
                              onTap: () {
                                context.read<HomeCubit>().changeIndex(2);
                              },
                              child: buildCategoryCard(
                                  _width, meatImage, meatText, context)),
                        ],
                      ),
                      SizedBox(
                        height: _height * 0.03,
                      ),
                      SizedBox(
                        height: _height * 0.5,
                        child: buildFoodsBody(
                          context,
                          context.watch<HomeCubit>().allProduct,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 100,
                            height: 60,
                            color: Colors.purple,
                            child: Center(
                              child: Text(
                                "${context.watch<HomeCubit>().totalPay} tl",
                                style: const TextStyle(fontSize: 24),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PaymentView(
                                      totalMoney:
                                          context.watch<HomeCubit>().totalPay,
                                      isSelectedFood: context
                                          .watch<HomeCubit>()
                                          .isSelectFood,
                                      eachFoodPrice: context
                                          .watch<HomeCubit>()
                                          .eachFoodPrice),
                                )),
                            child: Container(
                              width: 100,
                              height: 60,
                              color: Colors.purple,
                              child: const Center(
                                child: Text(
                                  "Go to payment tl",
                                  style: TextStyle(fontSize: 24),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            }
            return Text("data");
          },
        ),
      ),
    );
  }

  GridView buildFoodsBody(
    BuildContext context,
    List<Foods?> items,
  ) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        mainAxisExtent: MediaQuery.of(context).size.height * 0.18,
        maxCrossAxisExtent: MediaQuery.of(context).size.height * 0.3,
      ),
      itemCount: 2,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: items[index]!.isSelected! ? Colors.blue : Colors.white,
                borderRadius: BorderRadius.circular(16)),
            // width: width * 0.25,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    "assets/category/starters.jpg",
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      checkSelectFee(items, index, context);
                    },
                    child: Text(items[index]!.fname.toString())),
                Text("${items[index]!.fiyat} tl")
              ],
            ),
          ),
        );
      },
    );
  }

  void checkSelectFee(List<Foods?> items, int index, BuildContext context) {
    return setState(() {
      items[index]!.isSelected = !items[index]!.isSelected!;
      if (items[index]!.isSelected!) {
        context.read<HomeCubit>().isSelectFood.add(items[index]!.fname);
        context.read<HomeCubit>().eachFoodPrice.add(items[index]!.fiyat);
        context.read<HomeCubit>().totalPay += items[index]!.fiyat!;
      } else {
        context.read<HomeCubit>().totalPay -= items[index]!.fiyat!;
      }
    });
  }

  String checkDay() {
    final DateTime now = DateTime.now();
    final String today = DateFormat('EEEEE', 'en_US').format(now);
    return today;
  }

  Container buildCategoryCard(
      double width, String name, String data, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16)),
      width: width * 0.25,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              name,
              height: MediaQuery.of(context).size.height * 0.1,
            ),
          ),
          Text(
            data,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ],
      ),
    );
  }

  SizedBox buildSearchTextField(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.45,
      height: MediaQuery.of(context).size.height * 0.04,
      child: TextField(
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Text buildMainTextTitle() {
    return Text(
      mainTitle,
      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }
}
