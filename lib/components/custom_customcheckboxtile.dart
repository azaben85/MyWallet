// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomCheckBoxTile extends StatelessWidget {
  Function onChanged;
  bool value;
  String label;
  CustomCheckBoxTile({
    Key? key,
    required this.onChanged,
    required this.value,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(label),
      value: value,
      onChanged: (value) => onChanged(value),
    );
  }
}
