import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/global/utils/show_snack_bar.dart';
import 'package:smarter/app/modules/gym/student_module/controllers/attendance_controller.dart';

const otherClassAttendance = """
  mutation OtherClassAttendance(\$attendanceMasterId: Int \$studentIds: [Int]){
    otherClassAttendance(attendanceMasterId: \$attendanceMasterId studentIds: \$studentIds){
      success
      isDuplicated
    }
  }
""";

class OtherClassAttendanceMutation extends StatelessWidget {
  const OtherClassAttendanceMutation(
      {Key? key, required this.builder, required this.onComplete})
      : super(key: key);
  final Widget Function(RunMutation runMutation, QueryResult<Object?>? result)
      builder;
  final Function() onComplete;

  @override
  Widget build(BuildContext context) {
    return Mutation(
      options: MutationOptions(
          document: gql(otherClassAttendance),
          onCompleted: (result) {
            if (result == null) {
              AttendanceController.to.loadingButtonController.stop();
              showSnackBar('에러');
              return;
            } else {
              if (result['otherClassAttendance']['isDuplicated']) {
                showSnackBar('이미 타수업 등원이 된 학생이 포함되어 있습니다.');
                AttendanceController.to.loadingButtonController.stop();
              } else {
                onComplete();
              }
              AttendanceController.to.selectedStudentIds.clear();
              AttendanceController.to.selectedClass.value = null;
            }
          }),
      builder: builder,
    );
  }
}
