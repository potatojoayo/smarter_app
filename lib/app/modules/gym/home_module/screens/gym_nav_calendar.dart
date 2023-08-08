import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/theme/theme.dart';
import 'package:smarter/app/global/utils/day.dart';
import 'package:smarter/app/modules/gym/home_module/widgets/calendar_event_list.dart';
import 'package:smarter/app/modules/gym/student_module/controllers/calendar_controller.dart';
import 'package:table_calendar/table_calendar.dart';

class GymNavCalendar extends StatelessWidget {
  const GymNavCalendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CalendarController.to.load();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(
              () => TableCalendar(
                onPageChanged: (date) {
                  CalendarController.to.focusedDay.value = date;
                  CalendarController.to.selectedDay.value = date;
                },
                focusedDay: CalendarController.to.focusedDay.value,
                onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
                  CalendarController.to.focusedDay.value = focusedDay;
                  CalendarController.to.selectedDay.value = selectedDay;
                },
                selectedDayPredicate: (day) {
                  return day.year ==
                          CalendarController.to.selectedDay.value.year &&
                      day.month ==
                          CalendarController.to.selectedDay.value.month &&
                      day.day == CalendarController.to.selectedDay.value.day;
                },
                calendarBuilders: CalendarBuilders(
                    selectedBuilder: (context, day, focusedDay) {
                      return Center(
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: day.day == focusedDay.day
                                ? Get.theme.primaryColorDark
                                : day.day == DateTime.now().day
                                    ? Colors.grey[200]
                                    : Colors.transparent,
                          ),
                          child: Center(
                            child: Obx(
                              () => Text(
                                day.day.toString(),
                                style: TextStyle(
                                    color: CalendarController
                                                .to.selectedDay.value.weekday ==
                                            7
                                        ? errorColor
                                        : day.day == focusedDay.day
                                            ? Colors.white
                                            : textColor),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    markerBuilder: (context, day, events) => events.isNotEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Get.theme.primaryColorDark,
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              Text(
                                events.length.toString(),
                                style: const TextStyle(
                                    fontSize: 10, color: errorColor),
                              ),
                            ],
                          )
                        : Container()),
                firstDay: DateTime(2022),
                lastDay: DateTime(DateTime.now().year + 1, 12, 31),
                locale: 'ko_KR',
                daysOfWeekHeight: 40,
                eventLoader: (DateTime dateTime) {
                  return CalendarController.to.events[
                          '${dateTime.year}${dateTime.month}${dateTime.day}'] ??
                      [];
                },
                headerStyle: const HeaderStyle(
                  titleTextStyle: TextStyle(fontSize: 20),
                  titleCentered: true,
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
                calendarStyle: CalendarStyle(
                  weekendTextStyle: const TextStyle(color: errorColor),
                  todayDecoration: BoxDecoration(
                      color: Colors.grey[200], shape: BoxShape.circle),
                  selectedDecoration: BoxDecoration(
                      color: Colors.grey[200], shape: BoxShape.circle),
                  todayTextStyle: const TextStyle(),
                ),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Get.theme.primaryColorDark,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text(
                        '알림이 있습니다.',
                        style: TextStyle(fontSize: 14),
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 16,
                        height: 16,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text(
                        '오늘',
                        style: TextStyle(fontSize: 14),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const Divider(
              height: 0,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => Text(
                        '${CalendarController.to.selectedDay.value.month}월 ${CalendarController.to.selectedDay.value.day}일',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    Obx(
                      () => Text(
                        '${getDay(CalendarController.to.selectedDay.value.weekday - 1)}요일',
                        style: const TextStyle(fontSize: 18),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const Divider(
              height: 0,
            ),
            const SizedBox(
              height: 20,
            ),
            const CalendarEventList(),
          ],
        ),
      ),
    );
  }
}
