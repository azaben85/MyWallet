// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_wallet/app_router/app_router.dart';

class BackButtonWidget extends StatelessWidget {
  Color color;
  BackButtonWidget({
    super.key,
    this.color = Colors.white,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: SizedBox(
        width: 52.w,
        height: 52.h,
        child: Icon(
          Icons.arrow_back,
          color: color,
        ),
      ),
      onTap: () {
        AppRouter.appRouter.pop();
      },
    );
  }
}
