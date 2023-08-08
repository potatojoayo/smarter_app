import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

const levels = """
  query MyLevels{
    myLevels{
      id
      name
      belt
      beltColor
      beltBrand
    }
  }
""";

class Levels extends StatelessWidget {
  const Levels({Key? key, required this.builder}) : super(key: key);
  final Widget Function(QueryResult<Object?> result,
      {Future<QueryResult<Object?>> Function(FetchMoreOptions)? fetchMore,
      Future<QueryResult<Object?>?> Function()? refetch}) builder;

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(document: gql(levels)),
      builder: builder,
    );
  }
}
