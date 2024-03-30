import 'package:arkeonil/common/colors.dart';
import 'package:flutter/material.dart';

class AppbarWithTitle extends StatelessWidget {
  const AppbarWithTitle({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context)
          .textTheme
          .headlineLarge
          ?.copyWith(color: whiteColor),
    );
  }
}
