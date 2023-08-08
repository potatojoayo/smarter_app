import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:smarter/app/global/utils/business_registration_number_formatter.dart';
import 'package:smarter/app/global/utils/show_snack_bar.dart';
import 'package:smarter/app/modules/auth_module/auth_mutation.dart';
import 'package:smarter/app/modules/auth_module/controllers/auth_controller.dart';
import 'package:smarter/app/modules/auth_module/widgets/address_web_view.dart';
import 'package:smarter/app/routes/routes.dart';

class RegisterController extends GetxController {
  static RegisterController get to => Get.find();

  final registerFormKey = GlobalKey<FormState>();
  final idController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordCheckController = TextEditingController();
  final gymController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final zipCodeController = TextEditingController();
  final referralController = TextEditingController();
  final addressController = TextEditingController();
  final detailAddressController = TextEditingController();
  final businessRegistrationNumberController = TextEditingController();
  final _businessRegistrationCertificate = Rx<File?>(null);
  final phoneFormatter = MaskTextInputFormatter(
      mask: '### - #### - ####',
      filter: {'#': RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
  final referralCodeFormatter = MaskTextInputFormatter(
      mask: '### - #### - ####',
      filter: {'#': RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  File? get businessRegistrationCertificate =>
      _businessRegistrationCertificate.value;

  Future<void> selectBusinessRegistrationCertificate() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      _businessRegistrationCertificate.value = file;
    }
  }

  final scrollController = ScrollController();

  Future<void> register() async {
    if (!registerFormKey.currentState!.validate()) {
      scrollController.animateTo(0,
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
      return;
    }
    http.MultipartFile? file;
    if (businessRegistrationCertificate == null) {
      showSnackBar('사업자 등록증을 첨부해주세요.');
      return;
    }
    final now = DateTime.now();
    final byteData = await businessRegistrationCertificate!.readAsBytes();
    file = http.MultipartFile.fromBytes(
        'businessRegistrationCertificate', byteData,
        filename:
            '${gymController.text}_사업자등록증_${now.year}-${now.month}-${now.day}.${businessRegistrationCertificate!.path.split('.').last}');
    final result = await AuthController.to.authClient.mutate(
      MutationOptions(
        document: gql(AuthMutation.createOrUpdateGym),
        variables: {
          "gymUser": {
            "identification": idController.text,
            "password": passwordController.text,
            "phone": phoneFormatter.getUnmaskedText(),
            "name": nameController.text,
            "fcmToken": AuthController.to.fcmToken,
          },
          'gym': {
            "address": addressController.text,
            "zipCode": zipCodeController.text,
            "detailAddress": idController.text,
            "email": idController.text,
            "businessRegistrationNumber":
                businessRegistrationNumberFormatter.getUnmaskedText(),
            "businessRegistrationCertificate": file,
            "name": gymController.text,
          },
          'referralCode': referralCodeFormatter.getUnmaskedText()
        },
      ),
    );
    if (result.hasException) {
      showSnackBar('회원가입에 실패하였습니다.');
    }
    if (result.data!['createOrUpdateGym']['duplicatedPhone']) {
      return showSnackBar('이미 존재하는 휴대폰번호입니다.');
    }

    if (result.data!['createOrUpdateGym']
                ['duplicatedBusinessRegistrationNumber'] !=
            null &&
        result.data!['createOrUpdateGym']
            ['duplicatedBusinessRegistrationNumber']) {
      return showSnackBar('이미 존재하는 사업자등록번호입니다.');
    }
    if (result.data!['createOrUpdateGym']['duplicatedIdentification']) {
      return showSnackBar('이미 존재하는 아이디입니다.');
    }
    if (result.data != null && result.data!['createOrUpdateGym']['success']) {
      Get.offNamed(Routes.notActive);
    } else {
      if (result.data!['createOrUpdateGym']['message'] != null) {
        showSnackBar(result.data!['createOrUpdateGym']['message']);
      }
    }
  }

  Future<void> showAddressBottomSheet() async {
    final data = await showModalBottomSheet(
        context: Get.context!,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        enableDrag: false,
        isDismissible: false,
        builder: (context) {
          return const AddressWebView();
        });
    final mappedData = json.decode(data);
    zipCodeController.text = mappedData['zonecode'];
    addressController.text = mappedData['roadAddress'];
  }
}
