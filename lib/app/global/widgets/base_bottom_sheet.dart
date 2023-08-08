import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/theme/theme.dart';

class BaseBottomSheet extends StatelessWidget {
  const BaseBottomSheet({
    Key? key,
    required this.body,
    this.bottom = const SizedBox.shrink(),
    this.top = const SizedBox.shrink(),
    this.bodyHeight,
    this.height,
  }) : super(key: key);
  final Widget body;
  final Widget bottom;
  final Widget top;
  final double? bodyHeight;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? MediaQuery.of(context).size.height * 0.9,
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                height: 30,
                child: IconButton(
                  onPressed: () => Get.back(),
                  icon: const FaIcon(
                    FontAwesomeIcons.chevronDown,
                    size: 25,
                    color: textColor,
                  ),
                ),
              ),
              top,
              SizedBox(
                height: bodyHeight,
                child: body,
              ),
            ],
          ),
          const Spacer(),
          bottom,
        ],
      ),
    );
  }
}
