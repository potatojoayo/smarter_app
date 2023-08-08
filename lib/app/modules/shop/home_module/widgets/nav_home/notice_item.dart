import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:timeago/timeago.dart' as timeago;

class NoticeItem extends StatelessWidget {
  const NoticeItem({
    Key? key,
    required this.notice,
  }) : super(key: key);

  final Map<String, dynamic> notice;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              scrollable: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              title: DefaultText(
                notice['title'],
                overflow: TextOverflow.visible,
              ),
              titleTextStyle: Get.textTheme.bodyMedium,
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    timeago.format(
                      DateTime.parse(notice['dateCreated']),
                      locale: 'ko',
                    ),
                    style: Get.textTheme.labelSmall,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: DefaultText(
                      notice['contents'],
                      style: Get.textTheme.labelLarge,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                      onPressed: () => Get.back(),
                      child: const DefaultText('확인'))
                ],
              ),
            ),
          );
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey[800]!),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultText(
                  '${notice['title']}',
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 16,
                  ),
                ),
                Text(
                  timeago.format(
                    DateTime.parse(notice['dateCreated']),
                    locale: 'ko',
                  ),
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 12,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
