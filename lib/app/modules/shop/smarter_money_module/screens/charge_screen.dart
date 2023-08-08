import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/utils/format_money.dart';
import 'package:smarter/app/global/utils/money_formatter.dart';
import 'package:smarter/app/global/utils/show_snack_bar.dart';
import 'package:smarter/app/global/widgets/default_app_bar.dart';
import 'package:smarter/app/global/widgets/default_screen_padding.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/shop/order_module/select_pay_method.dart';
import 'package:smarter/app/modules/shop/payment_module/widgets/pay_agreement.dart';
import 'package:smarter/app/modules/shop/smarter_money_module/controllers/charge_controller.dart';

class ChargeScreen extends StatefulWidget {
  const ChargeScreen({Key? key}) : super(key: key);

  @override
  State<ChargeScreen> createState() => _ChargeScreenState();
}

class _ChargeScreenState extends State<ChargeScreen> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            defaultAppBar(title: '스마터머니 충전', showActions: false),
            SliverToBoxAdapter(
              child: DefaultScreenPadding(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const DefaultText('얼마를 충전할까요?'),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: ChargeController.to.amountController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [moneyFormatter],
                      onChanged: (value) {
                        int number =
                            moneyFormatter.getUnformattedValue() as int;
                        if (number > 100000) {
                          number = 100000;
                          ChargeController.to.amountController.text =
                              '₩100,000';
                          ChargeController.to.amountController.selection =
                              TextSelection.fromPosition(TextPosition(
                                  offset: ChargeController
                                      .to.amountController.text.length));
                        }
                        ChargeController.to.priceToPay = number;
                      },
                      decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(),
                        hintText: '₩0',
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    SelectPayMethod(
                      controller: ChargeController.to,
                    ),
                    const Divider(
                      height: 40,
                    ),
                    PayAgreement(
                      controller: ChargeController.to,
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (!ChargeController.to.agreed) {
                          return showSnackBar('구매조건 및 결제진행 동의가 필요합니다.');
                        }
                        if (ChargeController.to.selectedMethod == '카드' &&
                            ChargeController.to.priceToPay < 1000) {
                          loading = false;
                          return showSnackBar(
                              '1,000원 미만의 주문은 카드를 사용하실 수 없습니다.');
                        }
                        if (!loading) {
                          setState(() {
                            loading = true;
                          });
                          await ChargeController.to.onPressedPayButton();
                          setState(() {
                            loading = false;
                          });
                        }
                      },
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: Get.theme.primaryColorDark,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: loading
                              ? const SpinKitRing(
                                  color: Colors.white,
                                  size: 24,
                                  lineWidth: 4,
                                )
                              : Obx(
                                  () => DefaultText(
                                    '${formatMoney(ChargeController.to.priceToPay)} 결제하기',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
