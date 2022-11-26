import 'package:flutter/material.dart';

class EditIconWidget extends StatelessWidget {
  Function? onTap;
  EditIconWidget({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: const Icon(Icons.edit),
      onTap: () {
        onTap!();
      },
    );
  }
}
