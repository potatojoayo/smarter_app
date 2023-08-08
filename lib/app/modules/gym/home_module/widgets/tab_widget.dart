import 'package:flutter/material.dart';

class TabWidget extends StatelessWidget {
  TabWidget({
    super.key,
    this.fontWeight = FontWeight.normal,
    required this.text,
  });

  final String text;
  FontWeight fontWeight = FontWeight.normal;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: Text(
          text,
          style: TextStyle(fontSize: 16, fontWeight: fontWeight),
        ),
      ),
    );
  }
}
