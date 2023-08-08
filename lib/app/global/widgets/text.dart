import 'package:flutter/material.dart';

class DefaultText extends StatelessWidget {
  const DefaultText(this.contents,
      {super.key,
      this.maxLines,
      this.style,
      this.textAlign,
      this.overflow = TextOverflow.ellipsis});

  final String contents;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextOverflow overflow;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      contents,
      style: style,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
    );
  }
}
