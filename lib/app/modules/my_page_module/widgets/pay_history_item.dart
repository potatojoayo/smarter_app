import 'package:flutter/material.dart';
import 'package:smarter/app/global/utils/format_money.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:get/get.dart';
import 'package:smarter/app/global/widgets/text.dart';

class PayHistoryItem extends StatelessWidget {
  const PayHistoryItem({
    Key? key,
    required this.historyType,
    required this.amount,
    required this.dateCreated,
    required this.description,
  }) : super(key: key);

  final String historyType;
  final int amount;
  final String dateCreated;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DefaultText(
                historyType,
                style: TextStyle(
                  color: historyType == '사용'
                      ? Get.theme.colorScheme.error
                      : Get.theme.primaryColorDark,
                  fontSize: 14,
                ),
              ),
              DefaultText(
                '${historyType == '사용' ? "-" : "+"} ${formatMoney(amount)}',
                style: TextStyle(
                  color: historyType == '사용'
                      ? Get.theme.colorScheme.error
                      : Get.theme.primaryColorDark,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 16,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                DefaultText(
                  timeago.format(DateTime.parse(dateCreated), locale: 'ko'),
                  style: Get.textTheme.labelMedium,
                ),
                DefaultText(
                  description,
                  maxLines: 2,
                  textAlign: TextAlign.right,
                  style: Get.textTheme.labelLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
