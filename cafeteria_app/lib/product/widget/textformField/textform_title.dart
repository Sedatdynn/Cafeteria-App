import 'package:flutter/material.dart';

class TextFormTitle extends StatelessWidget {
  final String title;
  const TextFormTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.bodyLarge,
    );
  }
}
