import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

const levels = """
  query ClassesAndLevels{
    myClasses{
      name
    }
    myLevels{
      name
    }
  }
""";

class LevelsQuery extends StatelessWidget {
  const LevelsQuery({Key? key, required this.builder}) : super(key: key);
  final Widget Function(
    List<String> levels,
  ) builder;

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(document: gql(levels)),
      builder: (QueryResult<Object?> result,
          {Future<QueryResult<Object?>> Function(FetchMoreOptions)? fetchMore,
          Future<QueryResult<Object?>?> Function()? refetch}) {
        if (result.data == null) {
          return Container();
        }

        List<String> levels =
            List<String>.from(result.data!['myLevels'].map((l) => l['name']));

        return builder(levels);
      },
    );
  }
}
