import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/widgets/text.dart';

class PurchaseButton extends StatelessWidget {
  const PurchaseButton({
    Key? key,
    required this.onPressed,
    required this.title,
    required this.iconData,
  }) : super(key: key);

  final void Function() onPressed;
  final String title;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Get.theme.primaryColorDark,
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DefaultText(title,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(
            width: 10,
          ),
          FaIcon(
            iconData,
            size: 15,
          ),
        ],
      ),
    );
  }
}
