import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/theme/theme.dart';
import 'package:smarter/app/global/widgets/text.dart';

class SelectButtonController extends GetxController {
  final RxList<Widget> items;
  final RxList<bool> selected;
  final List<String> values;
  final _selectedValue = Rx<String?>(null);
  String? get selectedValue => _selectedValue.value;
  set selectedValue(value) => _selectedValue.value = value;
  SelectButtonController({required this.values, Color borderColor = textColor})
      : items = List<DefaultText>.from(values.map((i) => DefaultText(i))).obs,
        selected = List<bool>.generate(values.length, (index) => false).obs;
}
