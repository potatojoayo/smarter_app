import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/routes/routes.dart';

class ReturnButton extends StatelessWidget {
  const ReturnButton(
      {Key? key, required this.orderDetail, required this.refetch})
      : super(key: key);

  final Map<String, dynamic> orderDetail;
  final Function refetch;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await Get.toNamed(Routes.returnProduct,
            arguments: {'orderDetail': orderDetail});
        refetch();
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(4),
        ),
        child: const DefaultText(
          '반품신청',
          style: TextStyle(
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
