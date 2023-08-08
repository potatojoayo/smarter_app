import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smarter/app/global/widgets/text.dart';

class AuditionItem extends StatelessWidget {
  const AuditionItem({
    Key? key,
    required this.audition,
  }) : super(key: key);

  final Map<String, dynamic> audition;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
                color: Colors.black12, offset: Offset(1, 1), blurRadius: 8)
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DefaultText(
            audition['dateAudition'],
            style: Get.textTheme.labelMedium,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  DefaultText(
                    '현재급수',
                    style: Get.textTheme.labelMedium,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  DefaultText(audition['currentLevel']['name'])
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 15.0),
                child: FaIcon(
                  FontAwesomeIcons.arrowRight,
                  size: 20,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                children: [
                  DefaultText(
                    '승급급수',
                    style: Get.textTheme.labelMedium,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  DefaultText(audition['nextLevel']['name'])
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: audition['state'] == '진행중'
                      ? Get.theme.colorScheme.error
                      : Get.theme.primaryColorDark,
                  borderRadius: BorderRadius.circular(7),
                ),
                padding: const EdgeInsets.all(10),
                child: DefaultText(
                  audition['state'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          audition['estimatedAlarmDate'] != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    audition['estimatedAlarmDate'] != null
                        ? const DefaultText('알림 예약 날짜: ',
                            style: TextStyle(color: Colors.grey, fontSize: 13))
                        : Container(),
                    DefaultText(
                        audition['estimatedAlarmDate'] != null
                            ? DateFormat('yyyy.MM.dd HH:mm')
                                .format(DateTime.parse(
                                audition['estimatedAlarmDate'],
                              ).add(const Duration(hours: 9)))
                            : '',
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 13)),
                  ],
                )
              : Container()
        ],
      ),
    );
  }
}
