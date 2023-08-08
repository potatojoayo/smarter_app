import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/theme/theme.dart';
import 'package:smarter/app/routes/routes.dart';

class GymHomeController extends GetxController
    with GetTickerProviderStateMixin {
  static GymHomeController get to => Get.find();

  late PageController pageController = PageController();
  final scrollController = ScrollController();

  final _currentNavIndex = 0.obs;

  int get currentNavIndex => _currentNavIndex.value;

  set currentNavIndex(value) => _currentNavIndex.value = value;

  late TabController tabController;
  late TabController tabController2;

  final isSelectedList = [true, false].obs;
  final selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
    tabController2 = TabController(length: 2, vsync: this);
  }

  String get currentNavTitle {
    switch (currentNavIndex) {
      case 0:
        return '스케쥴';
      case 1:
        return '원생관리';
      case 2:
        return '원비관리';
      case 3:
        return '알림장';
      default:
        return '마이페이지';
    }
  }

  Widget get currentNavTitleWidget {
    switch (currentNavIndex) {
      case 0:
        return Image.asset(
          'assets/icon/v2_logo.png',
          width: 120,
        );
      case 1:
        return const Text(
          '원생관리',
          style: TextStyle(
              fontSize: 21, color: textColor, fontWeight: FontWeight.w900),
        );
      case 2:
        return const Text('원비관리',
            style: TextStyle(
                fontSize: 21, color: textColor, fontWeight: FontWeight.w900));
      case 3:
        return const Text('알림장',
            style: TextStyle(
                fontSize: 21, color: textColor, fontWeight: FontWeight.w900));
      case 4:
        return const Text(
          '스케쥴',
          style: TextStyle(
              fontSize: 21, color: textColor, fontWeight: FontWeight.w900),
        );
      case 5:
        return const Text(
          '마이페이지',
          style: TextStyle(
              fontSize: 21, color: textColor, fontWeight: FontWeight.w900),
        );
    }

    return Container();
  }

  Widget get currentNavLeading {
    if (currentNavIndex == 0) {
      return IconButton(
        icon: SizedBox(
          height: 50,
          child: Image.asset('assets/icon/gh_icon.png'),
        ),
        onPressed: () {
          Get.offAndToNamed(Routes.shop);
        },
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  changeNavIndex(value) async {
    final prev = currentNavIndex;
    if (currentNavIndex == value) {
      return;
    }
    currentNavIndex = value;

    String route = '/gym/home';
    switch (value) {
      case 0:
        route = Routes.gymHome;
        break;
      case 1:
        route = Routes.gymStudent;
        break;
      case 2:
        route = Routes.gymFee;
        break;
      case 3:
        route = Routes.gymNotice;
        break;
      case 4:
        route = Routes.gymCalendar;
        break;
      case 5:
        route = Routes.gymMyPage;
        break;
    }
    await Get.toNamed(route, id: 2);
    currentNavIndex = prev;
  }
}
