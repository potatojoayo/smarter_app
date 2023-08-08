import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/theme/theme.dart';
import 'package:smarter/app/global/widgets/outlined_textfield.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/routes/routes.dart';

class InfoItem extends StatelessWidget {
  const InfoItem(
      {Key? key,
      required this.value,
      required this.label,
      this.editable = true,
      this.editing = false,
      this.controller,
      this.refetch,
      this.width,
      this.formatter,
      this.keyboardType,
      this.readOnly = false})
      : super(key: key);

  final String label;
  final dynamic refetch;
  final String value;
  final bool editable;
  final bool editing;
  final double? width;
  final TextEditingController? controller;
  final TextInputFormatter? formatter;
  final TextInputType? keyboardType;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
                offset: const Offset(2, 2), color: Colors.grey.withOpacity(.3))
          ]),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultText(
                    label,
                    style: const TextStyle(color: primaryColor, fontSize: 12),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  editing
                      ? OutlinedTextField(
                          controller: controller!,
                          keyboardType: keyboardType ?? TextInputType.text,
                          minWidth: width ?? 50,
                          formatter: formatter,
                          readOnly: readOnly,
                        )
                      : Row(
                          children: [
                            Expanded(
                              child: DefaultText(
                                value,
                                style: Get.textTheme.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ),
            editable && !editing
                ? InkWell(
                    onTap: () async {
                      final result = await Get.toNamed(Routes.editMyInfo);
                      if (result == 'saved') {
                        refetch();
                      }
                    },
                    customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: FaIcon(
                        FontAwesomeIcons.ellipsis,
                        size: 24,
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
