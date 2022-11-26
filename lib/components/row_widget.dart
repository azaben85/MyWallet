import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RowWidget extends StatelessWidget {
  String? label;
  double height;
  bool isHeader;
  RowWidget({super.key, this.height = 52, this.label, this.isHeader = false});

  @override
  Widget build(BuildContext context) {
    if (isHeader) {
      return Expanded(
        child: Container(
          height: height.h,
          margin: const EdgeInsets.only(right: 2, left: 2),
          decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(
            width: 1.5,
          ))),
          child: Center(child: Text(label ?? '')),
        ),
      );
    }
    return Expanded(
      child: Container(
        height: height.h,
        margin: const EdgeInsets.only(right: 10, left: 10),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
          width: 0.5,
        ))),
        child: Center(child: Text(label ?? '')),
      ),
    );
  }
}
