import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/global/widgets/image_carousel.dart';
import 'package:smarter/app/global/widgets/my_query.dart';
import 'package:smarter/app/modules/shop/home_module/controllers/shop_nav_home_controller.dart';
import 'package:smarter/app/modules/shop/home_module/home_query.dart';

class BannerCarousel extends StatelessWidget {
  const BannerCarousel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyQuery(
      query: HomeQuery.banners,
      fetchPolicy: FetchPolicy.cacheAndNetwork,
      builder: (result) {
        List<Widget> banners = List<Widget>.from(
          result.data!['banners'].map(
            (b) => Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 3,
                  color: Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(16.0),
              ),
              padding: const EdgeInsets.all(4),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Image.network(
                  b['image'],
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        );
        return ImageCarousel(
          images: banners,
          controller: ShopNavHomeController.to.bannerCarouselController,
        );
      },
    );
  }
}
