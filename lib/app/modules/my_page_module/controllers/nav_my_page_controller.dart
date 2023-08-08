import 'dart:convert';

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

class NavMyPageController extends GetxController {
  static NavMyPageController get to => Get.find();

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
  final _isDeductEnabled = false.obs;

  bool get isDeductEnabled => _isDeductEnabled.value;

  set isDeductEnabled(value) => _isDeductEnabled.value = value;

  @override
  void onInit() async {
    super.onInit();
    setUserToController(AuthController.to.user!);
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
    addressTextEditingController.text = user['gym']['address'];
    zipCodeTextEditingController.text = user['gym']['zipCode'];
    detailAddressTextEditingController.text = user['gym']['detailAddress'];
    isDeductEnabled = user['gym']['isDeductEnabled'];
    businessRegistrationNumberTextEditingController.text =
        businessRegistrationNumberFormatter
            .maskText(user['gym']['businessRegistrationNumber']);
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

  save(runMutation) {
    if (gymTextEditingController.text == "") {
      showSnackBar("도장명을 등록해주세요");
      loadingButtonController.stop();
      return;
    }
    // if (businessRegistrationNumberTextEditingController.text == "") {
    //   showSnackBar("사업자등록번호를 등록해주세요");
    //   loadingButtonController.stop();
    //   return;
    // }
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
      }
    });
  }
}
