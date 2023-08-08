import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:smarter/app/data/provider/client.dart';
import 'package:smarter/app/global/utils/business_registration_number_formatter.dart';
import 'package:smarter/app/global/utils/extract_number.dart';
import 'package:smarter/app/global/utils/phone_formatter.dart';
import 'package:smarter/app/global/utils/show_snack_bar.dart';
import 'package:smarter/app/modules/auth_module/controllers/auth_controller.dart';
import 'package:smarter/app/modules/auth_module/widgets/address_web_view.dart';

class EditMyInfoController extends GetxController {
  static EditMyInfoController get to => Get.find();

  bool event = false;

  final loadingButtonController = RoundedLoadingButtonController();

  final gymTextEditingController = TextEditingController();
  final nameTextEditingController = TextEditingController();
  final phoneTextEditingController = TextEditingController();
  final addressTextEditingController = TextEditingController();
  final emailTextEditingController = TextEditingController();
  final detailAddressTextEditingController = TextEditingController();
  final zipCodeTextEditingController = TextEditingController();
  final refundBankNameController = TextEditingController();
  final refundBankOwnerNameController = TextEditingController();
  final refundBankAccountNoController = TextEditingController();
  final classPaymentBankNameController = TextEditingController();
  final classPaymentBankOwnerNameController = TextEditingController();
  final classPaymentBankAccountNoController = TextEditingController();
  final businessRegistrationNumberTextEditingController =
      TextEditingController();
  final businessRegistrationCertificateTextEditingController =
      TextEditingController();
  final _isDeductEnabled = false.obs;

  final _businessRegistrationCertificate = Rx<File?>(null);

  File? get businessRegistrationCertificate =>
      _businessRegistrationCertificate.value;

  String get businessRegistrationCertificateName {
    final paths = businessRegistrationCertificate!.path.split('/');
    return paths[paths.length - 1];
  }

  Future<void> selectBusinessRegistrationCertificate() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      _businessRegistrationCertificate.value = file;
      businessRegistrationCertificateTextEditingController.text =
          businessRegistrationCertificateName;
    }
  }

  bool get isDeductEnabled => _isDeductEnabled.value;

  set isDeductEnabled(value) => _isDeductEnabled.value = value;

  @override
  void onInit() async {
    super.onInit();
    setUserToController(AuthController.to.user!);
    if (Get.arguments != null) {
      event = Get.arguments['event'] ?? false;
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
      },
    );
    final mappedData = json.decode(data);
    zipCodeTextEditingController.text = mappedData['zonecode'];
    addressTextEditingController.text = mappedData['roadAddress'];
  }

  setUserToController(dynamic user) {
    gymTextEditingController.text = user['gym']['name'];
    nameTextEditingController.text = user['name'];
    phoneTextEditingController.text = phoneFormatter.maskText(user['phone']);
    emailTextEditingController.text = user['gym']['email'] ?? '';
    addressTextEditingController.text = user['gym']['address'];
    zipCodeTextEditingController.text = user['gym']['zipCode'];
    detailAddressTextEditingController.text = user['gym']['detailAddress'];
    isDeductEnabled = user['gym']['isDeductEnabled'];
    businessRegistrationNumberTextEditingController.text =
        businessRegistrationNumberFormatter
            .maskText(user['gym']['businessRegistrationNumber']);
    businessRegistrationCertificateTextEditingController.text =
        user['gym']['businessRegistrationCertificate'];

    refundBankNameController.text = user['gym']['refundBankName'] ?? "";
    refundBankAccountNoController.text =
        user['gym']['refundBankAccountNo'] ?? "";
    refundBankOwnerNameController.text =
        user['gym']['refundBankOwnerName'] ?? "";
    classPaymentBankNameController.text =
        user['gym']['classPaymentBankName'] ?? "";
    classPaymentBankAccountNoController.text =
        user['gym']['classPaymentBankAccountNo'] ?? "";
    classPaymentBankOwnerNameController.text =
        user['gym']['classPaymentBankOwnerName'] ?? "";
  }

  uploadImage() async {
    final picker = ImagePicker();

    const uploadProfileImage = '''
mutation UploadProfileImage(\$profileImage: Upload){
  uploadProfileImage(profileImage: \$profileImage){
    success
  }
}
''';
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final byteData = await image.readAsBytes();
      final file = http.MultipartFile.fromBytes(
          'businessRegistrationCertificate', byteData,
          filename: image.name);
      final client = Client().client.value;
      final result = await client.mutate(MutationOptions(
          document: gql(uploadProfileImage),
          variables: {'profileImage': file}));
      if (result.hasException) {
        return false;
      }
      return true;
    }
    return false;
  }

  save(runMutation) async {
    if (gymTextEditingController.text == "") {
      showSnackBar("도장명을 등록해주세요");
      loadingButtonController.stop();
      return;
    }
    if (businessRegistrationNumberTextEditingController.text.isEmpty) {
      showSnackBar("사업자등록번호를 등록해주세요");
      loadingButtonController.stop();
      return;
    }
    if (nameTextEditingController.text == "") {
      showSnackBar("이름을 등록해주세요");
      loadingButtonController.stop();
      return;
    }
    if (phoneTextEditingController.text == "") {
      showSnackBar("전화번호를 등록해주세요");
      loadingButtonController.stop();
      return;
    }
    if (addressTextEditingController.text == "") {
      showSnackBar("주소를 등록해주세요");
      loadingButtonController.stop();
      return;
    }
    if (zipCodeTextEditingController.text == "") {
      showSnackBar("우편번호를 등록해주세요");
      loadingButtonController.stop();
      return;
    }
    if (event) {
      if (emailTextEditingController.text.isEmpty) {
        showSnackBar('아이디로 사용하실 이메일 주소를 입력해주세요.');
        loadingButtonController.stop();
        return;
      }
      if (businessRegistrationCertificateTextEditingController.text.isEmpty) {
        showSnackBar('사업자 등록증을 첨부해주세요.');
        loadingButtonController.stop();
        return;
      }
      if (refundBankAccountNoController.text.isEmpty ||
          refundBankNameController.text.isEmpty ||
          refundBankOwnerNameController.text.isEmpty ||
          classPaymentBankAccountNoController.text.isEmpty ||
          classPaymentBankNameController.text.isEmpty ||
          classPaymentBankOwnerNameController.text.isEmpty) {
        showSnackBar('계좌 정보를 모두 입력해주세요.');
        loadingButtonController.stop();
        return;
      }
    }

    http.MultipartFile? file;
    if (businessRegistrationCertificate != null) {
      final now = DateTime.now();
      final byteData = await businessRegistrationCertificate!.readAsBytes();
      file = http.MultipartFile.fromBytes(
          'businessRegistrationCertificate', byteData,
          filename:
              '${gymTextEditingController.text}_사업자등록증_${now.year}-${now.month}-${now.day}-$businessRegistrationCertificateName');
    }

    runMutation({
      'isActive': true,
      'gymUser': {
        'id': AuthController.to.user!['id'],
        'name': nameTextEditingController.text,
        'phone': extractNumber(phoneTextEditingController.text),
      },
      'gym': {
        'name': gymTextEditingController.text,
        'address': addressTextEditingController.text,
        'email': emailTextEditingController.text,
        'zipCode': zipCodeTextEditingController.text,
        'detailAddress': detailAddressTextEditingController.text,
        'businessRegistrationNumber':
            extractNumber(businessRegistrationNumberTextEditingController.text),
        'isDeductEnabled': isDeductEnabled,
        'refundBankName': refundBankNameController.text,
        'refundBankOwnerName': refundBankOwnerNameController.text,
        'refundBankAccountNo': refundBankAccountNoController.text,
        'classPaymentBankName': classPaymentBankNameController.text,
        'classPaymentBankOwnerName': classPaymentBankOwnerNameController.text,
        'classPaymentBankAccountNo': classPaymentBankAccountNoController.text,
        "businessRegistrationCertificate": file,
      },
      'event': event,
    });
  }
}
