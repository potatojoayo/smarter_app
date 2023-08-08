import 'package:flutter/material.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/shop/payment_module/mixins/payment_mixin.dart';
import 'package:smarter/app/modules/shop/payment_module/widgets/pay_method_button.dart';

class SelectPayMethod extends StatelessWidget {
  const SelectPayMethod({Key? key, required this.controller}) : super(key: key);

  final PaymentMixin controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const DefaultText('결제수단 선택'),
        const SizedBox(
          height: 20,
        ),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 4 / 3,
            crossAxisSpacing: 10,
          ),
          itemBuilder: (context, index) => PayMethodButton(
            method: controller.methods[index],
            controller: controller,
          ),
          itemCount: controller.methods.length,
        ),
      ],
    );
  }
}
