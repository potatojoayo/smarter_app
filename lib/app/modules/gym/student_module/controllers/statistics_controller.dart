import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class StatisticsController extends GetxController {
  static StatisticsController get to => Get.find();

  final selectedClass = Rx<String?>(null);

  final selectedYear = DateTime.now().year.obs;

  reload(fetchMore) {
    final fetchMoreOptions = FetchMoreOptions(
        variables: {
          'classMasterName':
              selectedClass.value == '전체' ? null : selectedClass.value,
          'year': selectedYear.value,
        },
        updateQuery: (previous, result) {
          return result;
        });
    fetchMore(fetchMoreOptions);
  }
}
