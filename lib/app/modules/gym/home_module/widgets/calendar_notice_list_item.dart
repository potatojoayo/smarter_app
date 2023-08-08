import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/gym/student_module/controllers/calendar_controller.dart';

class CalendarNoticeListItem extends StatelessWidget {
  const CalendarNoticeListItem({Key? key, required this.event})
      : super(key: key);
  final Event event;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: const Offset(2, 2))
                  ]),
              child: Center(
                child: Icon(FontAwesomeIcons.bell,
                    color: CalendarController.to.getColor(event), size: 20),
              ),
            ),
            const SizedBox(
              width: 24,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: CalendarController.to.getColor(event),
                  ),
                  child: DefaultText(
                    event.type,
                    style: const TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                event.toString().contains('\n')
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DefaultText(
                            event.toString().split('\n')[0],
                            style: Get.textTheme.labelLarge,
                            overflow: TextOverflow.visible,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          DefaultText(
                            event.toString().split('\n')[1],
                            style: Get.textTheme.labelSmall,
                            overflow: TextOverflow.visible,
                          ),
                        ],
                      )
                    : DefaultText(
                        event.toString(),
                        style: Get.textTheme.labelLarge,
                        overflow: TextOverflow.visible,
                      ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
