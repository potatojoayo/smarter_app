import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class FullImageScreen extends StatelessWidget {
  const FullImageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String url = Get.arguments['url']!;
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.grey[800],
      body: PhotoView(
          imageProvider: NetworkImage(
        url,
      )),
    );
  }
}
