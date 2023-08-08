import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/theme/theme.dart';
import 'package:smarter/app/global/widgets/app_bar_actions.dart';

SliverAppBar defaultAppBar({
  required String title,
  Widget? leading,
  bool centerTitle = false,
  bool showActions = true,
}) =>
    SliverAppBar(
      pinned: true,
      leading: leading,
      iconTheme: const IconThemeData(color: textColor, size: 20),
      centerTitle: centerTitle,
      titleSpacing: 0,
      title: Text(
        title,
        style: Get.textTheme.bodyMedium,
      ),
      actions: showActions ? appBarActions : null,
    );
