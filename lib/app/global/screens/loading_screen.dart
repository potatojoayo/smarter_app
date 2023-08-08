import 'package:flutter/material.dart';
import 'package:smarter/app/global/widgets/text.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          DefaultText('로딩화면'),
        ],
      ),
    );
  }
}
