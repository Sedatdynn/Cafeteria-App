import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class NoConnectionView extends StatelessWidget {
  const NoConnectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("No Internet connection"),
      ),
    );
  }
}
