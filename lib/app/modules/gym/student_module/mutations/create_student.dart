import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/global/utils/show_snack_bar.dart';
import 'package:smarter/app/modules/gym/student_module/controllers/edit_student_controller.dart';

const createStudent = """
  mutation CreateStudent(\$student: StudentInputType \$parent: ParentInputType){
    createStudent(student: \$student parent: \$parent){
      success
    }
  }
""";

class CreateStudentMutation extends StatelessWidget {
  const CreateStudentMutation({Key? key, required this.builder})
      : super(key: key);
  final Widget Function(RunMutation runMutation, QueryResult<Object?>? result)
      builder;

  @override
  Widget build(BuildContext context) {
    return Mutation(
      options: MutationOptions(
          document: gql(createStudent),
          onCompleted: (result) {
            if (result == null) {
              EditStudentController.to.loadingButtonController.stop();
              showSnackBar('에러');
              return;
            }
            if (result['createStudent']['success']) {
              Get.back(result: true);
              showSnackBar('저장되었습니다.');
            }
          }),
      builder: builder,
    );
  }
}
