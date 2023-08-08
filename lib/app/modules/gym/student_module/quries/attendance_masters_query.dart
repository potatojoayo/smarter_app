import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

const attendanceMasters = '''
  query AttendanceMasters(\$after: String \$classMasterId: Float){
    attendanceMasters(after: \$after first: 15 classMaster_Id: \$classMasterId){
      totalCount
       pageInfo{
        hasNextPage
        endCursor
       }
      edges{
        node{
          id
          classMaster{
            name
          }
          classDetail{
            day
            hourStart
            minStart
            hourEnd
            minEnd
          }
          date 
        }
      }
    }
  }
''';

class AttendanceMastersQuery extends StatelessWidget {
  const AttendanceMastersQuery(
      {Key? key, required this.builder, required this.classMasterId})
      : super(key: key);
  final Widget Function(
    List<Map<String, dynamic>> attendanceMasters,
    int totalCount,
    bool hasNextPage,
    String? endCursor,
    dynamic refetch,
    dynamic fetchMore,
    FetchMoreOptions options,
  ) builder;
  final String classMasterId;

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
          document: gql(attendanceMasters),
          variables: {'classMasterId': classMasterId}),
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
        final attendanceMasters = List<Map<String, dynamic>>.from(
            result.data!['attendanceMasters']['edges'].map((e) => e['node']));
        final hasNextPage =
            result.data!['attendanceMasters']['pageInfo']['hasNextPage'];
        final endCursor =
            result.data!['attendanceMasters']['pageInfo']['endCursor'];
        final totalCount = result.data!['attendanceMasters']['totalCount'];

        FetchMoreOptions opts = FetchMoreOptions(
            variables: {'after': endCursor},
            updateQuery: (previous, result) {
              List? previousAttendances = List<Map<String, dynamic>>.from(
                  previous!['attendanceMasters']['edges']);
              List? newAttendances = List<Map<String, dynamic>>.from(
                  result!['attendanceMasters']['edges']);
              final List<Map<String, dynamic>> attendances = [
                ...previousAttendances,
                ...newAttendances
              ];
              result['attendanceMasters']['edges'] = attendances;
              return result;
            });

        return builder(attendanceMasters, totalCount, hasNextPage, endCursor,
            refetch, fetchMore, opts);
      },
    );
  }
}
