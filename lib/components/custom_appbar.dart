import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_wallet/app_router/app_router.dart';
import 'package:my_wallet/components/back_widget.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      width: MediaQuery.of(context).size.width,
      height: 280.h,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 61.h),
            width: MediaQuery.of(context).size.width,
            height: 52,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (AppRouter.appRouter.canPop()) BackButtonWidget(),
                const Icon(
                  Icons.add,
                  color: Colors.white,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size(390.w, 280.h);
}
