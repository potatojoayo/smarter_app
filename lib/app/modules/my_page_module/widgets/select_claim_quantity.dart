import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/theme/theme.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/my_page_module/controllers/claim_controller.dart';

class SelectClaimQuantity extends StatelessWidget {
  const SelectClaimQuantity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // DefaultText(
        //   '개수',
        //   style: Get.textTheme.labelLarge,
        // ),
        // const SizedBox(
        //   height: 10,
        // ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 40,
              child: Obx(
                () => Visibility(
                  visible: ClaimController.to.quantity > 0,
                  child: IconButton(
                    onPressed: () => ClaimController.to.quantity -= 1,
                    icon: const FaIcon(
                      FontAwesomeIcons.lightChevronLeft,
                      size: 20,
                      color: textColor,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 50,
              child: Center(
                child: Obx(
                  () => DefaultText(
                    ClaimController.to.quantity.toString(),
                    style: Get.textTheme.bodyLarge,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 40,
              child: IconButton(
                onPressed: () => ClaimController.to.quantity += 1,
                icon: const FaIcon(
                  FontAwesomeIcons.lightChevronRight,
                  size: 20,
                  color: textColor,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
