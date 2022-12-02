// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WalletRegion extends StatelessWidget {
  Widget widget;
  Function? onTap;
  Color? borderColor;
  EdgeInsets? padding;
  EdgeInsets? margin;
  double? width;
  double? height;
  WalletRegion({
    this.width = 0,
    this.height = 0,
    Key? key,
    required this.widget,
    this.borderColor = Colors.white,
    this.onTap,
    this.padding,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          // color: borderColor!,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.r),
          ),
          border: Border.all(
            color: borderColor!,
            width: 1,
            //color: Colors.green,
            // style: BorderStyle.solid,
          ),
        ),
        child: Center(
          child: Container(
            margin: EdgeInsets.only(left: 26.5.w, right: 26.5.w),
            child: widget,
          ),
        ),
      ),
      onTap: () {
        onTap!();
      },
    );
  }
}
