import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

const studentTodayClasses = """
  query StudentTodayClasses(\$studentId:Int){
  studentTodayClasses(studentId: \$studentId) {
    day
    hourStart
    minStart
    hourEnd
    minEnd
    classMaster{
      id
      name
    }
  }
}
""";

class StudentTodayClassesQuery extends StatelessWidget {
  const StudentTodayClassesQuery(
      {Key? key, required this.builder, required this.studentId})
      : super(key: key);
  final Widget Function(
      List<Map<String, dynamic>> studentTodayClasses,
      Future<QueryResult<Object?>?> Function() refetch,
      ) builder;
  final int? studentId;

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
          document: gql(studentTodayClasses),
          variables: {'studentId': studentId}),
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
        final studentTodayClasses = List<Map<String, dynamic>>.from(result.data!['studentTodayClasses']);

        return builder(studentTodayClasses , refetch!);
      },
    );
  }
}
