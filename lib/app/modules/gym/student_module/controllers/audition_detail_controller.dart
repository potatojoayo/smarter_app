import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class AuditionDetailController extends GetxController {
  static AuditionDetailController get to => Get.find();

  final loadingButtonController = RoundedLoadingButtonController();

  final Rx<DateTime?> _alarmSendDate = Rx<DateTime?>(null);

  DateTime? get alarmSendDate => _alarmSendDate.value;

  set alarmSendDate(value) => _alarmSendDate.value = value;

  void showDialog(BuildContext context, Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  void deleteDetail(runMutation, id) {
    runMutation({
      'auditionDetailId': id,
    });
  }
}
