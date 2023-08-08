import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/global/utils/show_snack_bar.dart';

const attendanceForAllClasses = """
  mutation attendanceForAllClasses(\$classMasterId: Int \$studentId: Int){
    attendanceForAllClass(classMasterId: \$classMasterId studentId: \$studentId){
      success
    }
  }
""";

class AttendanceForAllClassesMutation extends StatelessWidget {
  const AttendanceForAllClassesMutation({
    Key? key,
    required this.builder, required this.onComplete,
  }) : super(key: key);
  final Widget Function(RunMutation runMutation, QueryResult<Object?>? result)
      builder;
  final Function() onComplete;

  @override
  Widget build(BuildContext context) {
    return Mutation(
      options: MutationOptions(
          document: gql(attendanceForAllClasses),
          onCompleted: (result) {
            if (result == null) {
              showSnackBar('에러');
              return;
            }
            if (result['attendanceForStudent']['success']) {
              Get.back();
              showSnackBar('등원 확인 되었습니다');
            } else {
              Get.back();
              showSnackBar('선택한 클래스의 출석 명단에 없는 학생입니다.');
            }
          }),
      builder: builder,
    );
  }
}
