import 'package:flutter/material.dart';

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
