import 'package:flutter/material.dart';

class TextFormComponent extends StatelessWidget {
  final String labelText;
  final TextInputAction? textInputAction;
  final TextInputType keyboardType;

  const TextFormComponent({
    Key? key,
    required this.labelText,
    this.textInputAction,
    required this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
      ),
      textInputAction: textInputAction,
      keyboardType: keyboardType,
    );
  }
}
