import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/widgets/text.dart';

class MenuListItem extends StatelessWidget {
  const MenuListItem({
    Key? key,
    required this.iconData,
    required this.name,
    required this.onPressed,
  }) : super(key: key);
  final IconData iconData;
  final String name;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 15),
        child: Row(
          children: [
            SizedBox(
              width: 30,
              child: FaIcon(
                iconData,
                size: 20,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            DefaultText(
              name,
              style: Get.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
