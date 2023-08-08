import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/data/provider/client.dart';
import 'package:smarter/app/modules/gym/student_module/quries/classes_and_levels.dart';

class GymNavStudentController extends GetxController {
  static GymNavStudentController get to => Get.find();

  final Rx<String?> selectedClass = Rx<String?>(null);
  final Rx<String?> selectedLevel = Rx<String?>(null);
  RxString name = ''.obs;
  RxString school = ''.obs;
  RxList<String> classes = <String>[].obs;
  RxList<String> levels = <String>[].obs;
  Function? fetchMoreStudents;

  final List<String> searchOptions = ['학교명', '학생명'];
  final Rx<String?> selectedOption = Rx<String?>('학생명');

  final TextEditingController searchOptionController = TextEditingController();

  refetch() {
    FetchMoreOptions fetchMoreOptions = FetchMoreOptions(
        updateQuery: (previousData, newData) {
          return newData;
        },
        variables: {
          'class': selectedClass.value != '클래스' ? selectedClass.value : null,
          'level': selectedLevel.value != '급수' ? selectedLevel.value : null,
          'name':
              selectedOption.value == '학생명' ? searchOptionController.text : '',
          'school':
              selectedOption.value == '학생명' ? '' : searchOptionController.text,
          'first': 10,
        });
    fetchMoreStudents!(fetchMoreOptions);
  }

  @override
  void onInit() async {
    // debounce(school, (_) {
    //   refetch();
    // }, time: const Duration(seconds: 1));
    // debounce(name, (_) {
    //   refetch();
    // }, time: const Duration(seconds: 1));
    super.onInit();
    final result = await Client()
        .client
        .value
        .query(QueryOptions(document: gql(classesAndLevels)));
    if (result.data != null) {
      classes.assignAll(
          List<String>.from(result.data!['myClasses'].map((c) => c['name'])));
      classes.insert(0, '클래스');

      levels.assignAll(
          List<String>.from(result.data!['myLevels'].map((l) => l['name'])));
      levels.insert(0, '급수');
    }
  }
}
