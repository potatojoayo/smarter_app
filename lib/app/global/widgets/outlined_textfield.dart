import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/widgets/text.dart';

class OutlinedTextField extends StatelessWidget {
  const OutlinedTextField(
      {Key? key,
      this.controller,
      this.label,
      this.formatter,
      this.keyboardType = TextInputType.text,
      this.textAlign = TextAlign.start,
      this.onChanged,
      this.minWidth = 70,
      this.maxLength,
      this.maxHeight = 50,
      this.textInputAction,
      this.labelWidget,
      this.validator,
      this.obscureText = false,
      this.readOnly = false,
      this.initialValue,
      this.hintText,
      this.suffix,
      this.focusNode,
      this.enabled = true})
      : super(key: key);

  final TextEditingController? controller;
  final String? label;
  final TextInputFormatter? formatter;
  final double minWidth;
  final double maxHeight;
  final TextInputAction? textInputAction;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final String? initialValue;
  final TextAlign textAlign;
  final void Function(String)? onChanged;
  final bool readOnly;
  final int? maxLength;
  final Widget? labelWidget;
  final bool obscureText;
  final String? hintText;
  final Widget? suffix;
  final FocusNode? focusNode;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label != null
            ? Column(
                children: [
                  DefaultText(
                    label!,
                    style: Get.textTheme.labelLarge,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              )
            : Container(),
        ConstrainedBox(
          constraints: BoxConstraints(minWidth: minWidth, maxHeight: maxHeight),
          child: IntrinsicWidth(
            child: TextFormField(
              controller: controller,
              obscureText: obscureText,
              initialValue: initialValue,
              validator: validator,
              readOnly: readOnly,
              style: Get.textTheme.labelLarge,
              textAlign: textAlign,
              textInputAction: textInputAction,
              maxLength: maxLength,
              keyboardType: keyboardType,
              focusNode: focusNode,
              onChanged: onChanged,
              enabled: enabled,
              inputFormatters: formatter != null ? [formatter!] : [],
              decoration: InputDecoration(
                errorStyle: const TextStyle(fontSize: 12),
                counterText: '',
                fillColor: Colors.white,
                filled: true,
                label: labelWidget,
                suffix: suffix,
                hintText: hintText,
                border: const OutlineInputBorder(),
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              ),
            ),
          ),
        )
      ],
    );
  }
}
