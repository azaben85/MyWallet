// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeleteButtonWidget extends StatelessWidget {
  String label;
  Function? onTap;
  EdgeInsets? padding;
  EdgeInsets? margin;
  DeleteButtonWidget({
    Key? key,
    required this.label,
    this.onTap,
    this.padding,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: padding,
        margin: margin,
        height: 64.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(28.r),
          ),
          border: Border.all(
            width: 1,
            color: Color.fromRGBO(231, 215, 214, 1),
            // style: BorderStyle.solid,
          ),
        ),
        child: Center(
          child: Container(
            margin: EdgeInsets.only(left: 26.5.w, right: 26.5.w),
            child: Text(
              label,
              style: TextStyle(
                  color: Color.fromRGBO(214, 97, 47, 1), fontSize: 17.sp),
            ),
          ),
        ),
      ),
      onTap: () {
        onTap!();
      },
    );
  }
}
