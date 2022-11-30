import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_wallet/app_router/app_router.dart';
import 'package:my_wallet/components/constants_widgets/edit_icon_widget.dart';
import 'package:my_wallet/components/wallet_cat_widget.dart';
import 'package:my_wallet/income/models/income_header_model.dart';
import 'package:my_wallet/income/providers/income_header_provider.dart';
import 'package:my_wallet/income/providers/income_line_provider.dart';
import 'package:my_wallet/income/screens/income_line_screen.dart';
import 'package:my_wallet/income/screens/income_header_add_screen.dart';
import 'package:my_wallet/saving/providers/saving_header_provider.dart';
import 'package:my_wallet/saving/screens/saving_header_add_screen.dart';
import 'package:my_wallet/saving/screens/saving_line_screen.dart';
import 'package:provider/provider.dart';

class SavingHeaderWidget extends StatelessWidget {
  IncomeHeaderModel incomeHeader;
  bool allowNavigate;
  SavingHeaderWidget(this.incomeHeader, {this.allowNavigate = true});

  @override
  Widget build(BuildContext context) {
    if (allowNavigate) {
      return Row(
        children: [
          Expanded(
            child: InkWell(
              child: WalletCatWidget(
                  name: incomeHeader.name!, icon_type: Icon_Type.saving),
              onTap: () {
                Provider.of<IncomeLineProvider>(context, listen: false)
                    .setIncomeHeader(incomeHeader);
                AppRouter.appRouter.push(const SavingLineScreen());
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 28.w),
            child: EditIconWidget(onTap: () {
              Provider.of<SavingHeaderProvider>(context, listen: false)
                  .loadDataForUpdate(incomeHeader);
              AppRouter.appRouter.showAlertDialog('Edit', AddSavingHeader());
            }),
          )
        ],
      );
    } else {
      return WalletCatWidget(
          textColor: Colors.white,
          name: incomeHeader.name!,
          icon_type: Icon_Type.saving);
    }
  }
}
