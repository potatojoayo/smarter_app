import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/controllers/image_carousel_controller.dart';
import 'package:smarter/app/global/theme/theme.dart';

class ImageCarousel extends StatelessWidget {
  const ImageCarousel(
      {Key? key,
      required this.images,
      required this.controller,
      this.autoPlay = true,
      this.enableInfiniteScroll = true,
      this.aspectRatio = 16 / 9,
      this.height,
      this.onPageChanged,
      // this.backColor = Colors.black87,
      this.opacity = 0.7})
      : super(key: key);

  final List<Widget> images;
  final ImageCarouselController controller;
  final double aspectRatio;
  final double? height;
  final bool autoPlay;
  final bool enableInfiniteScroll;
  final Function? onPageChanged;
  // final Color backgroundColor;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          items: images,
          options: CarouselOptions(
            onPageChanged: (index, reason) {
              controller.currentCarouselIndex = index;
              if (onPageChanged != null) {
                onPageChanged!(index);
              }
            },
            viewportFraction: 1,
            enableInfiniteScroll: enableInfiniteScroll,
            aspectRatio: aspectRatio,
            height: height,
            autoPlay: autoPlay,
          ),
        ),
        Positioned(
          bottom: 15,
          right: 30,
          child: Obx(
            () => Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black87.withOpacity(opacity),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  '${controller.currentCarouselIndex + 1}/${images.length}',
                  style: const TextStyle(color: backgroundColor, fontSize: 15),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
