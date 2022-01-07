import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormComponent extends StatelessWidget {
  final String labelText;
  final TextInputAction? textInputAction;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final void Function(String)? onFieldSubmitted;
  final int? maxLines;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final String? initialValue;
  final bool obscureText;

  const TextFormComponent({
    Key? key,
    required this.labelText,
    this.textInputAction,
    required this.keyboardType,
    this.inputFormatters,
    this.controller,
    this.focusNode,
    this.onFieldSubmitted,
    this.maxLines = 1,
    this.onSaved,
    this.validator,
    this.initialValue,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
      ),
      initialValue: initialValue,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      controller: controller,
      focusNode: focusNode,
      onFieldSubmitted: onFieldSubmitted,
      maxLines: maxLines,
      onSaved: onSaved,
      validator: validator,
      obscureText: obscureText,
    );
  }
}
