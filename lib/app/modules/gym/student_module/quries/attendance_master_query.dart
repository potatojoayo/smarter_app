import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/modules/gym/student_module/controllers/attendance_controller.dart';

const attendanceMaster = '''
  query AttendanceMaster(\$id: ID!){
    attendanceMaster(id: \$id){
      attendanceMasterId
      classMaster{
        name
      }
      classDetail{
        id
        day
        hourStart
        minStart
        hourEnd
        minEnd
      }
      date
      details{
        id
        student{
          name
          birthday
          gender
        }
        type
        dateAttended
        absentReason
      }
    }
  }
''';

class AttendanceMasterQuery extends StatelessWidget {
  const AttendanceMasterQuery(
      {Key? key, required this.builder, required this.attendanceMasterId})
      : super(key: key);
  final Widget Function(
    Map<String, dynamic> attendanceMaster,
    Future<QueryResult<Object?>?> Function() refetch,
  ) builder;
  final String attendanceMasterId;

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
          document: gql(attendanceMaster),
          variables: {'id': attendanceMasterId}),
      builder: (QueryResult<Object?> result,
          {Future<QueryResult<Object?>> Function(FetchMoreOptions)? fetchMore,
          Future<QueryResult<Object?>?> Function()? refetch}) {
        if (result.hasException) {
          if (kDebugMode) {
            print(result.exception);
          }
          return Container();
        }
        if (result.data == null) {
          return Container();
        }
        final attendanceMaster = result.data!['attendanceMaster'];

        AttendanceController.to.attendanceMasterId =
            attendanceMaster['attendanceMasterId'];
        AttendanceController.to.classMasterName =
            attendanceMaster['classMaster']['name'];

        return builder(attendanceMaster, refetch!);
      },
    );
  }
}
