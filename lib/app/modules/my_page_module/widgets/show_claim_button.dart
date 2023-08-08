import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/theme/theme.dart';
import 'package:smarter/app/global/widgets/outlined_textfield.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/my_page_module/controllers/claim_controller.dart';
import 'package:smarter/app/modules/my_page_module/widgets/select_claim_quantity.dart';

class ShowClaimButton extends StatelessWidget {
  const ShowClaimButton({
    Key? key,
    required this.type,
    required this.orderDetailId,
  }) : super(key: key);

  final String type;
  final int orderDetailId;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Get.bottomSheet(
          Container(
            color: Get.theme.colorScheme.background,
            child: Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20, top: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DefaultText(
                      '$type하실 상품의 개수를 선택해주세요.',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SelectClaimQuantity(),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: DefaultText(
                          '사유',
                          style: Get.textTheme.labelLarge,
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    OutlinedTextField(
                        minWidth: double.infinity,
                        maxHeight: 50,
                        controller: ClaimController.to.reasonController),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const DefaultText(
                            '취소',
                            style: TextStyle(color: errorColor),
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            await ClaimController.to.requestClaim(
                                orderDetailId: orderDetailId, type: type);
                          },
                          child: DefaultText('$type신청'),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
        );
      },
      child: DefaultText('$type신청', style: const TextStyle(color: errorColor)),
    );
  }
}
