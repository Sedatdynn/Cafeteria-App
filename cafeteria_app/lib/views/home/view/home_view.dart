import 'package:auto_route/auto_route.dart';
import 'package:cafeteria_app/core/const/border_responsive_shelf.dart';
import 'package:cafeteria_app/core/theme/theme_color_shelf.dart';
import 'package:cafeteria_app/product/constant/product_const_shelf.dart';
import 'package:cafeteria_app/product/navigator/app_router.dart';
import 'package:cafeteria_app/views/home/home_shelf.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/widget/loading/widget_loading.dart';
import '../../../core/widget/noData/widget_no_data.dart';
import '../../drawer/drawer.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  SharedPreferences? prefs;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: buildCustomAppBar(),
        drawer: const NavigationDrawer(),
        backgroundColor: AppColors.lightGrey,
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading || state is HomeInitial) {
              return const LoadingView();
            } else if (state is HomeLoaded) {
              return buildMainBody(context);
            }
            return const NoDataView();
          },
        ),
      ),
    );
  }

  AppBar buildCustomAppBar() {
    return AppBar(
      centerTitle: true,
      title: const Text(
        MainTexts.appTitle,
      ),
    );
  }

  SingleChildScrollView buildMainBody(BuildContext context) {
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
            buildTopLunchItems(context),
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
                buildPriceButton(context),
                buildPaymentButton(context),
              ],
            )
          ],
        ),
      ),
    );
  }

  Row buildTopLunchItems(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            context.read<HomeCubit>().changeIndex(0);
          },
          child: buildCategoryCard(
              context.width,
              ImagePaths.starters.startersToWidget(context.dynamicHeight(0.1)),
              HomeTexts.startersText,
              context),
        ),
        InkWell(
          onTap: () {
            context.read<HomeCubit>().changeIndex(1);
          },
          child: buildCategoryCard(
              context.width,
              ImagePaths.starches.starchesToWidget(context.dynamicHeight(0.1)),
              HomeTexts.starchesText,
              context),
        ),
        InkWell(
            onTap: () {
              context.read<HomeCubit>().changeIndex(2);
            },
            child: buildCategoryCard(
                context.width,
                ImagePaths.meat.meatToWidget(context.dynamicHeight(0.1)),
                HomeTexts.meatText,
                context)),
      ],
    );
  }

  Container buildPriceButton(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: AppColors.mainPrimary, borderRadius: BorderRadi.lowCircular),
      width: 100,
      height: 60,
      child: Center(
        child: Text(
          "${context.read<HomeCubit>().totalPay} tl",
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
    );
  }

  InkWell buildPaymentButton(BuildContext context) {
    int totalMoney = context.watch<HomeCubit>().totalPay;
    List selectedFood = context.watch<HomeCubit>().isSelectFood;
    List eachFoodPrice = context.watch<HomeCubit>().eachFoodPrice;
    return InkWell(
      onTap: () => context.read<HomeCubit>().totalPay > 0
          ? context.router.navigate(OrderRoute(
              totalMoney: totalMoney,
              isSelectedFood: selectedFood,
              eachFoodPrice: eachFoodPrice))
          : null,
      child: Container(
        padding: context.minAllPadding,
        decoration: const BoxDecoration(
            color: AppColors.mainPrimary, borderRadius: BorderRadi.lowCircular),
        height: 60,
        child: Center(
          child: Text(
            HomeTexts.paymentText,
            style: Theme.of(context).textTheme.headline5,
          ),
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
            borderRadius: BorderRadi.lowCircular,
          ),
          child: InkWell(
            onTap: () async {
              prefs = await SharedPreferences.getInstance();

              checkSelectFee(items, index, context);
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: getSelect(items[index]!.fname!)
                      ? AppColors.lightIndigo
                      : AppColors.white,
                  borderRadius: BorderRadi.midCircular),
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

  bool getSelect(String key) {
    bool select = prefs?.getBool(key) ?? false;
    return select;
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
      double width, Widget image, String data, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadi.midCircular),
      width: width * 0.28,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadi.midCircular,
            child: image,
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
      HomeTexts.homeMenuText,
      style: Theme.of(context)
          .textTheme
          .headline5
          ?.copyWith(fontWeight: FontWeight.bold),
    );
  }
}

enum ImagePaths { starters, meat, starches }

extension ImagePathExtension on ImagePaths {
  String startersPath() {
    return "assets/category/${ImagePaths.starters.name}.jpg";
  }

  String meatPath() {
    return "assets/category/${ImagePaths.meat.name}.jpg";
  }

  String starchesPath() {
    return "assets/category/${ImagePaths.meat.name}.jpg";
  }

  Widget startersToWidget(
    double height,
  ) {
    return Image.asset(
      startersPath(),
      height: height,
    );
  }

  Widget meatToWidget(double height) {
    return Image.asset(
      meatPath(),
      height: height,
    );
  }

  Widget starchesToWidget(double height) {
    return Image.asset(
      starchesPath(),
      height: height,
    );
  }
}
