import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smarter/app/global/utils/format_money.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/graphql_api.dart';

class CouponItem extends StatelessWidget {
  const CouponItem({
    super.key,
    required this.coupon,
    this.selectedCoupon,
    this.onSelect,
  });

  final OrderMasterAndAddresses$Query$CouponType coupon;
  final OrderMasterAndAddresses$Query$CouponType? selectedCoupon;
  final Function? onSelect;

  bool get disabled {
    final now = DateTime.now();
    return now.isAfter(coupon.endOfUse!) || coupon.dateUsed != null;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          margin: const EdgeInsets.all(8),
          width: double.infinity,
          height: 180,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(2, 2),
                blurRadius: 8,
              ),
            ],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultText(
                    formatMoney(coupon.price!),
                    style: const TextStyle(color: Colors.orange, fontSize: 32),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  DefaultText(
                    coupon.couponMaster.name!,
                    style: Get.textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  DefaultText(
                    '만료일: ${DateFormat('yyyy-MM-dd').format(coupon.endOfUse!)}',
                    style: TextStyle(color: Colors.grey[500], fontSize: 16),
                  ),
                ],
              ),
              onSelect != null && !disabled
                  ? Radio<OrderMasterAndAddresses$Query$CouponType>(
                      value: coupon,
                      groupValue: selectedCoupon,
                      onChanged:
                          (OrderMasterAndAddresses$Query$CouponType? selected) {
                        onSelect!();
                      })
                  : Container(),
            ],
          ),
        ),
        if (disabled)
          Container(
            padding: const EdgeInsets.all(24),
            margin: const EdgeInsets.all(8),
            width: double.infinity,
            height: 180,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(.5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: DefaultText(
                coupon.dateUsed != null ? '사용' : '만료',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
      ],
    );
  }
}
