import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

const studentsByCode = """
  query StudentsByCode(\$code: String){
    studentsByCode(code: \$code){
      id
      name
      school{
        name
      }
      parent{
        user{
          name
        }
      }
    }
  }
""";

class StudentsByCodeQuery extends StatelessWidget {
  const StudentsByCodeQuery(
      {Key? key, required this.builder, required this.code})
      : super(key: key);
  final Widget Function(
    List<Map<String, dynamic>> students,
  ) builder;
  final String code;

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
          document: gql(studentsByCode), variables: {'code': code}),
      builder: (QueryResult<Object?> result,
          {Future<QueryResult<Object?>> Function(FetchMoreOptions)? fetchMore,
          Future<QueryResult<Object?>?> Function()? refetch}) {
        if (result.isLoading) {
          return SpinKitChasingDots(
            color: Get.theme.primaryColorDark,
          );
        }
        if (result.hasException) {
          return Container();
        }
        if (result.data == null) {
          return Container();
        }
        final students =
            List<Map<String, dynamic>>.from(result.data!['studentsByCode']);

        return builder(students);
      },
    );
  }
}
