import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  Function? validation;
  Function? onSave;
  String label;
  bool isPassowrd;
  String? initialValue;
  TextInputType? textInputType;
  TextEditingController? contoller;
  CustomTextField(
      {Key? key,
      this.validation,
      this.onSave,
      required this.label,
      this.initialValue,
      this.isPassowrd = false,
      this.textInputType = TextInputType.text,
      this.contoller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (contoller == null) {
      return Container(
        margin: const EdgeInsets.only(right: 2, left: 2),
        child: TextFormField(
          keyboardType: textInputType!,
          initialValue:
              (initialValue ?? '') == 'null' ? '' : initialValue ?? '',
          obscureText: isPassowrd,
          validator: (v) {
            return validation == null ? null : validation!(v);
          },
          onSaved: (v) {
            if (onSave == null) {
              return null;
            } else {
              return onSave!(v);
            }
          },
          decoration: InputDecoration(hintText: label),
        ),
      );
    }
    return Container(
      margin: const EdgeInsets.only(right: 2, left: 2),
      child: TextFormField(
        controller: contoller!,
        keyboardType: textInputType!,
        initialValue: initialValue,
        obscureText: isPassowrd,
        validator: (v) {
          return validation == null ? null : validation!(v);
        },
        decoration: InputDecoration(hintText: label),
      ),
    );
  }
}
