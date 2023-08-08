import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/modules/gym/gym_class_module/util/get_earlist_class.dart';

const currentClasses = """
  query CurrentClasses{
    currentClasses{
      id
      name
      currentClassDetail{
        day
        hourStart
        minStart
        hourEnd
        minEnd
      }
    }
  }
""";

class CurrentClasses extends StatelessWidget {
  const CurrentClasses({Key? key, required this.builder}) : super(key: key);
  final Widget Function(List<Map<String, dynamic>> classMasters) builder;

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(document: gql(currentClasses)),
      builder: (QueryResult<Object?> result,
          {Future<QueryResult<Object?>> Function(FetchMoreOptions)? fetchMore,
          Future<QueryResult<Object?>?> Function()? refetch}) {
        if (result.isLoading) {
          return SpinKitChasingDots(
            color: Get.theme.primaryColorDark,
          );
        }
        if (result.data == null) {
          return Container();
        }
        final classMasters =
            List<Map<String, dynamic>>.from(result.data!['currentClasses']);

        final sortedMasters = getEarlistClass(classMasters);
        return builder(sortedMasters);
      },
    );
  }
}
