import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/global/widgets/image_carousel.dart';
import 'package:smarter/app/modules/shop/home_module/controllers/shop_nav_home_controller.dart';
import 'package:smarter/app/modules/shop/home_module/home_query.dart';
import 'package:smarter/app/modules/shop/home_module/widgets/nav_home/notice_item.dart';

class Notice extends StatelessWidget {
  const Notice({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(document: gql(HomeQuery.notices)),
      builder: (QueryResult<Object?> result,
          {Future<QueryResult<Object?>> Function(FetchMoreOptions)? fetchMore,
          Future<QueryResult<Object?>?> Function()? refetch}) {
        if (result.isLoading) {
          return Container();
        }
        List<Map<String, dynamic>> notices = List<Map<String, dynamic>>.from(
            result.data!['notices']['edges'].map((e) => e['node']));

        List<Widget> items =
            List<Widget>.from(notices.map((n) => NoticeItem(notice: n)));

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ImageCarousel(
            autoPlay: false,
            enableInfiniteScroll: false,
            height: 100,
            images: items,
            controller: ShopNavHomeController.to.noticeCarouselController,
            opacity: 0.6,
          ),
        );
      },
    );
  }
}
