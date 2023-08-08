import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/global/theme/theme.dart';
import 'package:smarter/app/global/utils/show_snack_bar.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/auth_module/controllers/auth_controller.dart';
import 'package:smarter/app/modules/shop/order_module/order_mutation.dart';
import 'package:smarter/app/routes/routes.dart';

class ShopNavQuickOrderController extends GetxController {
  static ShopNavQuickOrderController get to => Get.find();

  final RxList<File> files = <File>[].obs;

  final RxBool isVisit = false.obs;

  final RxBool additionalOrder = false.obs;

  final contentsController = TextEditingController();

  requestQuickOrder() async {
    if (contentsController.text.isEmpty) {
      return showSnackBar('주문하실 내용을 적어주세요.');
    }
    Get.dialog(Mutation(
      options: MutationOptions(
        document: gql(OrderMutation.easyOrder),
        onCompleted: (data) {
          if (data!['createEasyOrder']['success']) {
            files.clear();
            contentsController.text = '';
            Get.back();
            Get.toNamed(Routes.easyOrders);
          }
        },
      ),
      builder: (MultiSourceResult<Object?> Function(Map<String, dynamic>,
                  {Object? optimisticResult})
              runMutation,
          QueryResult<Object?>? result) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Center(
            child: DefaultText(
              '간편주문',
              style: Get.textTheme.labelMedium,
            ),
          ),
          content: result!.isLoading
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SpinKitChasingDots(
                      color: Get.theme.primaryColorDark,
                    ),
                  ],
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    DefaultText(
                      '간편주문을 진행하시겠습니까?',
                      style: Get.textTheme.labelLarge,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () async {
                            Get.back();
                          },
                          child: const DefaultText(
                            '취소',
                            style: TextStyle(color: errorColor),
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            final now = DateTime.now();
                            List<http.MultipartFile>? multipartFiles = [];
                            for (final file in files) {
                              final byteData = await file.readAsBytes();
                              multipartFiles.add(http.MultipartFile.fromBytes(
                                  'draft', byteData,
                                  filename:
                                      '${AuthController.to.user!['gym']['name']}/${now.year}-${now.month}-${now.day}/${file.path.split('/').last}'));
                            }
                            runMutation({
                              'contents': contentsController.text,
                              'files': multipartFiles,
                              'isVisit': isVisit.value,
                              'isOrderMore': additionalOrder.value
                            });
                          },
                          child: const DefaultText('주문하기'),
                        ),
                      ],
                    ),
                  ],
                ),
        );
      },
    ));
  }

  Future<void> selectFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
    );
    if (result != null) {
      List<File> uploadFiles = result.paths.map((path) => File(path!)).toList();
      files.addAll(uploadFiles);
    }
  }

  void deleteFile(index) {
    files.removeAt(index);
  }
}
