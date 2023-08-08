import 'package:flutter/material.dart';
import 'package:smarter/app/global/widgets/text.dart';

class ProductName extends StatelessWidget {
  const ProductName({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Map<String, dynamic> product;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DefaultText(
          product['name'],
          style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
          overflow: TextOverflow.visible,
        ),
      ],
    );
  }
}
