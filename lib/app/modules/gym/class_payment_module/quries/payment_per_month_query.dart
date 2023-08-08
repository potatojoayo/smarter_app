import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

const paymentPerMonth = """
  query PaymentPerMonth(\$year: Int){
    paymentPerMonth(year: \$year){
      month
      amount
    }
  }
""";

class PaymentPerMonthQuery extends StatelessWidget {
  const PaymentPerMonthQuery(
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
          QueryOptions(document: gql(paymentPerMonth), variables: variables),
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
            List<Map<String, dynamic>>.from(result.data!['paymentPerMonth']);
        return builder(statistics, fetchMore);
      },
    );
  }
}
