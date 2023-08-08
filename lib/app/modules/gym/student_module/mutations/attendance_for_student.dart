import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/global/utils/show_snack_bar.dart';
import 'package:smarter/app/modules/gym/student_module/controllers/attendance_key_pad_controller.dart';

const attendanceForStudentMutation = """
  mutation attendanceForStudent(\$classMasterId: Int \$studentId: Int){
    attendanceForStudent(classMasterId: \$classMasterId studentId: \$studentId){
      success
      type
      alreadyAttended
    }
  }
""";

class AttendanceForStudentMutation extends StatelessWidget {
  const AttendanceForStudentMutation({
    Key? key,
    required this.builder,
  }) : super(key: key);
  final Widget Function(RunMutation runMutation, QueryResult<Object?>? result)
      builder;

  @override
  Widget build(BuildContext context) {
    return Mutation(
      options: MutationOptions(
          document: gql(attendanceForStudentMutation),
          onCompleted: (result) {
            if (result == null) {
              showSnackBar('에러');
              return;
            }
            if (result['attendanceForStudent']['success']) {
              Get.back();
              showSnackBar('등원 확인 되었습니다');
              AttendanceKeyPadController.to.playAudio();
            } else {
              Get.back();
              showSnackBar('선택한 클래스의 출석 명단에 없는 학생입니다.');
            }
          }),
      builder: builder,
    );
  }
}
