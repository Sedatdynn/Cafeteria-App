import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/init/cache/cache_manager.dart';
import '../../../core/theme/theme_color_shelf.dart';
import '../../../product/constant/product_const_shelf.dart';
import '../../../product/enums/imageEnum/image_enums.dart';
import '../../../product/extension/images/jpg_extension.dart';
import '../../../product/init/app_localization.dart';
import '../../../product/navigator/app_router.gr.dart';
import '../../../product/widget/text/title_text.dart';
import '../../../product/widget/widgets_shelf.dart';
import '../../drawer/drawer.dart';
import '../cubit/localeCubit/locale_cubit.dart';
import '../home_shelf.dart';

@RoutePage()
class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("cafeteria".tr(context)),
          actions: [
            BlocBuilder<LocaleCubit, LocaleState>(
              builder: (context, state) {
                if (state is ChangeLocaleState) {
                  return DropDownButtonWidget(state, context);
                }
                return const SizedBox();
              },
            )
          ],
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

  DropdownButton<String> DropDownButtonWidget(
      ChangeLocaleState state, BuildContext context) {
    return DropdownButton<String>(
      value: state.locale.languageCode,
      icon: const Icon(Icons.keyboard_arrow_down),
      items: ['tr', 'en'].map((String items) {
        return DropdownMenuItem<String>(
          value: items,
          child: Text(items),
        );
      }).toList(),
      onChanged: (String? newValue) async {
        if (newValue != null) {
          await context.read<LocaleCubit>().changeLanguage(newValue);
        }
      },
    );
  }

  void buildInternetConnection(BuildContext context, InternetConnected state) {
    ScaffoldMessenger.of(context).showSnackBar(buildConnectedSnackBar(state));
    context.read<HomeCubit>().fetchAllProduct();
    context.pushRoute(const HomeRoute());
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
                    context.pushRoute(const NoConnectionRoute());
                  },
                  child: Text("ok".tr(context))))
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
                TitleText(text: "menuCategory".tr(context))
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
              "starters".tr(context),
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
              "starches".tr(context),
              context),
        ),
        InkWell(
            onTap: () {
              context.read<HomeCubit>().changeIndex(2);
            },
            child: buildCategoryCard(
                context.width,
                ImagePaths.meat.toJpgImage(context),
                "meat".tr(context),
                context)),
      ],
    );
  }

  buildPaymentButton(BuildContext context) {
    int totalMoney = context.watch<HomeCubit>().totalPay;
    List selectedFood = context.watch<HomeCubit>().isSelectFood;
    List eachFoodPrice = context.watch<HomeCubit>().eachFoodPrice;
    return ActiveButton(
      label: "payment".tr(context),
      onPressed: () {
        context.read<HomeCubit>().totalPay > 0
            ? context.pushRoute(OrderRoute(
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
                  Text("${items[index]!.price} tl")
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  bool getSelect(String key) {
    bool select = LocaleManager.instance.getBoolValue(key) ?? false;
    return select;
  }

  void checkSelectFee(
      List<Foods?> items, int index, BuildContext context) async {
    correctCheck() async {
      await LocaleManager.instance.setBoolValue(items[index]!.fname!, true);
    }

    falseCheck() async {
      await LocaleManager.instance.setBoolValue(items[index]!.fname!, false);
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
        context.read<HomeCubit>().eachFoodPrice.add(items[index]!.price);
        context.read<HomeCubit>().totalPay += items[index]!.price!;
      } else if (context
          .read<HomeCubit>()
          .isSelectFood
          .contains(items[index]!.fname)) {
        falseCheck();

        final name = items[index]!.fname!;
        context.read<HomeCubit>().isSelectFood.remove(name);
        context.read<HomeCubit>().eachFoodPrice.remove(items[index]!.price);

        context.read<HomeCubit>().totalPay -= items[index]!.price!;
        LocaleManager.instance.removeCacheValue(items[index]!.fname!);
      } else {
        LocaleManager.instance.removeCacheValue(items[index]!.fname!);
      }
    });
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

  Widget buildDayField(BuildContext context) {
    String today = context.watch<HomeCubit>().checkDay();
    return TitleText(text: today);
  }
}
