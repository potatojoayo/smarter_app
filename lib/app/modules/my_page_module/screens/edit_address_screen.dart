import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/global/theme/theme.dart';
import 'package:smarter/app/global/utils/phone_formatter.dart';
import 'package:smarter/app/global/utils/show_snack_bar.dart';
import 'package:smarter/app/global/widgets/default_app_bar.dart';
import 'package:smarter/app/global/widgets/default_screen_padding.dart';
import 'package:smarter/app/global/widgets/me_query.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/shop/home_module/widgets/nav_my_page/info_item.dart';
import 'package:smarter/app/modules/my_page_module/address_mutation.dart';
import 'package:smarter/app/modules/my_page_module/controllers/address_controller.dart';

class EditAddressScreen extends StatelessWidget {
  const EditAddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            defaultAppBar(title: '배송지 설정', showActions: false),
            SliverToBoxAdapter(
              child: SingleChildScrollView(
                child: DefaultScreenPadding(
                  child: MeQuery(
                    builder: (me, refetchMe) => Column(
                      children: [
                        Row(
                          children: [
                            InfoItem(
                              label: '배송지명',
                              value: '',
                              width: 100,
                              editing: true,
                              controller:
                                  AddressController.to.addressNameController,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DefaultText(
                                  '기본배송지',
                                  style: Get.textTheme.labelMedium,
                                ),
                                Obx(
                                  () => Checkbox(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(3)),
                                    value: AddressController.to.isDefault.value,
                                    onChanged: (v) => AddressController
                                        .to.isDefault.value = v!,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        InfoItem(
                          label: '받는사람',
                          value: '',
                          width: 100,
                          editing: true,
                          controller: AddressController.to.receiverController,
                        ),
                        InfoItem(
                          label: '전화번호',
                          value: '',
                          width: 100,
                          editing: true,
                          formatter: phoneFormatter,
                          controller: AddressController.to.phoneController,
                        ),
                        Stack(
                          children: [
                            InfoItem(
                              label: '우편번호',
                              value: '',
                              width: 70,
                              editing: true,
                              controller:
                                  AddressController.to.zipCodeController,
                            ),
                            Positioned(
                              left: 100,
                              bottom: 5,
                              child: SizedBox(
                                height: 45,
                                child: ElevatedButton(
                                    onPressed: AddressController
                                        .to.showAddressBottomSheet,
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            Get.theme.primaryColorDark),
                                    child: const DefaultText(
                                      '주소검색',
                                      style: TextStyle(
                                          fontSize: 13, color: backgroundColor),
                                    )),
                              ),
                            ),
                          ],
                        ),
                        InfoItem(
                          label: '주소',
                          value: '',
                          width: double.infinity,
                          editing: true,
                          controller: AddressController.to.addressController,
                        ),
                        InfoItem(
                          label: '상세주소',
                          width: double.infinity,
                          value: '',
                          editing: true,
                          controller:
                              AddressController.to.detailAddressController,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Mutation(
                          options: MutationOptions(
                              document:
                                  gql(AddressMutation.createOrUpdateAddress),
                              onCompleted: (data) {
                                Get.back(result: 'saved');
                                showSnackBar('저장되었습니다.');
                              }),
                          builder: (MultiSourceResult<Object?> Function(
                                      Map<String, dynamic>,
                                      {Object? optimisticResult})
                                  runMutation,
                              QueryResult<Object?>? result) {
                            return SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Get.theme.primaryColorDark),
                                onPressed: () {
                                  final addressName = AddressController
                                      .to.addressNameController.text;
                                  final receiver = AddressController
                                      .to.receiverController.text;
                                  final phone =
                                      AddressController.to.phoneController.text;
                                  final zipCode = AddressController
                                      .to.zipCodeController.text;
                                  final address = AddressController
                                      .to.addressController.text;
                                  final detailAddress = AddressController
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
                                    'addressId': AddressController.to.addressId,
                                    'userId': me['id'],
                                    'name': addressName,
                                    'receiver': receiver,
                                    'phone': phoneFormatter.unmaskText(phone),
                                    'zipCode': zipCode,
                                    'address': address,
                                    'detailAddress': detailAddress,
                                    'default':
                                        AddressController.to.isDefault.value,
                                  });
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
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

/*

 */
