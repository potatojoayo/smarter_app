import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/data/provider/artemis_client.dart';
import 'package:smarter/app/data/provider/client.dart';
import 'package:smarter/app/global/utils/extract_number.dart';
import 'package:smarter/app/global/utils/format_money.dart';
import 'package:smarter/app/global/utils/money_formatter.dart';
import 'package:smarter/app/global/utils/phone_formatter.dart';
import 'package:smarter/app/global/utils/show_snack_bar.dart';
import 'package:smarter/app/modules/auth_module/controllers/auth_controller.dart';
import 'package:smarter/app/modules/shop/cart_module/controllers/cart_controller.dart';
import 'package:smarter/app/modules/shop/order_module/order_mutation.dart';
import 'package:smarter/app/modules/shop/payment_module/mixins/payment_mixin.dart';
import 'package:smarter/app/modules/shop/smarter_money_module/controllers/smarter_money_controller.dart';
import 'package:smarter/app/routes/routes.dart';
import 'package:smarter/graphql_api.dart';

class OrderController extends GetxController with PaymentMixin {
  static OrderController get to => Get.find();

  @override
  void onInit() async {
    await SmarterMoneyController.to.getSmarterMoney();
    super.onInit();
    ever(usingSmarterMoney, (int value) {
      priceToPay = priceTotal -
          value -
          (selectedCoupon.value != null ? selectedCoupon.value!.price! : 0);
    });
    ever(selectedCoupon, (OrderMasterAndAddresses$Query$CouponType? value) {
      if (value != null) {
        priceToPay = priceTotal - usingSmarterMoney.value - value.price!;
        if (priceToPay < 0) {
          if (usingSmarterMoney.value > -priceToPay) {
            usingSmarterMoney.value += priceToPay;
            print(usingSmarterMoney.value);
            smarterMoneyController.text = formatMoney(usingSmarterMoney.value);
          }
          priceToPay = 0;
        }
      }
    });
  }

  final selectedCoupon = Rx<OrderMasterAndAddresses$Query$CouponType?>(null);

  final _priceTotal = 0.obs;

  int get priceTotal => _priceTotal.value;

  set priceTotal(value) => _priceTotal.value = value;

  final _order = Rx<Map<String, dynamic>>({});

  Map<String, dynamic> get order => _order.value;

  set order(value) => _order.value = value;

  final receiverController = TextEditingController();

  final phoneController = TextEditingController();

  final zipCodeController = TextEditingController();

  final addressController = TextEditingController();

  final detailAddressController = TextEditingController();

  final deliveryRequestController = TextEditingController();

  final smarterMoneyController = TextEditingController();

  final usingSmarterMoney = 0.obs;

  final selectedAddress = Rx<Map<String, dynamic>?>(null);

  get additionalDeliveryPrice => 0;

  @override
  void onSuccess(String orderId) async {
    // final result = await Client().client.value.mutate(MutationOptions(
    //         document: gql(OrderMutation.completePayment),
    //         variables: {
    //           "orderNumber": orderId,
    //           'smarterMoney': int.parse(
    //               OrderController.to.smarterMoneyController.text.isEmpty
    //                   ? '0'
    //                   : extractNumber(
    //                       OrderController.to.smarterMoneyController.text)),
    //           'receiver': receiverController.text,
    //           'phone': phoneFormatter.unmaskText(phoneController.text),
    //           'zipCode': zipCodeController.text,
    //           'address': addressController.text,
    //           'detailAddress': detailAddressController.text,
    //           'deliveryRequest': deliveryRequestController.text
    //         }));
    AuthController.to.mixpanel.track('카드결제', properties: {
      "orderNumber": orderId,
      'smarterMoney': int.parse(
          OrderController.to.smarterMoneyController.text.isEmpty
              ? '0'
              : extractNumber(OrderController.to.smarterMoneyController.text)),
      'receiver': receiverController.text,
      'phone': phoneFormatter.unmaskText(phoneController.text),
      'zipCode': zipCodeController.text,
      'address': addressController.text,
      'detailAddress': detailAddressController.text,
      'deliveryRequest': deliveryRequestController.text
    });
    CartController.to.emptyCart();
    CartController.to.isPickUp.value = false;
    await Get.offNamedUntil('${Routes.orderDetail}/$orderId',
        (route) => route.settings.name == Routes.shop,
        arguments: {'ordered': true});
  }

  @override
  Future<void> pay() async {
    if (usingSmarterMoney >
        priceTotal -
            (selectedCoupon.value != null ? selectedCoupon.value!.price! : 0)) {
      return showSnackBar('스마터머니 사용 금액이 결제할 금액보다 큽니다.');
    }
    if (selectedMethod == '무통장입금') {
      final result = await Client().client.value.mutate(MutationOptions(
              document: gql(OrderMutation.depositWithoutAccount),
              variables: {
                'orderMasterId': order['id'],
                'smarterMoney': int.parse(
                    OrderController.to.smarterMoneyController.text.isEmpty
                        ? '0'
                        : extractNumber(
                            OrderController.to.smarterMoneyController.text)),
                'receiver': selectedAddress.value!['receiver'],
                'phone': selectedAddress.value!['phone'],
                'zipCode': selectedAddress.value!['zipCode'],
                'address': selectedAddress.value!['address'],
                'couponId': selectedCoupon.value?.id,
                'detailAddress': selectedAddress.value!['detailAddress'],
                'deliveryRequest': deliveryRequestController.text
              }));
      if (result.data!['depositWithoutAccount']['success']) {
        AuthController.to.mixpanel.track('무통장입금 결제', properties: {
          'orderMasterId': order['id'],
          'smarterMoney': int.parse(OrderController
                  .to.smarterMoneyController.text.isEmpty
              ? '0'
              : extractNumber(OrderController.to.smarterMoneyController.text)),
          'receiver': receiverController.text,
          'phone': phoneFormatter.unmaskText(phoneController.text),
          'zipCode': zipCodeController.text,
          'address': addressController.text,
          'detailAddress': detailAddressController.text,
          'deliveryRequest': deliveryRequestController.text
        });
        final orderMaster =
            result.data!['depositWithoutAccount']['orderMaster'];
        CartController.to.emptyCart();
        Get.offNamedUntil('${Routes.orderDetail}/${orderMaster['id']}',
            (route) => route.settings.name == Routes.shop);
      }
    } else if (selectedMethod == '카드') {
      showPayBottomSheet(
        orderId: order['orderNumber'],
        amount: priceToPay,
        orderName: order['orderName'],
      );
    } else {
      final result = await Client().client.value.mutate(MutationOptions(
              document: OrderBySmarterMoneyMutation(
                variables: OrderBySmarterMoneyArguments(
                    orderMasterId: int.parse(order['id']),
                    smarterMoney: int.parse(
                      OrderController.to.smarterMoneyController.text.isEmpty
                          ? '0'
                          : extractNumber(
                              OrderController.to.smarterMoneyController.text,
                            ),
                    ),
                    receiver: selectedAddress.value!['receiver'],
                    phone: selectedAddress.value!['phone'],
                    zipCode: selectedAddress.value!['zipCode'],
                    address: selectedAddress.value!['address'],
                    couponId: selectedCoupon.value != null
                        ? int.parse(selectedCoupon.value!.id)
                        : null,
                    detailAddress: selectedAddress.value!['detailAddress'],
                    deliveryRequest: deliveryRequestController.text),
              ).document,
              variables: {
                'orderMasterId': order['id'],
                'smarterMoney': int.parse(
                    OrderController.to.smarterMoneyController.text.isEmpty
                        ? '0'
                        : extractNumber(
                            OrderController.to.smarterMoneyController.text)),
                'receiver': selectedAddress.value!['receiver'],
                'phone': selectedAddress.value!['phone'],
                'zipCode': selectedAddress.value!['zipCode'],
                'address': selectedAddress.value!['address'],
                'couponId': selectedCoupon.value?.id,
                'detailAddress': selectedAddress.value!['detailAddress'],
                'deliveryRequest': deliveryRequestController.text
              }));

      if (result.data!['orderBySmarterMoney']['success']) {
        final orderMaster = result.data!['orderBySmarterMoney']['orderMaster'];
        CartController.to.emptyCart();
        Get.offNamedUntil('${Routes.orderDetail}/${orderMaster['id']}',
            (route) => route.settings.name == Routes.shop);
      }
    }
  }

  changeDeliveryAddress(Map<String, dynamic> address) async {
    selectedAddress.value = address;
    final client = Artemis().client;
    await client.execute(
      ChangeOrderDeliveryMutation(
        variables: ChangeOrderDeliveryArguments(
          orderMasterId: int.parse(order['id']!),
          addressId: int.parse(address['id']!),
        ),
      ),
    );
  }
}
