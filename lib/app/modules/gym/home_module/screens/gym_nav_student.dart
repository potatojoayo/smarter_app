import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarter/app/modules/gym/home_module/widgets/tab_widget.dart';
import 'package:smarter/app/modules/gym/student_module/screens/attendance_class_screen.dart';
import 'package:smarter/app/modules/gym/student_module/screens/audition_screen.dart';
import 'package:smarter/app/modules/gym/student_module/screens/statistics_screen.dart';
import 'package:smarter/app/modules/gym/student_module/screens/student_screen.dart';

class GymNavStudent extends StatelessWidget {
  const GymNavStudent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: TabBar(
            indicatorColor: Get.theme.primaryColorDark,
            labelColor: Get.theme.primaryColorDark,
            labelStyle: const TextStyle(fontSize: 16),
            unselectedLabelColor: Colors.grey,
            tabs: [
              TabWidget(
                text: '원생관리',
              ),
              TabWidget(
                text: '승급관리',
              ),
              TabWidget(
                text: '출결관리',
              ),
              TabWidget(
                text: '   통계   ',
              ),
            ],
          ),
          body: const TabBarView(
            children: [
              StudentScreen(),
              AuditionScreen(),
              AttendanceClassScreen(),
              StatisticScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
