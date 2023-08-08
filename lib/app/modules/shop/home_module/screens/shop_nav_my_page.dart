import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/global/theme/theme.dart';
import 'package:smarter/app/global/widgets/default_screen_padding.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/auth_module/auth_query.dart';
import 'package:smarter/app/modules/auth_module/controllers/auth_controller.dart';
import 'package:smarter/app/modules/shop/home_module/widgets/nav_my_page/menu_list_item.dart';
import 'package:smarter/app/modules/shop/home_module/widgets/nav_my_page/my_info.dart';
import 'package:smarter/app/routes/routes.dart';
import 'package:url_launcher/url_launcher.dart';

class ShopNavMyPage extends StatelessWidget {
  const ShopNavMyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Query(
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

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyInfo(user: user, refetch: refetch),
                const SizedBox(
                  height: 8,
                ),
                DefaultScreenPadding(
                  child: Column(
                    children: [
                      MenuListItem(
                        iconData: FontAwesomeIcons.solidTruck,
                        name: '주문 · 배송',
                        onPressed: () => Get.toNamed(Routes.orderAndDelivery),
                      ),
                      MenuListItem(
                        iconData: FontAwesomeIcons.solidCartShoppingFast,
                        name: '간편주문 내역',
                        onPressed: () => Get.toNamed(Routes.easyOrders),
                      ),
                      MenuListItem(
                        iconData: FontAwesomeIcons.solidShirt,
                        name: '내 로고시안',
                        onPressed: () => Get.toNamed(Routes.myDrafts),
                      ),
                      MenuListItem(
                        iconData: FontAwesomeIcons.creditCard,
                        name: '스마터머니',
                        onPressed: () => Get.toNamed(Routes.smarterMoney),
                      ),
                      MenuListItem(
                        iconData: FontAwesomeIcons.mapLocation,
                        name: '배송지 설정',
                        onPressed: () => Get.toNamed(
                            Routes.changeDeliveryAddress,
                            arguments: {'selectable': false}),
                      ),
                      MenuListItem(
                        iconData: FontAwesomeIcons.solidLockKeyhole,
                        name: '비밀번호 변경',
                        onPressed: () => Get.toNamed(Routes.changePassword),
                      ),
                      MenuListItem(
                        iconData: FontAwesomeIcons.solidCircleQuestion,
                        name: '고객센터',
                        onPressed: () => Get.toNamed(Routes.faq),
                      ),
                      MenuListItem(
                        iconData: FontAwesomeIcons.userPen,
                        name: '개인정보 수집 및 이용',
                        onPressed: () {
                          final Uri url = Uri.parse(
                              'https://blocket.co.kr/asset/smarter_privacy.html');
                          launchUrl(url);
                        },
                      ),
                      MenuListItem(
                        iconData: FontAwesomeIcons.book,
                        name: '서비스 이용 약관',
                        onPressed: () {
                          final Uri url = Uri.parse(
                              'https://blocket.co.kr/asset/smarter_agreement.html');
                          launchUrl(url);
                        },
                      ),
                      MenuListItem(
                        iconData: FontAwesomeIcons.solidRightFromBracket,
                        name: '로그아웃',
                        onPressed: AuthController.to.logout,
                      ),
                      MenuListItem(
                        iconData: FontAwesomeIcons.ban,
                        name: '회원탈퇴',
                        onPressed: () {
                          Get.defaultDialog(
                            title: '회원탈퇴',
                            middleText: '회원을 탈퇴하시겠습니까?',
                            titlePadding: const EdgeInsets.only(top: 20),
                            titleStyle: Get.textTheme.labelMedium,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 30),
                            middleTextStyle: const TextStyle(
                              fontSize: 16,
                            ),
                            confirm: TextButton(
                              onPressed: AuthController.to.withdraw,
                              child: const DefaultText('네'),
                            ),
                            cancel: TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const DefaultText(
                                '아니오',
                                style: TextStyle(color: errorColor),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
