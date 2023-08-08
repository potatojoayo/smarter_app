import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarter/app/modules/gym/class_payment_module/screens/regular_claim_not_approved_screen.dart';
import 'package:smarter/app/modules/gym/home_module/controllers/gym_home_controller.dart';

import 'new_claim_not_approved_screen.dart';

class NotApprovedClassPaymentScreen extends StatelessWidget {
  const NotApprovedClassPaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox.shrink(),
        leadingWidth: 0,
        title: Obx(
          () => Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Container(
                color: Colors.white,
                child: ToggleButtons(
                  constraints: BoxConstraints(
                    minWidth: (MediaQuery.of(context).size.width - 60) / 2,
                  ),
                  isSelected: GymHomeController.to.isSelectedList,
                  renderBorder: true,
                  borderColor: Colors.grey,
                  borderWidth: 2,
                  borderRadius: BorderRadius.circular(8),
                  selectedBorderColor: Get.theme.primaryColorDark,
                  selectedColor: Get.theme.primaryColorDark,
                  fillColor: Colors.white,
                  splashColor: Colors.white,
                  color: Colors.grey,
                  onPressed: (index) {
                    GymHomeController.to.selectedIndex.value = index;
                    for (int i = 0;
                        i < GymHomeController.to.isSelectedList.length;
                        i++) {
                      index == i
                          ? GymHomeController.to.isSelectedList[i] = true
                          : GymHomeController.to.isSelectedList[i] = false;
                    }
                    GymHomeController.to.isSelectedList.refresh();
                  },
                  children: const [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                      child: Text(
                        '신규청구',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                      child: Text(
                        '정기청구',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: Obx(
        () => GymHomeController.to.selectedIndex.value == 0
            ? const NewClaimNotApprovedScreen()
            : const RegularClaimNotApprovedScreen(),
      ),
    );
  }
}
