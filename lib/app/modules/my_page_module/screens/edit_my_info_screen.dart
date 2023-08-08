import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:smarter/app/global/utils/business_registration_number_formatter.dart';
import 'package:smarter/app/global/utils/show_snack_bar.dart';
import 'package:smarter/app/global/widgets/default_screen_padding.dart';
import 'package:smarter/app/global/widgets/edit_text.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/auth_module/auth_mutation.dart';
import 'package:smarter/app/modules/auth_module/auth_query.dart';
import 'package:smarter/app/modules/my_page_module/controllers/edit_my_info_controller.dart';

class EditMyInfoScreen extends GetView<EditMyInfoController> {
  const EditMyInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Query(
        options: QueryOptions(document: gql(AuthQuery.me)),
        builder: (QueryResult<Object?> result,
            {Future<QueryResult<Object?>> Function(FetchMoreOptions)? fetchMore,
            Future<QueryResult<Object?>?> Function()? refetch}) {
          if (result.isLoading) {
            return Container();
          }

          if (result.data == null) {
            return Container();
          }

          Map<String, dynamic> user = result.data!['me'];
          controller.setUserToController(user);

          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
                appBar: AppBar(
                  title: DefaultText(
                    '내 정보 수정',
                    style: Get.textTheme.bodyMedium,
                  ),
                ),
                body: SingleChildScrollView(
                  child: DefaultScreenPadding(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: GestureDetector(
                            onTap: () async {
                              if (await controller.uploadImage()) {
                                refetch!();
                              }
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12,
                                      offset: Offset(2, 2),
                                      blurRadius: 4),
                                ],
                              ),
                              width: 112,
                              height: 112,
                              child: Center(
                                child: user['profileImage'] != null
                                    ? CircleAvatar(
                                        radius: 80,
                                        backgroundImage:
                                            NetworkImage(user['profileImage']),
                                      )
                                    : FaIcon(
                                        FontAwesomeIcons.user,
                                        color: Colors.grey[600],
                                      ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        EditText(
                            title: '학원명',
                            controller: controller.gymTextEditingController),
                        const SizedBox(
                          height: 16,
                        ),
                        EditText(
                          title: '사업자\n등록번호',
                          controller: controller
                              .businessRegistrationNumberTextEditingController,
                          textInputType: TextInputType.number,
                          inputFormatters: [
                            businessRegistrationNumberFormatter
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border:
                                Border.all(width: 1, color: Colors.grey[500]!),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                width: 80,
                                height: 64,
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  border: Border(
                                    right: BorderSide(
                                      width: 1,
                                      color: Colors.grey[500]!,
                                    ),
                                  ),
                                ),
                                child: Center(
                                  child: DefaultText(
                                    '사업자\n등록증',
                                    style: Get.textTheme.labelLarge,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: TextField(
                                  controller: controller
                                      .businessRegistrationCertificateTextEditingController,
                                  enabled: false,
                                  style: const TextStyle(fontSize: 16),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: controller
                                    .selectBusinessRegistrationCertificate,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: FaIcon(
                                    FontAwesomeIcons.upload,
                                    size: 24,
                                    color: Get.theme.primaryColorDark,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        EditText(
                          title: '대표자명',
                          controller: controller.nameTextEditingController,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        EditText(
                          title: '연락처',
                          textInputType: TextInputType.number,
                          controller: controller.phoneTextEditingController,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        EditText(
                          title: '아이디용\n이메일',
                          textInputType: TextInputType.emailAddress,
                          controller: controller.emailTextEditingController,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border:
                                Border.all(width: 1, color: Colors.grey[500]!),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                width: 80,
                                height: 64,
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  border: Border(
                                    right: BorderSide(
                                      width: 1,
                                      color: Colors.grey[500]!,
                                    ),
                                  ),
                                ),
                                child: Center(
                                  child: DefaultText(
                                    '주소',
                                    style: Get.textTheme.labelLarge,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: TextField(
                                  controller:
                                      controller.addressTextEditingController,
                                  enabled: false,
                                  style: const TextStyle(fontSize: 16),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller.showAddressBottomSheet();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: FaIcon(
                                    FontAwesomeIcons.solidMagnifyingGlass,
                                    size: 24,
                                    color: Get.theme.primaryColorDark,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        EditText(
                          title: '상세주소',
                          controller:
                              controller.detailAddressTextEditingController,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const DefaultText('원비입금계좌'),
                        const SizedBox(
                          height: 16,
                        ),
                        EditText(
                          title: '은행명',
                          controller: controller.classPaymentBankNameController,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        EditText(
                          title: '계좌번호',
                          textInputType: TextInputType.number,
                          controller:
                              controller.classPaymentBankAccountNoController,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        EditText(
                          title: '예금주명',
                          controller:
                              controller.classPaymentBankOwnerNameController,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const DefaultText('환불계좌'),
                        const SizedBox(
                          height: 16,
                        ),
                        EditText(
                          title: '은행명',
                          controller: controller.refundBankNameController,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        EditText(
                          title: '계좌번호',
                          textInputType: TextInputType.number,
                          controller: controller.refundBankAccountNoController,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        EditText(
                          title: '예금주명',
                          controller: controller.refundBankOwnerNameController,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Mutation(
                          options: MutationOptions(
                              document: gql(AuthMutation.createOrUpdateGym),
                              onCompleted: (data) {
                                Get.back(result: 'saved');
                                if (controller.event) {
                                  showSnackBar('이벤트 쿠폰이 발급되었습니다!');
                                } else {
                                  showSnackBar('저장되었습니다.');
                                }
                              }),
                          builder: (MultiSourceResult<Object?> Function(
                                      Map<String, dynamic>,
                                      {Object? optimisticResult})
                                  runMutation,
                              QueryResult<Object?>? result) {
                            return SizedBox(
                              width: double.infinity,
                              child: RoundedLoadingButton(
                                controller: controller.loadingButtonController,
                                color: Get.theme.primaryColorDark,
                                valueColor: Colors.white,
                                elevation: 0,
                                onPressed: () {
                                  controller.save(runMutation);
                                },
                                child: const DefaultText(
                                  '저장',
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                )),
          );
        });
  }
}
