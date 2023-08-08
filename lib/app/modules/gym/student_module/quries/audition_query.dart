import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

const auditionMaster = """
  query AuditionMaster(\$id: ID!){
    auditionMaster(id: \$id){
      auditionMasterId
      currentLevel{
        name
      }
      nextLevel{
        name
      }
      dateAudition
      state
      estimatedAlarmDate
      details{
        id
        student{
          classMaster{
            name
          }
          name
          birthday
          gender
        }
        didPass
        memo
      }
    }
  }
""";

class AuditionMasterQuery extends StatelessWidget {
  const AuditionMasterQuery(
      {Key? key, required this.builder, this.variables = const {}})
      : super(key: key);
  final Map<String, dynamic> variables;
  final Widget Function(Map<String, dynamic> audition, Function() refetch)
      builder;

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
          document: gql(auditionMaster),
          variables: variables,
          fetchPolicy: FetchPolicy.networkOnly),
      builder: (QueryResult<Object?> result,
          {Future<QueryResult<Object?>> Function(FetchMoreOptions)? fetchMore,
          Future<QueryResult<Object?>?> Function()? refetch}) {
        if (result.hasException) {
          return Container();
        }
        if (result.data == null) {
          return Container();
        }

        Map<String, dynamic> audition = result.data!['auditionMaster'];

        return builder(audition, refetch as Function());
      },
    );
  }
}
