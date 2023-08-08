import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

const myAuditions = """
  query MyAuditions(\$after: String \$year: Int \$month: Int){
    myAuditions(first:10 after: \$after year: \$year month: \$month){
      totalCount
      pageInfo{
        endCursor
        hasNextPage
      }
      edges{
        node{
          id
          currentLevel{
            name
          }
          nextLevel{
            name
          }
          dateAudition
          state
          estimatedAlarmDate
        }
      }
    }
  }
""";

class AuditionsQuery extends StatelessWidget {
  const AuditionsQuery(
      {Key? key, required this.builder, this.variables = const {}})
      : super(key: key);
  final Map<String, dynamic> variables;
  final Widget Function(
      List<Map<String, dynamic>> auditions,
      bool hasNextPage,
      String? endCursor,
      int totalCount,
      Function(FetchMoreOptions)? fetchMore,
      Function()? refetch) builder;

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(document: gql(myAuditions), variables: variables),
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

        List<Map<String, dynamic>> auditions = List<Map<String, dynamic>>.from(
            result.data!['myAuditions']['edges'].map((s) => s['node']));
        bool hasNextPage =
            result.data!['myAuditions']['pageInfo']['hasNextPage'];
        String? endCursor =
            result.data!['myAuditions']['pageInfo']['endCursor'];
        int totalCount = result.data!['myAuditions']['totalCount'];

        return builder(auditions, hasNextPage, endCursor, totalCount,
            fetchMore!, refetch!);
      },
    );
  }
}
