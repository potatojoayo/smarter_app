import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/theme/theme.dart';

class DefaultTextField extends StatelessWidget {
  const DefaultTextField({
    required this.controller,
    this.label = "",
    this.hint,
    this.obscureText = false,
    this.inputFormatters,
    this.textInputType,
    this.maxLength,
    this.focusNode,
    this.autofocus = true,
    this.textStyle,
    this.removeFocusBorder = true,
    this.removeContentPadding = true,
    Key? key,
    this.textAlign = TextAlign.start,
    this.onChange,
    this.maxLines = 1,
    this.minLines = 1,
    this.contentPadding = const EdgeInsets.fromLTRB(12, 20, 12, 12),
  }) : super(key: key);
  final TextEditingController controller;
  final String label;
  final String? hint;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? textInputType;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final FocusNode? focusNode;
  final bool autofocus;
  final TextStyle? textStyle;
  final bool removeFocusBorder;
  final bool removeContentPadding;
  final TextAlign textAlign;
  final void Function(String?)? onChange;
  final bool obscureText;
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      autofocus: autofocus,
      keyboardType: textInputType,
      focusNode: focusNode,
      textAlign: textAlign,
      inputFormatters: inputFormatters,
      onChanged: onChange,
      maxLength: maxLength,
      maxLines: maxLines,
      minLines: minLines,
      style: textStyle,
      decoration: InputDecoration(
        counterText: '',
        // contentPadding: contentPadding,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
        hintText: hint,
        hintStyle:
            textStyle ?? const TextStyle(fontSize: 16, color: disabledColor),
        border: InputBorder.none,
        focusedBorder: removeFocusBorder ? InputBorder.none : null,
        label: Text(
          label,
          style: textStyle ?? Get.textTheme.labelLarge,
        ),
      ),
      controller: controller,
    );
  }
}
