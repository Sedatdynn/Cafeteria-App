import 'package:auto_route/auto_route.dart';
import 'package:cafeteria_app/product/constant/responsive/responsive.dart';
import 'package:cafeteria_app/core/theme/color/colors.dart';
import 'package:cafeteria_app/product/init/app_localization.dart';
import 'package:flutter/material.dart';

class NavigationDrawerMenu extends StatelessWidget {
  final EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 20);

  const NavigationDrawerMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Theme.of(context).focusColor,
        child: ListView(
          padding: padding,
          children: [
            SizedBox(
              height: context.dynamicHeight(0.04),
            ),
            buildMenuItem(
              text: "home".tr(context),
              icon: Icons.home,
              onClicked: () => selectedItem(context, 0),
            ),
            buildMenuItem(
              text: "history".tr(context),
              icon: Icons.history,
            ),
            buildMenuItem(text: "settings".tr(context), icon: Icons.settings),
            SizedBox(
              height: context.dynamicHeight(0.3),
            ),
            const Divider(
              color: AppColors.divider,
            ),
            SizedBox(
              height: context.dynamicHeight(0.05),
            ),
            buildMenuItem(
              text: "logOut".tr(context),
              icon: Icons.logout,
            ),
          ],
        ),
      ),
    );
  }
}

void selectedItem(BuildContext context, int index) {
  switch (index) {
    case 0:
      context.router.popUntilRouteWithName('HomeRoute');

      break;
    default:
  }
}

buildMenuItem(
    {required String text, required IconData icon, VoidCallback? onClicked}) {
  const color = AppColors.indigo;
  return ListTile(
    leading: Icon(
      icon,
      color: color,
    ),
    title: Text(
      text,
      style: const TextStyle(color: color),
    ),
    onTap: onClicked,
  );
}
