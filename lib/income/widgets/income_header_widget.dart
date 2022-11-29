import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_wallet/app_router/app_router.dart';
import 'package:my_wallet/components/constants_widgets/edit_icon_widget.dart';
import 'package:my_wallet/components/wallet_cat_widget.dart';
import 'package:my_wallet/income/models/income_header_model.dart';
import 'package:my_wallet/income/providers/income_header_provider.dart';
import 'package:my_wallet/income/providers/income_line_provider.dart';
import 'package:my_wallet/income/screens/expense_line_screen.dart';
import 'package:my_wallet/income/screens/income_header_add_screen.dart';
import 'package:provider/provider.dart';

class IncomeHeaderWidget extends StatelessWidget {
  IncomeHeaderModel incomeHeader;
  bool allowNavigate;
  IncomeHeaderWidget(this.incomeHeader, {this.allowNavigate = true});

  @override
  Widget build(BuildContext context) {
    if (allowNavigate) {
      return Row(
        children: [
          Expanded(
            child: InkWell(
              child: WalletCatWidget(
                  name: incomeHeader.name!, icon_type: Icon_Type.income),
              onTap: () {
                Provider.of<IncomeLineProvider>(context, listen: false)
                    .setIncomeHeader(incomeHeader);
                AppRouter.appRouter.push(const IncomeLineScreen());
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 28.w),
            child: EditIconWidget(onTap: () {
              Provider.of<IncomeHeaderProvider>(context, listen: false)
                  .loadDataForUpdate(incomeHeader);
              AppRouter.appRouter.showAlertDialog('Edit', AddIncomeHeader());
            }),
          )
        ],
      );
    } else {
      return WalletCatWidget(
          name: incomeHeader.name!, icon_type: Icon_Type.income);
    }
  }
}
