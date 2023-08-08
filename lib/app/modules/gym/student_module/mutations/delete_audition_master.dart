import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/global/utils/show_snack_bar.dart';
import 'package:smarter/app/modules/gym/student_module/controllers/audition_detail_controller.dart';

const deleteAuditionMaster = """
  mutation DeleteAuditionMaster(\$id: ID){
    deleteAuditionMaster(id: \$id){
      success
    }
  }
""";

class DeleteAuditionMasterMutation extends StatelessWidget {
  const DeleteAuditionMasterMutation({Key? key, required this.builder})
      : super(key: key);
  final Widget Function(RunMutation runMutation, QueryResult<Object?>? result)
      builder;

  @override
  Widget build(BuildContext context) {
    return Mutation(
      options: MutationOptions(
          document: gql(deleteAuditionMaster),
          onCompleted: (result) {
            if (result == null) {
              AuditionDetailController.to.loadingButtonController.stop();
              showSnackBar('에러');
              return;
            }
            if (result['deleteAuditionMaster']['success']) {
              Get.back(result: true);
              Get.back();
              showSnackBar('승급이 삭제되었습니다');
            }
          }),
      builder: builder,
    );
  }
}
