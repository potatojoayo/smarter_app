import 'package:flutter/material.dart';
import 'package:smarter/app/global/widgets/outlined_textfield.dart';

class CartedNames extends StatelessWidget {
  const CartedNames({
    Key? key,
    required this.names,
  }) : super(key: key);

  final List<Map<String, dynamic>> names;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        height: 48,
        child: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(
            width: 8,
          ),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: names.length,
          itemBuilder: (context, index) {
            final name = names[index];
            return OutlinedTextField(
              minWidth: 60,
              initialValue: name['name'],
              onChanged: (value) {
                name['name'] = value;
              },
            );
          },
        ),
      ),
    );
  }
}
