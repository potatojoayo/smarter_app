import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarter/app/modules/gym/home_module/widgets/calendar_list_item.dart';
import 'package:smarter/app/modules/gym/home_module/widgets/calendar_notice_list_item.dart';
import 'package:smarter/app/modules/gym/student_module/controllers/calendar_controller.dart';

class CalendarEventList extends StatelessWidget {
  const CalendarEventList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Obx(
        () => ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: CalendarController.to.eventsOfSelectedDay.length,
          shrinkWrap: true,
          itemBuilder: (_, index) {
            final event = CalendarController.to.eventsOfSelectedDay[index];
            return event.type != '알림장'
                ? CalendarNoticeListItem(event: event)
                : CalendarListItem(event: event);
          },
          separatorBuilder: (_, __) => const SizedBox(
            height: 10,
          ),
        ),
      ),
    );
  }
}
