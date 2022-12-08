import 'package:cafeteria_app/views/home/home_view.dart';
import 'package:flutter/material.dart';

class NavigationDrawer extends StatelessWidget {
  final EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 20);

  const NavigationDrawer({
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
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            buildMenuItem(
              text: "Home",
              icon: Icons.home,
              onClicked: () => selectedItem(context, 0),
            ),
            buildMenuItem(
              text: "History",
              icon: Icons.history,
            ),
            buildMenuItem(
              text: "Settings",
              icon: Icons.settings,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
            ),
            const Divider(
              color: Colors.purple,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            buildMenuItem(
              text: "Log out",
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
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeView(),
          ));
      break;
    default:
  }
}

buildMenuItem(
    {required String text, required IconData icon, VoidCallback? onClicked}) {
  const color = Colors.purple;
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
