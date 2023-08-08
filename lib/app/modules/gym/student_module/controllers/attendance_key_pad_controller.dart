import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:smarter/app/data/provider/client.dart';
import 'package:smarter/app/global/theme/theme.dart';
import 'package:smarter/app/global/utils/overlay_loading_progress.dart';
import 'package:smarter/app/global/utils/show_snack_bar.dart';
import 'package:smarter/app/modules/gym/gym_class_module/quries/current_classes_query.dart';
import 'package:smarter/app/modules/gym/gym_class_module/util/get_earlist_class.dart';
import 'package:smarter/app/modules/gym/student_module/mutations/attendance_for_student.dart';
import 'package:smarter/app/modules/gym/student_module/mutations/is_right_password.dart';
import 'package:smarter/app/modules/gym/student_module/widgets/key_pad_widget/gym_current_classes.dart';
import 'package:smarter/app/modules/gym/student_module/widgets/key_pad_widget/student_list.dart';

class AttendanceKeyPadController extends GetxController {
  static AttendanceKeyPadController get to => Get.find();

  final code = ''.obs;

  final loadingButtonController = RoundedLoadingButtonController();

  final overlayLoadingProgress = OverlayLoadingProgress();

  int? studentId;
  final Rx<bool> _showCurrentClasses = Rx<bool>(false);

  bool get showCurrentClasses => _showCurrentClasses.value;

  set showCurrentClasses(value) => _showCurrentClasses.value = value;

  final password = TextEditingController();

  @override
  void onInit() {
    BackButtonInterceptor.add(myInterceptor);
    super.onInit();
  }

  @override
  void onClose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.onClose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    // showSnackBar("뒤로가기 버튼은 사용할 수 없습니다."); // Do some stuff.
    return true;
  }

  checkPasswordAndGoBack() async {
    final result = await Client().client.value.query(
          QueryOptions(
            document: gql(isRightPassword),
            variables: {
              'password': password.text,
            },
          ),
        );
    final pass = result.data!['isRightPassword'];
    if (pass) {
      Get.back();
      Get.back();
    } else {
      showSnackBar('잘못된 비밀번호입니다');
    }
  }

  showStudentList() {
    Get.bottomSheet(const StudentList());
  }

  onTapKey(int index) {
    if (index < 9) {
      if (code.value.length < 4) {
        code.value += (index + 1).toString();
      }
    } else if (index == 9) {
      code.value = '';
    } else if (index == 10) {
      if (code.value.length < 4) {
        code.value += '0';
      }
    } else {
      if (code.value.isNotEmpty) {
        code.value = code.value.substring(0, code.value.length - 1);
      }
    }
    if (code.value.length == 4) {
      showStudentList();
    }
  }

  getClassList() async {
    final client = Client().client.value;
    final result =
        await client.query(QueryOptions(document: gql(currentClasses)));

    if (result.hasException) {
      showSnackBar('에러', color: textColor, fontSize: 20);
      overlayLoadingProgress.stop();
      return;
    }
    final classList = result.data!['currentClasses'];
    final sortedClassList = getEarlistClass(classList);
    if (classList.length == 0) {
      Get.back();
      showSnackBar("현재 출석 가능한 클래스가 없습니다.", color: textColor, fontSize: 20);
      overlayLoadingProgress.stop();
    } else if (classList.length == 1) {
      attend(classMaster: classList[0]);
    } else {
      attend(classMaster: sortedClassList[0]);
    }
    code.value = "";
  }

  showClassList() {
    Get.bottomSheet(const GymCurrentClass());
  }

  attend({required dynamic classMaster}) async {
    final classMasterId = int.parse(classMaster['id']);
    final className = classMaster['name'];
    final client = Client().client.value;
    final attendanceResult = await client.mutate(MutationOptions(
        document: gql(attendanceForStudentMutation),
        variables: {"classMasterId": classMasterId, "studentId": studentId}));
    if (attendanceResult.hasException || attendanceResult.data == null) {
      Get.back();
      showSnackBar("에러", color: textColor, fontSize: 20);
      overlayLoadingProgress.stop();
    }
    if (attendanceResult.data!["attendanceForStudent"]['success']) {
      Get.back();
      if (attendanceResult.data!["attendanceForStudent"]['alreadyAttended']) {
        showSnackBar("$className 이미 출석하였습니다.", color: textColor, fontSize: 20);
        playAudio();
        overlayLoadingProgress.stop();
      } else {
        showSnackBar("$className 출석이 완료되었습니다.", color: textColor, fontSize: 20);
        playAudio();
        overlayLoadingProgress.stop();
      }
    } else {
      Get.back();
      showSnackBar("에러", color: textColor, fontSize: 20);
      overlayLoadingProgress.stop();
    }
  }

  onSelectStudent(int id) async {
    studentId = id;
    getClassList();
  }

  late final AssetsAudioPlayer assetsAudioPlayer =
      AssetsAudioPlayer.newPlayer();

  Future<void> playAudio() async {
    try {
      await assetsAudioPlayer.open(
        Audio("assets/sound/sound_attendance.mp3"),
        loopMode: LoopMode.none,
        autoStart: false,
        showNotification: false,
      );
      assetsAudioPlayer.play();
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    }
  }

  Future<void> pauseAudio() async {
    await assetsAudioPlayer.pause();
  }

  Future<void> stopAudio() async {
    await assetsAudioPlayer.stop();
  }
}
