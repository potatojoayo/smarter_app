import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/global/utils/show_snack_bar.dart';
import 'package:smarter/app/modules/gym/level_module/controllers/edit_level_controller.dart';

const createOrUpdateLevel = """
  mutation CreateOrUpdateLevel(\$levelObject: LevelInputType \$delete: Boolean ){
    createOrUpdateLevel(levelObject: \$levelObject delete: \$delete){
      success
      studentExists
      deleted
      isDuplicated
    }
  }
""";

class CreateOrUpdateLevel extends StatelessWidget {
  const CreateOrUpdateLevel({Key? key, required this.builder})
      : super(key: key);
  final Widget Function(RunMutation runMutation, QueryResult<Object?>? result)
      builder;

  @override
  Widget build(BuildContext context) {
    return Mutation(
      options: MutationOptions(
          document: gql(createOrUpdateLevel),
          onCompleted: (result) {
            if (result == null) {
              EditLevelController.to.loadingButtonController.stop();
              showSnackBar('에러');
              return;
            }
            if (result['createOrUpdateLevel']['deleted']) {
              Get.back();
              showSnackBar('삭제되었습니다.');
            } else if (result['createOrUpdateLevel']['success']) {
              Get.back();
              showSnackBar('저장되었습니다');
              EditLevelController.to.loadingButtonController.stop();
            } else if (result['createOrUpdateLevel']['isDuplicated']) {
              showSnackBar('같은 이름의 급수가 이미 존재합니다.');
              EditLevelController.to.loadingButtonController.stop();
            } else {
              if (result['createOrUpdateLevel']['studentExists']) {
                showSnackBar('해당 급수의 학생이 있어 삭제할 수 없습니다.');
                EditLevelController.to.loadingButtonController.stop();
              }
            }
          }),
      builder: builder,
    );
  }
}
