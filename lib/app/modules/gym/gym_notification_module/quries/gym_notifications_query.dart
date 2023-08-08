import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

const myGymNotifications = '''
  query MyGymNotifications(\$after: String \$titleIcontains:  String){
    myGymNotifications(first:10 after: \$after title_Icontains: \$titleIcontains){
      totalCount
       pageInfo{
        hasNextPage
        endCursor
       }
      edges{
        node{
          notificationId
          type
          dateCreated
          title
          contents
          sendType
          sendDatetime
          eventDate
          images
          classMaster {
            name
          }
        }
      }
    }
  }
''';

class GymNotificationsQuery extends StatelessWidget {
  const GymNotificationsQuery({Key? key, required this.builder})
      : super(key: key);
  final Widget Function(
    List<Map<String, dynamic>> notification,
    dynamic refetch,
    dynamic fetchMore,
    bool hasNextPage,
    String? endCursor,
    int totalCount,
  ) builder;

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(document: gql(myGymNotifications)),
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
        final notifications = List<Map<String, dynamic>>.from(
            result.data!['myGymNotifications']['edges'].map((e) => e['node']));
        final hasNextPage =
            result.data!['myGymNotifications']['pageInfo']['hasNextPage'];
        final endCursor =
            result.data!['myGymNotifications']['pageInfo']['endCursor'];
        final totalCount = result.data!['myGymNotifications']['totalCount'];

        return builder(notifications, refetch, fetchMore, hasNextPage,
            endCursor, totalCount);
      },
    );
  }
}
