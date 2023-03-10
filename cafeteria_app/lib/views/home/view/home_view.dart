import 'package:auto_route/auto_route.dart';
import 'package:cafeteria_app/core/theme/theme_color_shelf.dart';
import 'package:cafeteria_app/product/constant/product_const_shelf.dart';
import 'package:cafeteria_app/product/extension/images/jpg_extension.dart';
import 'package:cafeteria_app/product/navigator/app_router.dart';
import 'package:cafeteria_app/product/widget/appBar/custom_appBar.dart';
import 'package:cafeteria_app/product/widget/button/active_button.dart';
import 'package:cafeteria_app/product/widget/textformField/sized_box.dart';
import 'package:cafeteria_app/views/home/home_shelf.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../product/constant/image/const_image.dart';
import '../../../product/enums/imageEnum/image_enums.dart';
import '../../../product/widget/connection/no_connection.dart';
import '../../../product/widget/image/clip_rect_image.dart';
import '../../../product/widget/loading/widget_loading.dart';
import '../../../product/widget/noData/widget_no_data.dart';
import '../../drawer/drawer.dart';
import '../cubit/internetCubit/internet_cubit.dart';

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
        appBar: CustomAppBar(
          isBack: false,
          context: context,
          title: MainTexts.appTitle,
        ),
        drawer: const NavigationDrawerMenu(),
        backgroundColor: AppColors.lightGrey,
        body: BlocListener<InternetCubit, InternetState>(
          listener: (context, state) {
            if (state is InternetConnected) {
              buildInternetConnection(context, state);
            } else if (state is InternetNotConnected) {
              buildNotConnectedDialog(context, state);
            }
          },
          child: BlocBuilder<HomeCubit, HomeState>(
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
      ),
    );
  }

  void buildInternetConnection(BuildContext context, InternetConnected state) {
    ScaffoldMessenger.of(context).showSnackBar(buildConnectedSnackBar(state));
    context.read<HomeCubit>().fetchAllProduct();
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeView(),
        ));
  }

  SnackBar buildConnectedSnackBar(InternetConnected state) =>
      SnackBar(content: Text(state.message));

  Future<dynamic> buildNotConnectedDialog(
      BuildContext context, InternetNotConnected state) {
    return showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(state.message),
        content: Image.asset(
          AppConstantImage.instance.constImagePath,
          height: context.dynamicHeight(0.1),
        ),
        actions: [
          CupertinoDialogAction(
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return const NoConnectionView();
                      },
                    ));
                  },
                  child: const Text(HomeTexts.ok)))
        ],
      ),
    );
  }

  SingleChildScrollView buildMainBody(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: context.midAllPadding,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildDayField(context),
                buildMainTextTitle(),
              ],
            ),
            ConstSpace(height: context.dynamicHeight(0.02)),
            buildTopLunchItems(context),
            ConstSpace(height: context.dynamicHeight(0.03)),
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
                ActiveButton(
                  label: "${context.read<HomeCubit>().totalPay} tl",
                  onPressed: () {},
                ),
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
              ImagePaths.starters.toJpgImage(context),
              HomeTexts.startersText,
              context),
        ),
        InkWell(
          onTap: () {
            context.read<HomeCubit>().changeIndex(1);
          },
          child: buildCategoryCard(
              context.width,
              ImagePaths.starches.toJpgImage(
                context,
              ),
              HomeTexts.starchesText,
              context),
        ),
        InkWell(
            onTap: () {
              context.read<HomeCubit>().changeIndex(2);
            },
            child: buildCategoryCard(
                context.width,
                ImagePaths.meat.toJpgImage(context),
                HomeTexts.meatText,
                context)),
      ],
    );
  }

  buildPaymentButton(BuildContext context) {
    int totalMoney = context.watch<HomeCubit>().totalPay;
    List selectedFood = context.watch<HomeCubit>().isSelectFood;
    List eachFoodPrice = context.watch<HomeCubit>().eachFoodPrice;
    return ActiveButton(
      label: HomeTexts.paymentText,
      onPressed: () {
        context.read<HomeCubit>().totalPay > 0
            ? context.router.navigate(OrderRoute(
                totalMoney: totalMoney,
                isSelectedFood: selectedFood,
                eachFoodPrice: eachFoodPrice))
            : null;
      },
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
                  ClipRectImage(
                    imagePath: items[index]!.fname ??
                        AppConstantImage.instance.constImagePath,
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
      width: context.dynamicWidth(0.28),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadi.midCircular,
            child: image,
          ),
          Text(
            data,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

//TODO custom title field
  Widget buildDayField(BuildContext context) {
    return Text(
      checkDay(),
      style: Theme.of(context)
          .textTheme
          .headlineSmall
          ?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Text buildMainTextTitle() {
    return Text(
      HomeTexts.homeMenuText,
      style: Theme.of(context)
          .textTheme
          .headlineSmall
          ?.copyWith(fontWeight: FontWeight.bold),
    );
  }
}
