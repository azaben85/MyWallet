import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_wallet/widgets/image_assets/expense_image_asset.dart';

enum Icon_Type { expense, saving, income }

class WalletCatWidget extends StatelessWidget {
  String name;
  Icon_Type? icon_type;
  WalletCatWidget({super.key, required this.name, this.icon_type});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88.h,
      margin: EdgeInsets.only(left: 28.w),
      decoration: const BoxDecoration(
          //  borderRadius: BorderRadius.circular(20),
          border: Border(bottom: BorderSide(color: Colors.grey, width: 1.0))),
      child: Center(
          child: Row(
        children: [
          ImageAsset(
              icon_type == Icon_Type.income
                  ? 'Income.png'
                  : icon_type == Icon_Type.saving
                      ? 'Saving.png'
                      : 'Expenses.png',
              width: 37.w,
              height: 37.h),
          SizedBox(
            width: 12.w,
          ),
          Text(name),
        ],
      )),
    );
  }
}
