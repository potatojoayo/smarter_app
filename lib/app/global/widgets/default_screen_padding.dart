import 'package:flutter/material.dart';

class DefaultScreenPadding extends StatelessWidget {
  const DefaultScreenPadding({
    Key? key,
    required this.child,
    this.vertical = 0,
    this.enableHorizontal = true,
  }) : super(key: key);

  final Widget child;
  final double vertical;
  final bool enableHorizontal;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: enableHorizontal ? 20 : 0, vertical: vertical),
      child: child,
    );
  }
}
