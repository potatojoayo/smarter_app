import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GymNavNoticeController extends GetxController {
  static GymNavNoticeController get to => Get.find();

  RxString searchWord = ''.obs;

  Function? fetchMoreNotification;

  TextEditingController textEditingController = TextEditingController();

  refetch() {
    FetchMoreOptions fetchMoreOptions = FetchMoreOptions(
        updateQuery: (previousData, newData) {
          return newData;
        },
        variables: {'titleIcontains': searchWord.value});
    fetchMoreNotification!(fetchMoreOptions);
  }

  @override
  void onInit() async {
    super.onInit();
    debounce(searchWord, (_) {
      refetch();
    }, time: const Duration(seconds: 1));
  }
}
