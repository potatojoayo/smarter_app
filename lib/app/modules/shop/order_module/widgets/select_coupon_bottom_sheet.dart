import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/theme/theme.dart';
import 'package:smarter/app/global/widgets/coupon_item.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/shop/order_module/controllers/order_controller.dart';
import 'package:smarter/graphql_api.dart';

class SelectCouponBottomSheet extends StatefulWidget {
  const SelectCouponBottomSheet({
    super.key,
    required this.coupons,
  });

  final List<OrderMasterAndAddresses$Query$CouponType> coupons;

  @override
  State<SelectCouponBottomSheet> createState() =>
      _SelectCouponBottomSheetState();
}

class _SelectCouponBottomSheetState extends State<SelectCouponBottomSheet> {
  OrderMasterAndAddresses$Query$CouponType? selectedCoupon;

  @override
  void initState() {
    super.initState();
    selectedCoupon = OrderController.to.selectedCoupon.value;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          SizedBox(
            height: 32,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const FaIcon(
                    FontAwesomeIcons.solidXmarkLarge,
                    size: 20,
                    color: textColor,
                  ),
                ),
                DefaultText(
                  '할인쿠폰',
                  style: Get.textTheme.bodyLarge,
                ),
                const SizedBox()
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ListView.separated(
                separatorBuilder: (_, __) => const SizedBox(
                  height: 8,
                ),
                itemBuilder: (context, index) {
                  final coupon = widget.coupons[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCoupon = coupon;
                      });
                    },
                    child: CouponItem(
                      coupon: coupon,
                      selectedCoupon: selectedCoupon,
                      onSelect: () {
                        setState(() {
                          selectedCoupon = coupon;
                        });
                      },
                    ),
                  );
                },
                itemCount: widget.coupons.length,
                shrinkWrap: true,
              ),
            ),
          ),
          GestureDetector(
              onTap: () {
                if (selectedCoupon != null) {
                  OrderController.to.selectedCoupon.value = selectedCoupon!;
                  Get.back();
                } else {
                  Get.snackbar('선택된 쿠폰이 없습니다.', '사용하실 쿠폰을 선택해주세요.');
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Get.theme.primaryColorDark,
                    borderRadius: BorderRadius.circular(8)),
                height: 56,
                child: const Center(
                  child: DefaultText(
                    '적용',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
