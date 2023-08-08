import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/global/theme/theme.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/gym/student_module/controllers/audition_calendar_controller.dart';
import 'package:smarter/app/modules/gym/student_module/controllers/create_audition_controller.dart';
import 'package:smarter/app/modules/gym/student_module/quries/calendar_query.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderBottomSheet extends StatelessWidget {
  const CalenderBottomSheet({Key? key}) : super(key: key);

  @override
  CalendarQuery build(BuildContext context) {
    final now = DateTime.now();
    return CalendarQuery(
      variables: {
        'year': now.year,
        'month': now.month,
      },
      builder:
          (List<Map<String, dynamic>> auditions, absentRequests, notifications, fetchMore) {
        final Map<String, List<dynamic>> events =
            AuditionCalendarController.to.getEvents(auditions, absentRequests, notifications);

        return SingleChildScrollView(
          child: Column(
            children: [
              // 탑 불렁올 날짜를 선택하세요.
              const SizedBox(
                height: 30,
              ),
              Center(
                  child:
                      Text('불러오실 날짜를 선택하세요.', style: Get.textTheme.titleSmall)),
              const SizedBox(
                height: 20,
              ),
              Obx(
                () => TableCalendar(
                  onPageChanged: (date) {
                    AuditionCalendarController.to.focusedDay.value = date;
                    final fetchMoreOption = FetchMoreOptions(
                        variables: {'year': date.year, 'month': date.month},
                        updateQuery: (Map<String, dynamic>? previousResultData,
                            Map<String, dynamic>? fetchMoreResultData) {
                          return fetchMoreResultData;
                        });
                    fetchMore!(fetchMoreOption);
                  },
                  focusedDay: AuditionCalendarController.to.focusedDay.value,
                  onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
                    AuditionCalendarController.to.focusedDay.value = focusedDay;
                    AuditionCalendarController.to.selectedDay.value =
                        selectedDay;
                  },
                  selectedDayPredicate: (day) {
                    return day ==
                        AuditionCalendarController.to.selectedDay.value;
                  },
                  calendarBuilders: CalendarBuilders(
                    singleMarkerBuilder: (_, dateTime, event) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 1.0),
                        child: Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: AuditionCalendarController.to
                                .getColor(event as Event),
                            shape: BoxShape.circle,
                          ),
                        ),
                      );
                    },
                  ),
                  firstDay: DateTime(2022),
                  lastDay: DateTime(DateTime.now().year + 1, 12, 31),
                  locale: 'ko_KR',
                  daysOfWeekHeight: 40,
                  eventLoader: (DateTime dateTime) {
                    return events[
                            '${dateTime.year}${dateTime.month}${dateTime.day}'] ??
                        [];
                  },
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                    rightChevronIcon: FaIcon(
                      FontAwesomeIcons.chevronRight,
                      size: 20,
                      color: textColor,
                    ),
                    leftChevronIcon: FaIcon(
                      FontAwesomeIcons.chevronLeft,
                      size: 20,
                      color: textColor,
                    ),
                  ),
                  weekendDays: const [DateTime.sunday],
                  daysOfWeekStyle: const DaysOfWeekStyle(
                    weekendStyle: TextStyle(color: errorColor),
                  ),
                ),
              ),
              const Divider(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Obx(
                  () => ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        final event = AuditionCalendarController
                            .to.eventsOfSelectedDay[index];
                        return Column(
                          children: [
                            IntrinsicHeight(
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 40,
                                    child: Column(
                                      children: [
                                        DefaultText(
                                          '${event.date.month}월',
                                          style: Get.textTheme.labelSmall,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        DefaultText(
                                          '${event.date.day}일',
                                          style: Get.textTheme.labelLarge,
                                        ),
                                      ],
                                    ),
                                  ),
                                  VerticalDivider(
                                    width: 40,
                                    thickness: 1.5,
                                    color: AuditionCalendarController.to
                                        .getColor(event),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            DefaultText(
                                              event.type,
                                              style: TextStyle(
                                                  color:
                                                      AuditionCalendarController
                                                          .to
                                                          .getColor(event),
                                                  fontSize: 13),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            event.absentReason != null
                                                ? DefaultText(
                                                    event.absentReason!,
                                                    style: Get
                                                        .textTheme.labelSmall,
                                                  )
                                                : Container(),
                                          ],
                                        ),
                                        DefaultText(
                                          event.toString(),
                                          style: Get.textTheme.labelLarge,
                                          overflow: TextOverflow.visible,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (_, __) => const SizedBox(
                            height: 10,
                          ),
                      itemCount: AuditionCalendarController
                          .to.eventsOfSelectedDay.length),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: DefaultText(
                        ' 닫 기 ',
                        style: TextStyle(
                            color: Get.theme.colorScheme.error, fontSize: 18),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        CreateAuditionController.to.addAuditionList(auditions);
                        Get.back();
                      },
                      child: DefaultText(
                        '불러오기',
                        style: TextStyle(
                            color: Get.theme.primaryColorDark, fontSize: 18),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        );
      },
    );
  }
}
