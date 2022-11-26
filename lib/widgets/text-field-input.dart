import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;

  final FormFieldValidator validator;
  final TextInputType textInputType;
  const TextFieldInput({
    super.key,
    required this.textEditingController,
    this.isPass = false,
    required this.hintText,
    required this.textInputType,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
        borderSide: Divider.createBorderSide(context),
        borderRadius: BorderRadius.circular(20.0));
    return TextFormField(
      validator: validator,
      keyboardType: textInputType,
      controller: textEditingController,
      obscureText: isPass,
      decoration: InputDecoration(
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
