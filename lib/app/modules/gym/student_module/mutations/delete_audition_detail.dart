import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/global/utils/show_snack_bar.dart';
import 'package:smarter/app/modules/gym/student_module/controllers/audition_detail_controller.dart';

const deleteAuditionDetail = """
  mutation DeleteAuditionDetail(\$auditionDetailId: Int){
    deleteAuditionDetail(auditionDetailId: \$auditionDetailId){
      success
    }
  }
""";

class DeleteAuditionDetailMutation extends StatelessWidget {
  const DeleteAuditionDetailMutation({Key? key, required this.builder})
      : super(key: key);
  final Widget Function(RunMutation runMutation, QueryResult<Object?>? result)
      builder;

  @override
  Widget build(BuildContext context) {
    return Mutation(
      options: MutationOptions(
          document: gql(deleteAuditionDetail),
          onCompleted: (result) {
            if (result == null) {
              AuditionDetailController.to.loadingButtonController.stop();
              showSnackBar('에러');
              return;
            }
            if (result['deleteAuditionDetail']['success']) {
              Get.back(result: true);
              Get.back();
              showSnackBar('승급이 삭제되었습니다');
            }
          }),
      builder: builder,
    );
  }
}
