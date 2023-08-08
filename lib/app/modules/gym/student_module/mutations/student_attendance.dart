import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/global/utils/show_snack_bar.dart';

const studentAttendance = """
  mutation StudentAttendance(\$attendanceIds: [Int] \$state: String \$absentReason: String){
    studentAttendance(attendanceIds: \$attendanceIds state: \$state absentReason: \$absentReason){
      success
    }
  }
""";

class StudentAttendanceMutation extends StatelessWidget {
  const StudentAttendanceMutation(
      {Key? key, required this.builder, required this.onComplete})
      : super(key: key);
  final Widget Function(RunMutation runMutation, QueryResult<Object?>? result)
      builder;
  final Function() onComplete;

  @override
  Widget build(BuildContext context) {
    return Mutation(
      options: MutationOptions(
          document: gql(studentAttendance),
          onCompleted: (result) {
            if (result == null) {
              showSnackBar('에러');
              return;
            } else {
              onComplete();
            }
          }),
      builder: builder,
    );
  }
}
