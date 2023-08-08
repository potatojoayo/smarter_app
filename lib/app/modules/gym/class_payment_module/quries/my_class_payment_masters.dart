import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

const myClassPaymentMasters = '''
  query MyGymClassPaymentMasters(\$after: String \$classMaster: String \$paymentStatus: String \$isApproved: Boolean \$type: String \$filteringName: String \$filteringDays: Int ){
    myGymClassPaymentMasters(first:10 after:\$after classMaster_Name: \$classMaster paymentStatus: \$paymentStatus isApproved: \$isApproved type: \$type filteringName: \$filteringName filteringDays: \$filteringDays){
      totalCount
       pageInfo{
        hasNextPage
        endCursor
       }
      edges{
        node{
          id
          isApproved
          classPaymentMasterId
          classMaster{
            name
          }
          student{
            name
            birthday
            gender
            parent{
              user{
                name
                phone
              }
            }
          }
          dateToPay
          paymentStatus
          priceToPay
          datePaid
          type
          memo
        }
      }
    }
  }
''';

class MyClassPaymentMastersQuery extends StatelessWidget {
  const MyClassPaymentMastersQuery(
      {Key? key, required this.builder, this.variables = const {}})
      : super(key: key);
  final Widget Function(
    List<Map<String, dynamic>> classPaymentMasters,
    dynamic refetch,
    dynamic fetchMore,
    bool hasNextPage,
    String? endCursor,
    int totalCount,
  ) builder;

  final Map<String, dynamic> variables;

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
          document: gql(myClassPaymentMasters), variables: variables),
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
        final classPaymentMasters = List<Map<String, dynamic>>.from(result
            .data!['myGymClassPaymentMasters']['edges']
            .map((e) => e['node']));
        final hasNextPage =
            result.data!['myGymClassPaymentMasters']['pageInfo']['hasNextPage'];
        final endCursor =
            result.data!['myGymClassPaymentMasters']['pageInfo']['endCursor'];
        final totalCount =
            result.data!['myGymClassPaymentMasters']['totalCount'];

        return builder(classPaymentMasters, refetch, fetchMore, hasNextPage,
            endCursor, totalCount);
      },
    );
  }
}
