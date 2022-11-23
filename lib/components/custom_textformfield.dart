import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  Function? validation;
  Function onSave;
  String label;
  bool isPassowrd;
  String? initialValue;
  CustomTextField(
      {Key? key,
      this.validation,
      required this.onSave,
      required this.label,
      this.initialValue,
      this.isPassowrd = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      obscureText: isPassowrd,
      validator: (v) {
        return validation == null ? null : validation!(v);
      },
      onSaved: (v) => onSave(v),
      decoration: InputDecoration(hintText: label),
    );
  }
}
