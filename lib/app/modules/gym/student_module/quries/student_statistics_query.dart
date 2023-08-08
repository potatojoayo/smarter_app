import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

const studentStatistics = """
  query StudentStatistics(\$classMasterName: String \$year: Int){
    studentStatistics(classMasterName: \$classMasterName year: \$year){
      month
      totalStudent
      newStudent
      outStudent
    }
  }
""";

class StudentStatisticsQuery extends StatelessWidget {
  const StudentStatisticsQuery(
      {Key? key, required this.builder, required this.variables})
      : super(key: key);
  final Widget Function(List<Map<String, dynamic>> data,
          Future<QueryResult<Object?>> Function(FetchMoreOptions)? fetchMore)
      builder;
  final Map<String, dynamic> variables;

  @override
  Widget build(BuildContext context) {
    return Query(
      options:
          QueryOptions(document: gql(studentStatistics), variables: variables),
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
        final statistics =
            List<Map<String, dynamic>>.from(result.data!['studentStatistics']);
        return builder(statistics, fetchMore);
      },
    );
  }
}
