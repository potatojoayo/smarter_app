import 'package:flutter/material.dart';
import 'package:smarter/app/global/widgets/app_bar_actions.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      centerTitle: true,
      title: SizedBox(
        height: 15,
        child: Image.asset('assets/icon/logo.png'),
      ),
      toolbarHeight: 50,
      titleTextStyle: const TextStyle(fontSize: 24),
      pinned: true,
      actions: appBarActions,
      titleSpacing: 0,
    );
  }
}
