import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

const calendarQuery = """
  query CalendarQuery(\$after: String \$year: Int \$month: Int){
    myAuditions(first:10 after: \$after year: \$year month: \$month){
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
        }
      }
    }
    gymAbsentRequests(year: \$year month: \$month){
      absentReason
      dateAbsent
      student{
        name
        classMaster{
          name
        }
      }
    }
    myGymNotifications(year: \$year month: \$month){
      totalCount
       pageInfo{
        hasNextPage
        endCursor
       }
      edges{
        node{
          type
          dateCreated
          title
          contents
          sendType
          sendDatetime
          images
          eventDate
          classMaster {
            name
          }
        }
      }
    }
  }
""";

class CalendarQuery extends StatelessWidget {
  const CalendarQuery(
      {Key? key, required this.builder, this.variables = const {}})
      : super(key: key);
  final Map<String, dynamic> variables;
  final Widget Function(
    List<Map<String, dynamic>> auditions,
    List<Map<String, dynamic>> absentRequests,
    List<Map<String, dynamic>> notifications,
    Function(FetchMoreOptions)? fetchMore,
  ) builder;

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(document: gql(calendarQuery), variables: variables),
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

        List<Map<String, dynamic>> absentRequests =
            List<Map<String, dynamic>>.from(result.data!['gymAbsentRequests']);

        List<Map<String, dynamic>> notifications = List<Map<String, dynamic>>.from(
            result.data!['myGymNotifications']['edges'].map((e) => e['node']));

        return builder(auditions, absentRequests, notifications, fetchMore!);
      },
    );
  }
}
