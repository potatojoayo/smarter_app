import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

const myClasses = """
  query MyClasses{
    myClasses{
      id
      name
      dateCreated
      classDetails{
        day
        hourStart
        minStart
        hourEnd
        minEnd
        dateCreated
        isDeleted
      }
    }
  }
""";

class Classes extends StatelessWidget {
  const Classes({Key? key, required this.builder}) : super(key: key);
  final Widget Function(List<Map<String, dynamic>> classMasters,
      Future<QueryResult<Object?>?> Function()? refetch) builder;

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(document: gql(myClasses)),
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
        final classMasters =
            List<Map<String, dynamic>>.from(result.data!['myClasses']);

        return builder(classMasters, refetch);
      },
    );
  }
}
