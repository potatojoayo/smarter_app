import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/theme/theme.dart';
import 'package:smarter/app/global/utils/business_registration_number_formatter.dart';
import 'package:smarter/app/global/utils/phone_formatter.dart';
import 'package:smarter/app/global/widgets/outlined_textfield.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/auth_module/controllers/register_controller.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: RegisterController.to.registerFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DefaultText(
            '이메일',
            style: TextStyle(color: Colors.grey[600], fontSize: 16),
          ),
          const SizedBox(
            height: 4,
          ),
          OutlinedTextField(
            minWidth: 200,
            maxHeight: 100,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            controller: RegisterController.to.idController,
            labelWidget: Text(
              '이메일 *',
              style: Get.textTheme.labelSmall,
            ),
            validator: (value) {
              final bool emailValid = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(value!);
              if (!emailValid) {
                return '정확한 이메일을 입력해주세요.';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 16,
          ),
          DefaultText(
            '비밀번호',
            style: TextStyle(color: Colors.grey[600], fontSize: 16),
          ),
          const SizedBox(
            height: 4,
          ),
          OutlinedTextField(
            minWidth: 300,
            maxHeight: 100,
            obscureText: true,
            textInputAction: TextInputAction.next,
            controller: RegisterController.to.passwordController,
            validator: (value) {
              if (value!.length < 4) {
                return '비밀번호는 4자 이상이어야 합니다.';
              } else {
                return null;
              }
            },
            labelWidget: Text(
              '비밀번호 *',
              style: Get.textTheme.labelSmall,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          OutlinedTextField(
            minWidth: 300,
            maxHeight: 100,
            textInputAction: TextInputAction.next,
            obscureText: true,
            controller: RegisterController.to.passwordCheckController,
            validator: (value) {
              if (value!.length < 4) {
                return '비밀번호는 4자 이상이어야 합니다.';
              } else if (RegisterController.to.passwordController.text !=
                  RegisterController.to.passwordCheckController.text) {
                return '비밀번호가 일치하지 않습니다.';
              } else {
                return null;
              }
            },
            labelWidget: Text(
              '비밀번호 확인 *',
              style: Get.textTheme.labelSmall,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          DefaultText(
            '대표자명',
            style: TextStyle(color: Colors.grey[600], fontSize: 16),
          ),
          const SizedBox(
            height: 4,
          ),
          OutlinedTextField(
            minWidth: 200,
            maxHeight: 100,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            controller: RegisterController.to.nameController,
            labelWidget: Text(
              '대표자명 *',
              style: Get.textTheme.labelSmall,
            ),
            validator: (value) {
              if (value == null) {
                return '이름을 입력해주세요';
              }
              if (value.isEmpty) {
                return '이름을 입력해주세요';
              } else {
                return null;
              }
            },
          ),
          const SizedBox(
            height: 16,
          ),
          DefaultText(
            '휴대폰',
            style: TextStyle(color: Colors.grey[600], fontSize: 16),
          ),
          const SizedBox(
            height: 4,
          ),
          OutlinedTextField(
            minWidth: 200,
            maxHeight: 100,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            formatter: RegisterController.to.phoneFormatter,
            controller: RegisterController.to.phoneController,
            labelWidget: Text(
              '휴대폰 *',
              style: Get.textTheme.labelSmall,
            ),
            validator: (value) {
              if (value == null) {
                return '휴대폰 번호를 입력해주세요';
              }
              if (value.isEmpty) {
                return '휴대폰 번호를 입력해주세요';
              } else {
                return null;
              }
            },
          ),
          const SizedBox(
            height: 16,
          ),
          DefaultText(
            '학원명',
            style: TextStyle(color: Colors.grey[600], fontSize: 16),
          ),
          const SizedBox(
            height: 4,
          ),
          OutlinedTextField(
            minWidth: 200,
            maxHeight: 100,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            controller: RegisterController.to.gymController,
            labelWidget: Text(
              '학원명 *',
              style: Get.textTheme.labelSmall,
            ),
            validator: (value) {
              if (value == null) {
                return '학원명을 입력해주세요';
              }
              if (value.isEmpty) {
                return '학원명을 입력해주세요';
              } else {
                return null;
              }
            },
          ),
          const SizedBox(
            height: 16,
          ),
          DefaultText(
            '우편번호',
            style: TextStyle(color: Colors.grey[600], fontSize: 16),
          ),
          const SizedBox(
            height: 4,
          ),
          Row(
            children: [
              OutlinedTextField(
                maxHeight: 100,
                readOnly: true,
                minWidth: 200,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                controller: RegisterController.to.zipCodeController,
                maxLength: 5,
                labelWidget: Text(
                  '우편번호 *',
                  style: Get.textTheme.labelSmall,
                ),
                validator: (value) {
                  if (value == null) {
                    return '우편번호를 입력해주세요';
                  }
                  if (value.isEmpty) {
                    return '우편번호를 입력해주세요';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                height: 45,
                child: ElevatedButton(
                    onPressed: RegisterController.to.showAddressBottomSheet,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Get.theme.primaryColorDark),
                    child: const DefaultText(
                      '주소검색',
                      style: TextStyle(fontSize: 13, color: backgroundColor),
                    )),
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          DefaultText(
            '주소',
            style: TextStyle(color: Colors.grey[600], fontSize: 16),
          ),
          const SizedBox(
            height: 4,
          ),
          OutlinedTextField(
            minWidth: double.infinity,
            maxHeight: 100,
            readOnly: true,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            controller: RegisterController.to.addressController,
            labelWidget: Text(
              '주소 *',
              style: Get.textTheme.labelSmall,
            ),
            validator: (value) {
              if (value == null) {
                return '주소를 입력해주세요';
              }
              if (value.isEmpty) {
                return '주소를 입력해주세요';
              } else {
                return null;
              }
            },
          ),
          const SizedBox(
            height: 20,
          ),
          OutlinedTextField(
            minWidth: double.infinity,
            maxHeight: 100,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            controller: RegisterController.to.detailAddressController,
            labelWidget: Text(
              '상세주소 *',
              style: Get.textTheme.labelSmall,
            ),
            validator: (value) {
              if (value == null) {
                return '상세주소를 입력해주세요';
              }
              if (value.isEmpty) {
                return '상세주소를 입력해주세요';
              } else {
                return null;
              }
            },
          ),
          const SizedBox(
            height: 16,
          ),
          DefaultText(
            '추천인코드',
            style: TextStyle(color: Colors.grey[600], fontSize: 16),
          ),
          const SizedBox(
            height: 4,
          ),
          OutlinedTextField(
            minWidth: 200,
            maxHeight: 100,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            controller: RegisterController.to.referralController,
            formatter: RegisterController.to.referralCodeFormatter,
            labelWidget: Text(
              '추천인 코드',
              style: Get.textTheme.labelSmall,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          DefaultText(
            '사업자등록번호',
            style: TextStyle(color: Colors.grey[600], fontSize: 16),
          ),
          const SizedBox(
            height: 4,
          ),
          OutlinedTextField(
            minWidth: double.infinity,
            maxHeight: 100,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            formatter: businessRegistrationNumberFormatter,
            controller:
                RegisterController.to.businessRegistrationNumberController,
            labelWidget: Text(
              '사업자등록번호 *',
              style: Get.textTheme.labelSmall,
            ),
            validator: (value) {
              if (value == null) {
                return '사업자 등록번호를 입력해주세요';
              }
              if (value.isEmpty) {
                return '사업자 등록번호를 입력해주세요';
              } else {
                return null;
              }
            },
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Get.theme.primaryColorDark),
                onPressed:
                    RegisterController.to.selectBusinessRegistrationCertificate,
                child: Obx(
                  () => RegisterController.to.businessRegistrationCertificate !=
                          null
                      ? DefaultText(
                          RegisterController
                              .to.businessRegistrationCertificate!.path
                              .split('/')
                              .last,
                        )
                      : const DefaultText('사업자등록증 첨부'),
                )),
          ),
        ],
      ),
    );
  }
}
