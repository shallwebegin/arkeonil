import 'package:arkeonil/common/colors.dart';
import 'package:arkeonil/common/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MoreMenuItem extends StatelessWidget {
  const MoreMenuItem({
    super.key,
    required this.onTap,
    required this.title,
    required this.leadingSvg,
  });
  final void Function()? onTap;
  final String title;
  final String leadingSvg;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: vertical5,
        child: Card(
            color: buttonColor,
            child: ListTile(
              leading: SvgPicture.asset(leadingSvg),
              title: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: whiteColor),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_outlined,
                color: whiteColor,
              ),
            )),
      ),
    );
  }
}
