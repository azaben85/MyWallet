import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  Function validation;
  Function onSave;
  String label;
  bool isPassowrd;
  CustomTextField(
      {Key? key,
      required this.validation,
      required this.onSave,
      required this.label,
      this.isPassowrd = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassowrd,
      validator: (v) => validation(v),
      onSaved: (v) => onSave(v),
      decoration: InputDecoration(hintText: label),
    );
  }
}
