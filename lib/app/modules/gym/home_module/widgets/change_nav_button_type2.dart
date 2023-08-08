import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarter/app/modules/auth_module/controllers/auth_controller.dart';
import 'package:smarter/app/modules/gym/home_module/controllers/gym_home_controller.dart';

class ChangeNavButtonType2 extends StatelessWidget {
  const ChangeNavButtonType2({
    super.key,
    required this.navIndex,
    required this.backgroundColor,
    required this.asset,
    required this.assetText,
    required this.description,
  });

  final int navIndex;
  final Color backgroundColor;
  final String asset;
  final String assetText;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            AuthController.to.mixpanel
                .track('GymNavigation', properties: {'index': navIndex});
            GymHomeController.to.changeNavIndex(navIndex);
          },
          child: Container(
            height: 130,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: backgroundColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                      child: Image.asset(assetText),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: 170,
                      child: Text(
                        description,
                        style: Get.theme.textTheme.labelMedium,
                        maxLines: 3,
                        textAlign: TextAlign.start,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  width: 60,
                  child: Image.asset(asset),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
