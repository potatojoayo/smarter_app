import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

const myStudents = """
  query MyStudents(\$class: String \$level: String \$school: String \$name: String \$after: String \$first: Int){
    myStudents(first:\$first after: \$after classMaster_Name: \$class level_Name: \$level school_Name_Icontains: \$school name_Icontains: \$name){
      totalCount
      pageInfo{
        endCursor
        hasNextPage
      }
      edges{
        node{
          studentId
          name
          birthday
          gender
          school{
            name
          }
          status
          classMaster{
            name
          }
          level{
            name
          }
          parent{
            user{
              name
              phone
            }
          }
        }
      }
    }
  }
""";

class StudentsQuery extends StatelessWidget {
  const StudentsQuery(
      {Key? key, required this.builder, this.variables = const {}})
      : super(key: key);
  final Map<String, dynamic> variables;
  final Widget Function(
      List<Map<String, dynamic>> students,
      bool hasNextPage,
      String? endCursor,
      int totalCount,
      Function(FetchMoreOptions)? fetchMore,
      Function()? refetch) builder;

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(document: gql(myStudents), variables: variables),
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

        List<Map<String, dynamic>> students = List<Map<String, dynamic>>.from(
            result.data!['myStudents']['edges'].map((s) => s['node']));
        bool hasNextPage =
            result.data!['myStudents']['pageInfo']['hasNextPage'];
        String? endCursor = result.data!['myStudents']['pageInfo']['endCursor'];
        int totalCount = result.data!['myStudents']['totalCount'];

        return builder(
            students, hasNextPage, endCursor, totalCount, fetchMore!, refetch!);
      },
    );
  }
}
