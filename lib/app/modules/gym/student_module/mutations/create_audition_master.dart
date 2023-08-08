import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/global/utils/show_snack_bar.dart';
import 'package:smarter/app/modules/gym/student_module/controllers/create_audition_controller.dart';

const createAuditionMaster = """
  mutation CreateAudition(\$auditionMasterObjects: [AuditionMasterInputType] \$dateAudition: String \$dateAlarm: String ){
    createAudition(auditionMasterObjects: \$auditionMasterObjects dateAudition: \$dateAudition dateAlarm: \$dateAlarm ){
      success
    }
  }
""";

class CreateAuditionMaster extends StatelessWidget {
  const CreateAuditionMaster({Key? key, required this.builder})
      : super(key: key);
  final Widget Function(RunMutation runMutation, QueryResult<Object?>? result)
      builder;

  @override
  Widget build(BuildContext context) {
    return Mutation(
      options: MutationOptions(
        document: gql(createAuditionMaster),
        onCompleted: (result) {
          if (result == null) {
            CreateAuditionController.to.loadingButtonController.stop();
            showSnackBar('에러');
            return;
          }
          if (result['createAudition']['success']) {
            Get.back(result: true);
            showSnackBar('승급이 생성되었습니다.');
          }
        },
      ),
      builder: builder,
    );
  }
}
