import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_wallet/widgets/image_assets/expense_image_asset.dart';

enum Icon_Type { expense, saving, income }

class WalletCatWidget extends StatelessWidget {
  String name;
  Icon_Type? icon_type;
  Color? textColor;
  double? amount;
  WalletCatWidget(
      {super.key,
      this.textColor = Colors.black,
      required this.name,
      this.amount,
      this.icon_type});

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
          WalletIcon(icon_type: icon_type),
          SizedBox(
            width: 12.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(name,
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: textColor)),
                // if (amount != null)
                //   SizedBox(
                //     height: 12.h,
                //   ),
                if (amount != null)
                  Text('Total $amount',
                      style: TextStyle(fontSize: 14, color: textColor)),
              ],
            ),
          ),
        ],
      )),
    );
  }
}

class WalletIcon extends StatelessWidget {
  const WalletIcon({
    super.key,
    required this.icon_type,
  });

  final Icon_Type? icon_type;

  @override
  Widget build(BuildContext context) {
    return ImageAsset(
        icon_type == Icon_Type.income
            ? 'Income.png'
            : icon_type == Icon_Type.saving
                ? 'Saving.png'
                : 'Expenses.png',
        width: 37.w,
        height: 37.h);
  }
}
