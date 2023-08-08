import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/routes/routes.dart';

class GymNotificationListItem extends StatelessWidget {
  const GymNotificationListItem({
    Key? key,
    required this.notification,
  }) : super(key: key);

  final Map<String, dynamic> notification;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DefaultText(
                DateFormat('yyyy.MM.dd').format(
                  DateTime.parse(
                    notification['dateCreated'],
                  ),
                ),
                style: Get.textTheme.labelMedium,
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(
                  children: [
                    const DefaultText('발송일',
                        style: TextStyle(fontSize: 14, color: Colors.blue)),
                    const SizedBox(
                      width: 5,
                    ),
                    DefaultText(
                        notification['sendDatetime'] != null
                            ? DateFormat('yyyy.MM.dd HH:mm')
                                .format(DateTime.parse(
                                notification['sendDatetime'],
                              ).toLocal())
                            : '',
                        style:
                            const TextStyle(fontSize: 14, color: Colors.blue)),
                  ],
                ),
                DateTime.now().year -
                            DateTime.parse(
                                    notification['eventDate'] ?? '1974-03-23')
                                .year <=
                        0
                    ? DefaultText(
                        "행사일 ${DateFormat('yyyy.MM.dd').format(DateTime.parse(
                          notification['eventDate'] ?? '1974-03-23',
                        ))}",
                        style: const TextStyle(fontSize: 14, color: Colors.red),
                      )
                    : Container()
              ]),
              // Column(
              //   children: [
              //     notification['type'] == '전체'
              //         ? DefaultText(
              //       notification['type'],
              //       style: Get.textTheme.labelMedium,
              //     )
              //         : notification['type'] == '클래스'
              //         ? DefaultText(
              //       notification['classMaster']['name'],
              //       style: Get.textTheme.labelMedium,
              //     )
              //         : Container(),
              //     SizedBox(height :10),
              //     ElevatedButton(
              //       onPressed: (){
              //
              //       },
              //       child: Text('수정'),
              //     ),
              //
              //     ElevatedButton(
              //       onPressed: (){
              //
              //       },
              //       child: Text('삭제',
              //     ))
              //   ],
              // ),
              notification['type'] == '전체'
                  ? DefaultText(
                      notification['type'],
                      style: Get.textTheme.labelMedium,
                    )
                  : notification['type'] == '클래스'
                      ? DefaultText(
                          notification['classMaster']['name'],
                          style: Get.textTheme.labelMedium,
                        )
                      : Container()
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            notification['title'],
            style: Get.textTheme.bodySmall,
            maxLines: 3,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            notification['contents'],
            style: Get.textTheme.labelLarge,
            maxLines: 30,
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: notification['images'].isNotEmpty ? 200 : 0,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                final image = notification['images'][index];
                return GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.fullScreenImage,
                          arguments: {'url': image});
                    },
                    child: Image.network(image));
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  width: 10,
                );
              },
              itemCount: notification['images'].length,
            ),
          ),
        ],
      ),
    );
  }
}
