import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/widgets/outlined_textfield.dart';
import 'package:smarter/app/global/widgets/text.dart';

class CartedNameCount extends StatelessWidget {
  const CartedNameCount({
    Key? key,
    required this.name,
    this.editable = false,
  }) : super(key: key);

  final Map<String, dynamic> name;
  final bool editable;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          editable
              ? OutlinedTextField(
                  minWidth: 60,
                  initialValue: name['name'],
                  onChanged: (value) {
                    name['name'] = value;
                  },
                )
              : DefaultText(
                  name['name'],
                  style: Get.textTheme.labelLarge,
                ),
          SizedBox(
            height: 20,
            width: 21,
            child: Center(
              child: DefaultText(
                '${name['count']}',
                style: Get.textTheme.labelLarge,
              ),
            ),
          )
        ],
      ),
    );
  }
}
