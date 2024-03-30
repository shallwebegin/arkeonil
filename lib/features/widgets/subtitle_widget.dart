import 'package:arkeonil/common/colors.dart';
import 'package:arkeonil/common/sizes.dart';
import 'package:flutter/material.dart';

class SubTitleWidget extends StatelessWidget {
  const SubTitleWidget({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: vertical10,
      child: Text(
        title,
        style:
            Theme.of(context).textTheme.titleLarge?.copyWith(color: whiteColor),
      ),
    );
  }
}
