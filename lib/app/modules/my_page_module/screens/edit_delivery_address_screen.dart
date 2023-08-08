import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/global/controllers/edit_delivery_address_controller.dart';
import 'package:smarter/app/global/utils/show_snack_bar.dart';
import 'package:smarter/app/global/widgets/default_app_bar.dart';
import 'package:smarter/app/global/widgets/default_screen_padding.dart';
import 'package:smarter/app/global/widgets/edit_text.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/my_page_module/address_mutation.dart';
import 'package:smarter/graphql_api.dart';

class EditDeliveryAddressScreen extends StatelessWidget {
  const EditDeliveryAddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          defaultAppBar(
            title: '배송지 수정',
            showActions: false,
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const FaIcon(
                FontAwesomeIcons.chevronLeft,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              child: DefaultScreenPadding(
                child: Column(
                  children: [
                    EditText(
                      title: '배송지명',
                      controller: EditDeliveryAddressController
                          .to.addressNameController,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    EditText(
                        title: '수취인',
                        controller: EditDeliveryAddressController
                            .to.receiverController),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey[500]!),
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
                              controller: EditDeliveryAddressController
                                  .to.addressController,
                              enabled: false,
                              style: const TextStyle(fontSize: 16),
                              maxLines: 3,
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
                              EditDeliveryAddressController.to
                                  .showAddressBottomSheet();
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
                        controller: EditDeliveryAddressController
                            .to.detailAddressController),
                    const SizedBox(
                      height: 16,
                    ),
                    EditText(
                      title: '휴대폰',
                      textInputType: TextInputType.number,
                      controller:
                          EditDeliveryAddressController.to.phoneController,
                      inputFormatters: [
                        EditDeliveryAddressController.to.phoneFormatter
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Obx(() => Transform.scale(
                              scale: 1.5,
                              child: Checkbox(
                                  activeColor: Get.theme.primaryColorDark,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4)),
                                  side: BorderSide(
                                      width: 1, color: Colors.grey[600]!),
                                  value: EditDeliveryAddressController
                                      .to.isDefault.value,
                                  onChanged: (value) {
                                    EditDeliveryAddressController
                                        .to.isDefault.value = value!;
                                  }),
                            )),
                        GestureDetector(
                          onTap: () {
                            EditDeliveryAddressController.to.isDefault.value =
                                !EditDeliveryAddressController
                                    .to.isDefault.value;
                          },
                          child: DefaultText(
                            '기본 배송지로 선택',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Mutation(
                      options: MutationOptions(
                          document: gql(AddressMutation.createOrUpdateAddress),
                          onCompleted: (data) {
                            Get.back(result: 'saved');
                            showSnackBar('저장되었습니다.');
                          }),
                      builder: (MultiSourceResult<Object?> Function(
                                  Map<String, dynamic>,
                                  {Object? optimisticResult})
                              runMutation,
                          QueryResult<Object?>? result) {
                        return GestureDetector(
                          onTap: () {
                            final addressName = EditDeliveryAddressController
                                .to.addressNameController.text;
                            final receiver = EditDeliveryAddressController
                                .to.receiverController.text;
                            final phone = EditDeliveryAddressController
                                .to.phoneController.text;
                            final zipCode = EditDeliveryAddressController
                                .to.zipCodeController.text;
                            final address = EditDeliveryAddressController
                                .to.addressController.text;
                            final detailAddress = EditDeliveryAddressController
                                .to.detailAddressController.text;
                            if (addressName.isEmpty ||
                                receiver.isEmpty ||
                                phone.isEmpty ||
                                zipCode.isEmpty ||
                                address.isEmpty ||
                                detailAddress.isEmpty) {
                              showSnackBar('모든 항목을 입력해주세요');
                              return;
                            }
                            runMutation({
                              'addressId':
                                  EditDeliveryAddressController.to.addressId,
                              'name': addressName,
                              'receiver': receiver,
                              'phone': EditDeliveryAddressController
                                  .to.phoneFormatter
                                  .unmaskText(phone),
                              'zipCode': zipCode,
                              'address': address,
                              'detailAddress': detailAddress,
                              'default': EditDeliveryAddressController
                                  .to.isDefault.value,
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Get.theme.primaryColorDark,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: DefaultText(
                                '저장',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    EditDeliveryAddressController.to.addressId != null
                        ? Mutation(
                            options: MutationOptions(
                                document: DeleteAddressMutation(
                                        variables: DeleteAddressArguments(
                                            addressId:
                                                EditDeliveryAddressController
                                                    .to.addressId!))
                                    .document,
                                onCompleted: (_) {
                                  Get.back();
                                  showSnackBar('배송지가 삭제되었습니다.');
                                }),
                            builder: (MultiSourceResult<Object?> Function(
                                        Map<String, dynamic>,
                                        {Object? optimisticResult})
                                    runMutation,
                                QueryResult<Object?>? result) {
                              return GestureDetector(
                                onTap: () {
                                  showCupertinoDialog(
                                      context: context,
                                      barrierDismissible: true,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: DefaultText(
                                            '배송지를 삭제하시겠습니까?',
                                            style: TextStyle(
                                                color: Colors.grey[800],
                                                fontSize: 24),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Get.back();
                                              },
                                              child: const DefaultText('취소'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                if (EditDeliveryAddressController
                                                    .to.isDefault.value) {
                                                  Get.back();
                                                  return showSnackBar(
                                                      '기본배송지는 삭제할 수 없습니다.');
                                                }
                                                Get.back();
                                                runMutation({
                                                  'addressId':
                                                      EditDeliveryAddressController
                                                          .to.addressId
                                                });
                                              },
                                              child: const DefaultText(
                                                '삭제',
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                            ),
                                          ],
                                        );
                                      });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 1),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Center(
                                    child: DefaultText(
                                      '삭제',
                                    ),
                                  ),
                                ),
                              );
                            })
                        : Container()
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
