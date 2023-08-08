import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/modules/auth_module/auth_query.dart';

class MeQuery extends StatelessWidget {
  const MeQuery({Key? key, required this.builder}) : super(key: key);

  final Widget Function(Map<String, dynamic> user, dynamic refetch) builder;

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
        document: gql(AuthQuery.me),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
      builder: (QueryResult<Object?> result,
          {Future<QueryResult<Object?>> Function(FetchMoreOptions)? fetchMore,
          Future<QueryResult<Object?>?> Function()? refetch}) {
        if (result.isLoading) {
          return Container();
        }

        if (result.data == null) {
          return Container();
        }

        Map<String, dynamic> user = result.data!['me'];

        return builder(user, refetch);
      },
    );
  }
}
