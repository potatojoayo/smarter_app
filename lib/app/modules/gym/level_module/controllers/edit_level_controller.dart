import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:smarter/app/data/provider/client.dart';
import 'package:smarter/app/global/utils/show_snack_bar.dart';

const level = '''
  query level(\$id: Int){
    level(id: \$id){
      name
      belt
      beltColor
      beltBrand
      order
    }
  }
''';

class EditLevelController extends GetxController {
  static EditLevelController get to => Get.find();

  final loadingButtonController = RoundedLoadingButtonController();

  late final int id;
  late final bool isCreating;

  final nameController = TextEditingController();
  final beltController = TextEditingController();
  // final poomsaeController = TextEditingController();
  final beltColorController = TextEditingController();
  final beltBrandController = TextEditingController();

  delete(runMutation) {
    Get.back();
    runMutation({
      'levelObject': {
        'id': id,
        'name': nameController.text,
        'belt': beltController.text,
        'beltColor': beltColorController.text,
        'beltBrand': beltBrandController.text,
      },
      'delete': true
    });
  }

  save(runMutation) async {
    if (nameController.text.isEmpty) {
      loadingButtonController.stop();
      showSnackBar('급수명칭을 입력주세요.');
      return;
    }
    if (beltController.text.isEmpty) {
      loadingButtonController.stop();
      showSnackBar('띠명칭을 입력해주세요.');
      return;
    }
    if (beltColorController.text.isEmpty) {
      loadingButtonController.stop();
      showSnackBar('띠색상을 입력해주세요.');
      return;
    }
    if (beltBrandController.text.isEmpty) {
      loadingButtonController.stop();
      showSnackBar('사용띠브랜드를 입력해주세요.');
      return;
    }

    runMutation({
      'levelObject': {
        'id': id > 0 ? id : null,
        'name': nameController.text,
        'belt': beltController.text,
        'beltColor': beltColorController.text,
        'beltBrand': beltBrandController.text,
      }
    });
  }

  @override
  void onInit() async {
    id = int.parse(Get.parameters['id']!);
    if (id != -1) {
      isCreating = false;
      final result = await Client().client.value.query(QueryOptions(
          document: gql(
            level,
          ),
          variables: {'id': id}));
      if (result.data != null) {
        final levelData = result.data!['level'];
        nameController.text = levelData['name'];
        beltController.text = levelData['belt'];
        beltColorController.text = levelData['beltColor'] ?? '';
        beltBrandController.text = levelData['beltBrand'] ?? '';
      }
    } else {
      isCreating = true;
    }
    super.onInit();
  }
}
