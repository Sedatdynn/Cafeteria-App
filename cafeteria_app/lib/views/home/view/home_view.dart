import 'package:cafeteria_app/core/const/border/border_radi.dart';
import 'package:cafeteria_app/core/const/responsive/responsive.dart';
import 'package:cafeteria_app/core/theme/color/colors.dart';
import 'package:cafeteria_app/views/home/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../order/order_page.dart';
import '../cubit/home_state.dart';
import '../../drawer/drawer.dart';
import '../model/items_model.dart';

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
  SharedPreferences? prefs;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Cafeteria App',
          ),
        ),
        drawer: const NavigationDrawer(),
        backgroundColor: AppColors.lightGrey,
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
                          buildSearchTextField(context),
                          buildMainTextTitle(),
                        ],
                      ),
                      SizedBox(
                        height: context.dynamicHeight(0.02),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              context.read<HomeCubit>().changeIndex(0);
                            },
                            child: buildCategoryCard(context.width,
                                startersImage, startersText, context),
                          ),
                          InkWell(
                            onTap: () {
                              context.read<HomeCubit>().changeIndex(1);
                            },
                            child: buildCategoryCard(context.width,
                                starchesImage, starchesText, context),
                          ),
                          InkWell(
                              onTap: () {
                                context.read<HomeCubit>().changeIndex(2);
                              },
                              child: buildCategoryCard(
                                  context.width, meatImage, meatText, context)),
                        ],
                      ),
                      SizedBox(
                        height: context.dynamicHeight(0.03),
                      ),
                      SizedBox(
                        height: context.dynamicHeight(0.5),
                        child: buildFoodsBody(
                          context,
                          context.watch<HomeCubit>().allProduct,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                                color: AppColors.mainPrimary,
                                borderRadius: BorderRadi.LowCircular),
                            width: 100,
                            height: 60,
                            child: Center(
                              child: Text(
                                "${context.watch<HomeCubit>().totalPay} tl",
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => context.read<HomeCubit>().totalPay > 0
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => OrderView(
                                          totalMoney: context
                                              .watch<HomeCubit>()
                                              .totalPay,
                                          isSelectedFood: context
                                              .watch<HomeCubit>()
                                              .isSelectFood,
                                          eachFoodPrice: context
                                              .watch<HomeCubit>()
                                              .eachFoodPrice),
                                    ))
                                : null,
                            child: Container(
                              padding: context.minAllPadding,
                              decoration: const BoxDecoration(
                                  color: AppColors.mainPrimary,
                                  borderRadius: BorderRadi.LowCircular),
                              height: 60,
                              child: Center(
                                child: Text(
                                  "Payment",
                                  style: Theme.of(context).textTheme.headline5,
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
            return const Text("data");
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
        mainAxisExtent: context.dynamicHeight(0.18),
        maxCrossAxisExtent: context.dynamicHeight(0.3),
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.error,
            borderRadius: BorderRadi.LowCircular,
          ),
          child: InkWell(
            onTap: () async {
              prefs = await SharedPreferences.getInstance();

              checkSelectFee(items, index, context);
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: (prefs?.getBool(items[index]!.fname!) ?? false)
                      ? AppColors.lightIndigo
                      : AppColors.white,
                  borderRadius: BorderRadi.midCircular),
              // width: width * 0.25,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadi.midCircular,
                    child: Image.asset(
                      "assets/meals/${items[index]!.fname}.png",
                      height: context.dynamicHeight(0.1),
                      width: context.dynamicWidth(0.3),
                    ),
                  ),
                  Text(items[index]!.fname.toString()),
                  Text("${items[index]!.fiyat} tl")
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void checkSelectFee(
      List<Foods?> items, int index, BuildContext context) async {
    prefs = await SharedPreferences.getInstance();

    correctCheck() async {
      await prefs?.setBool(items[index]!.fname!, true);
    }

    falseCheck() async {
      await prefs?.setBool(items[index]!.fname!, false);
    }

    return setState(() {
      items[index]!.isSelected = !items[index]!.isSelected!;

      if (items[index]!.isSelected! &&
          !context
              .read<HomeCubit>()
              .isSelectFood
              .contains(items[index]!.fname)) {
        correctCheck();
        context.read<HomeCubit>().isSelectFood.add(items[index]!.fname);
        context.read<HomeCubit>().eachFoodPrice.add(items[index]!.fiyat);
        context.read<HomeCubit>().totalPay += items[index]!.fiyat!;
      } else if (context
          .read<HomeCubit>()
          .isSelectFood
          .contains(items[index]!.fname)) {
        falseCheck();

        final name = items[index]!.fname!;
        context.read<HomeCubit>().isSelectFood.remove(name);
        context.read<HomeCubit>().eachFoodPrice.remove(items[index]!.fiyat);

        context.read<HomeCubit>().totalPay -= items[index]!.fiyat!;
        prefs!.remove(items[index]!.fname!);
      } else {
        prefs!.remove(items[index]!.fname!);
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
      decoration: const BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadi.midCircular),
      width: width * 0.28,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadi.midCircular,
            child: Image.asset(
              name,
              height: context.dynamicHeight(0.1),
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

  Widget buildSearchTextField(BuildContext context) {
    return Text(
      checkDay(),
      style: Theme.of(context)
          .textTheme
          .headline5
          ?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Text buildMainTextTitle() {
    return Text(
      mainTitle,
      style: Theme.of(context)
          .textTheme
          .headline5
          ?.copyWith(fontWeight: FontWeight.bold),
    );
  }
}
