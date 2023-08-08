import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/global/utils/show_snack_bar.dart';

const createOrUpdateClass = """
  mutation CreateOrUpdateClass(\$classMaster: ClassMasterInputType \$weekdays: [Int]! \$classDetails: ClassDetailInputType]){
    createOrUpdateClass(classMaster: \$classMaster weekdays: \$weekdays classDetails: \$classDetails){
      success
      studentExists
    }
  }
""";

class CreateOrUpdateClass extends StatelessWidget {
  const CreateOrUpdateClass({Key? key, required this.builder})
      : super(key: key);
  final Widget Function(RunMutation runMutation, QueryResult<Object?>? result)
      builder;

  @override
  Widget build(BuildContext context) {
    return Mutation(
      options: MutationOptions(
          document: gql(createOrUpdateClass),
          onCompleted: (result) {
            if (result == null) {
              showSnackBar('에러');
              return;
            }
            if (result['createOrUpdateClass']['success']) {
              Get.back();
              showSnackBar('저장되었습니다');
            } else {
              if (result['createOrUpdateClass']['studentExists']) {
                showSnackBar('해당 수업을 듣는 학생이 있어 삭제할 수 없습니다.');
              }
            }
          }),
      builder: builder,
    );
  }
}
