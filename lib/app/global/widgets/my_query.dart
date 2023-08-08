import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class MyQuery extends StatelessWidget {
  const MyQuery(
      {Key? key,
      required this.query,
      required this.builder,
      this.variables = const {},
      this.fetchPolicy = FetchPolicy.networkOnly})
      : super(key: key);

  final String query;
  final Map<String, dynamic> variables;
  final dynamic fetchPolicy;
  final Widget Function(
    QueryResult<Object?> result,
  ) builder;

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
        document: gql(query),
        variables: variables,
        fetchPolicy: fetchPolicy,
      ),
      builder: (QueryResult<Object?> result,
          {Future<QueryResult<Object?>> Function(FetchMoreOptions)? fetchMore,
          Future<QueryResult<Object?>?> Function()? refetch}) {
        if (result.hasException) {
          return Container();
        }
        if (result.isLoading) {
          return SpinKitChasingDots(
            color: Get.theme.primaryColorDark,
          );
        }
        if (result.data == null) {
          return Container();
        }

        return builder(result);
      },
    );
  }
}
