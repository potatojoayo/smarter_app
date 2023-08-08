import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/global/utils/show_snack_bar.dart';
import 'package:smarter/app/modules/gym/gym_class_module/controllers/edit_class_controller.dart';

const createOrUpdateClass = """
  mutation CreateOrUpdateClass(\$classMaster: ClassMasterInputType \$weekdays: [Int]! \$classDetails: ClassDetailInputType){
    createOrUpdateClass(classMaster: \$classMaster weekdays: \$weekdays classDetails: \$classDetails){
      success
      studentExists
      isDuplicated
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
              EditClassController.to.loadingButtonController.stop();
              showSnackBar('에러');
              return;
            }
            if (result['createOrUpdateClass']['success']) {
              Navigator.of(context).pop();
            } else {
              if (result['createOrUpdateClass']['studentExists']) {
                EditClassController.to.loadingButtonController.stop();
                showSnackBar('해당 수업을 듣는 학생이 있어 삭제할 수 없습니다.');
              }
              if (result['createOrUpdateClass']['isDuplicated']) {
                EditClassController.to.loadingButtonController.stop();
                showSnackBar('같은 이름의 클래스가 이미 존재합니다.');
              }
            }
          }),
      builder: builder,
    );
  }
}
