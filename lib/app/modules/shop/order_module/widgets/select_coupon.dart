import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/theme/theme.dart';
import 'package:smarter/app/global/utils/format_money.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/shop/order_module/controllers/order_controller.dart';
import 'package:smarter/app/modules/shop/order_module/widgets/select_coupon_bottom_sheet.dart';
import 'package:smarter/graphql_api.dart';

class SelectCoupon extends StatelessWidget {
  const SelectCoupon({
    super.key,
    required this.coupons,
    required this.didUseCouponToday,
  });

  final List<OrderMasterAndAddresses$Query$CouponType> coupons;
  final bool didUseCouponToday;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (OrderController.to.priceTotal < 50000) {
          Get.snackbar('안내', '쿠폰은 주문금액 5만원 이상일 때만 사용가능합니다.');
          return;
        }
        // if (didUseCouponToday) {
        //   Get.snackbar('안내', '쿠폰은 1일 1회만 사용 가능합니다.');
        //   return;
        // }
        Get.bottomSheet(
          backgroundColor: backgroundColor,
          isScrollControlled: true,
          SelectCouponBottomSheet(
            coupons: coupons,
          ),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DefaultText(
            '할인쿠폰',
            style: Get.textTheme.labelLarge,
          ),
          Obx(
            () => OrderController.to.selectedCoupon.value == null
                ? Row(
                    children: [
                      DefaultText('${coupons.length} 개 보유',
                          style:
                              const TextStyle(fontSize: 16, color: textLight)),
                      const FaIcon(
                        FontAwesomeIcons.chevronRight,
                        color: textLight,
                        size: 16,
                      )
                    ],
                  )
                : DefaultText(
                    '- ${formatMoney(OrderController.to.selectedCoupon.value!.price!)} 원',
                    style: const TextStyle(fontSize: 16, color: textLight),
                  ),
          ),
        ],
      ),
    );
  }
}
