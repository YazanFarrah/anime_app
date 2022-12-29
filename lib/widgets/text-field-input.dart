import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;

  final FormFieldValidator? validator;
  final TextInputType textInputType;
  final FocusNode? focusNode;
  Function(String)? fieldSubmitted;
  final Widget? suffix;
  TextFieldInput({
    super.key,
    this.suffix,
    required this.textEditingController,
    this.isPass = false,
    required this.hintText,
    required this.textInputType,
    this.validator,
    this.focusNode,
    this.fieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
        borderSide: Divider.createBorderSide(context),
        borderRadius: BorderRadius.circular(20.0));
    return TextFormField(
      onFieldSubmitted: fieldSubmitted,
      focusNode: focusNode,
      validator: validator,
      keyboardType: textInputType,
      controller: textEditingController,
      obscureText: isPass,
      decoration: InputDecoration(
        suffix: suffix,
        border: inputBorder,
        focusedBorder: inputBorder,
        labelText: hintText,
        enabledBorder: inputBorder,
        filled: true,
        contentPadding: const EdgeInsets.all(15),
      ),
    );
  }
}
