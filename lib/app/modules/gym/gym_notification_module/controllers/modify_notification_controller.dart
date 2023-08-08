import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:smarter/app/global/utils/overlay_loading_progress.dart';
import 'package:smarter/app/global/utils/show_snack_bar.dart';
import 'package:http/http.dart' as http;

class ModifyNotificationController extends GetxController {
  static ModifyNotificationController get to => Get.find();

  final loadingButtonController = RoundedLoadingButtonController();
  final overlayLoadingProgress = OverlayLoadingProgress();
  final notification = {}.obs;

  @override
  void onInit() {
    super.onInit();

    notification.value = Get.arguments['notification'];
    titleController.text = notification['title'];
    contentsController.text = notification['contents'];
    selectedDate = DateTime.parse(notification['sendDatetime']);
    if (notification['eventDate'] != null &&
        notification['eventDate'] != '1974-03-23') {
      eventDate = DateTime.parse(notification['eventDate']);
    }
  }

  final selectedClass = '전체'.obs;
  final titleController = TextEditingController();
  final contentsController = TextEditingController();
  final RxList<XFile> images = <XFile>[].obs;
  final sendType = ''.obs;
  Rx<bool> rightNow = false.obs;

  final Rx<DateTime?> _selectedDate = Rx<DateTime?>(null);

  DateTime? get selectedDate => _selectedDate.value;

  set selectedDate(value) => _selectedDate.value = value;

  final Rx<DateTime?> _eventDate = Rx<DateTime?>(null);

  DateTime? get eventDate => _eventDate.value;

  set eventDate(value) => _eventDate.value = value;

  pickImages() async {
    final picker = ImagePicker();
    images.addAll(await picker.pickMultiImage());
  }

  removeImage(int index) {
    images.removeAt(index);
  }

  delete(runMutation, notificationId) async {
    runMutation(
      {
        'gymNotificationId': notificationId,
      },
    );
  }

  modify(runMutation, notificationId) async {
    if (titleController.text.isEmpty) {
      overlayLoadingProgress.stop();
      return showSnackBar('제목을 입력해주세요');
    }
    if (contentsController.text.isEmpty) {
      overlayLoadingProgress.stop();
      return showSnackBar('내용을 입력해주세요');
    }
    final files = [];
    for (XFile image in images) {
      final byteData = await image.readAsBytes();
      final multipartFile = http.MultipartFile.fromBytes('image', byteData,
          filename: '${image.name}${DateTime.now().second}');
      files.add(multipartFile);
    }

    String? selectedDateStr;
    if (selectedDate == null) {
      sendType.value = "즉시";
      selectedDateStr = DateTime.now().toIso8601String();
    } else {
      sendType.value = "예약";
      selectedDateStr = selectedDate?.toIso8601String();
    }

    String? eventDateStr;
    if (eventDate != null) {
      eventDateStr = eventDate?.toIso8601String();
    } else {
      eventDateStr = DateTime.fromMillisecondsSinceEpoch(133247247 * 1000)
          .toIso8601String();
    }
    runMutation(
      {
        'gymNotificationId': notificationId,
        'classMasterName': selectedClass.value,
        'title': titleController.text,
        'contents': contentsController.text,
        'images': files,
        'sendType': sendType.value,
        'sendDatetime': selectedDateStr,
        'eventDate': eventDateStr,
      },
    );
  }

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
}
