import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarter/app/modules/gym/class_payment_module/screens/class_payment_screen.dart';
import 'package:smarter/app/modules/gym/class_payment_module/screens/not_approved_class_payment_screen.dart';
import 'package:smarter/app/modules/gym/class_payment_module/screens/payment_statistics_screen.dart';
import 'package:smarter/app/modules/gym/home_module/controllers/gym_home_controller.dart';
import 'package:smarter/app/modules/gym/home_module/widgets/tab_widget.dart';

class GymNavFee extends StatelessWidget {
  const GymNavFee({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: TabBar(
            indicatorColor: Get.theme.primaryColorDark,
            labelColor: Get.theme.primaryColorDark,
            labelStyle: const TextStyle(fontSize: 20),
            unselectedLabelColor: Colors.grey,
            controller: GymHomeController.to.tabController,
            tabs: [
              TabWidget(
                text: '미발송',
                fontWeight: FontWeight.bold,
              ),
              TabWidget(
                text: '수납관리',
                fontWeight: FontWeight.bold,
              ),
              TabWidget(
                text: '수납현황',
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          body: TabBarView(
            controller: GymHomeController.to.tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              NotApprovedClassPaymentScreen(),
              ClassPaymentScreen(),
              PaymentStatisticsScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
