import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

const absentHistory = '''
  query absentHistory(\$id: Int){
    absentHistory(classPaymentMasterId: \$id){
      attendanceMaster{
        date
        classMaster{
          priceDeductPerAbsent
        }
      }
      type
      absentReason
    }
  }
''';

class AbsentHistoryQuery extends StatelessWidget {
  const AbsentHistoryQuery(
      {Key? key, required this.builder, required this.classPaymentMasterId})
      : super(key: key);
  final Widget Function(
    List<Map<String, dynamic>> histories,
  ) builder;
  final int classPaymentMasterId;

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
          document: gql(absentHistory),
          variables: {'id': classPaymentMasterId}),
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
        final histories =
            List<Map<String, dynamic>>.from(result.data!['absentHistory']);

        return builder(histories);
      },
    );
  }
}
