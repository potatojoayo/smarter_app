import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/utils/day.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/gym/student_module/quries/attendance_masters_query.dart';
import 'package:smarter/app/routes/routes.dart';

class AttendanceMasterScreen extends StatelessWidget {
  const AttendanceMasterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: DefaultText(
          '출결관리',
          style: Get.textTheme.bodySmall,
        ),
        titleSpacing: 0,
        centerTitle: false,
      ),
      body: AttendanceMastersQuery(
        classMasterId: Get.parameters['id']!,
        builder: (attendanceMasters, totalCount, hasNextPage, endCursor,
            refetch, fetchMore, options) {
          if (kDebugMode) {
            print(attendanceMasters);
          }
          return NotificationListener<ScrollEndNotification>(
            onNotification: (t) {
              final metrics = t.metrics;
              if (metrics.atEdge) {
                bool isTop = metrics.pixels == 0;
                if (!isTop && hasNextPage) {
                  fetchMore!(options);
                }
              }
              return true;
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (_, index) {
                      if (index < attendanceMasters.length) {
                        final attendanceMaster = attendanceMasters[index];
                        final date = DateTime.parse(attendanceMaster['date']);
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed(
                                '${Routes.attendanceDetail}/${attendanceMaster['id']}');
                          },
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black12,
                                    offset: Offset(1, 1),
                                    blurRadius: 6)
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    DefaultText(
                                      date.year.toString(),
                                      style: Get.textTheme.labelMedium,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    date.day > 9
                                        ? DefaultText(
                                            '${date.month}/${date.day}',
                                            style: Get.textTheme.bodySmall,
                                          )
                                        : DefaultText(
                                            '${date.month}/0${date.day.toString()}',
                                            style: Get.textTheme.bodySmall,
                                          )
                                  ],
                                ),
                                DefaultText(
                                  getDay(date.weekday - 1),
                                  style: Get.textTheme.bodySmall,
                                ),
                                DefaultText(
                                  '${attendanceMaster['classDetail']['hourStart']}:${attendanceMaster['classDetail']['minStart'].toString().padLeft(2, '0')}',
                                  style: Get.textTheme.bodySmall,
                                ),
                                DefaultText(
                                  '~',
                                  style: Get.textTheme.bodySmall,
                                ),
                                DefaultText(
                                  '${attendanceMaster['classDetail']['hourEnd']}:${attendanceMaster['classDetail']['minEnd'].toString().padLeft(2, '0')}',
                                  style: Get.textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      if (hasNextPage) {
                        return SpinKitChasingDots(
                          color: Get.theme.primaryColorDark,
                        );
                      }
                      return Container();
                    },
                    separatorBuilder: (_, __) => const SizedBox(
                          height: 10,
                        ),
                    itemCount: attendanceMasters.length + 1),
              ),
            ),
          );
        },
      ),
    );
  }
}
