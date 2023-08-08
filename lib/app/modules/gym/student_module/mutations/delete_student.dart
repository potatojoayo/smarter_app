import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/global/utils/show_snack_bar.dart';
import 'package:smarter/app/modules/gym/student_module/controllers/edit_student_controller.dart';

const deleteStudent = """
  mutation DeleteStudent(\$studentId: Int){
    deleteStudent(studentId: \$studentId){
      success
    }
  }
""";

class DeleteStudentMutation extends StatelessWidget {
  const DeleteStudentMutation({Key? key, required this.builder})
      : super(key: key);
  final Widget Function(RunMutation runMutation, QueryResult<Object?>? result)
      builder;

  @override
  Widget build(BuildContext context) {
    return Mutation(
      options: MutationOptions(
          document: gql(deleteStudent),
          onCompleted: (result) {
            if (result == null) {
              showSnackBar('에러');
              EditStudentController.to.loadingButtonController.stop()
;              return;
            }
            if (result['deleteStudent']['success']) {
              Get.back(result: true);
              showSnackBar('삭제되었습니다');
            }
          }),
      builder: builder,
    );
  }
}
