import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_wallet/app_router/app_router.dart';
import 'package:my_wallet/components/constants_widgets/edit_icon_widget.dart';
import 'package:my_wallet/components/wallet_cat_widget.dart';
import 'package:my_wallet/expenses/expense_header/models/expense_header_model.dart';
import 'package:my_wallet/expenses/expense_header/ui/screens/expense_header_add_screen.dart';
import 'package:my_wallet/expenses/expense_lines/ui/screens/expense_line_screen.dart';
import 'package:my_wallet/expenses/providers/expense_header_provider.dart';
import 'package:my_wallet/expenses/providers/expense_line_provider.dart';
import 'package:provider/provider.dart';

class ExpenseHeaderWidget extends StatelessWidget {
  ExpenseHeaderModel expenseHeader;
  Color? textColor;
  bool allowNavigate;
  ExpenseHeaderWidget(
    this.expenseHeader, {
    this.allowNavigate = true,
    this.textColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    if (allowNavigate) {
      return Row(
        children: [
          Expanded(
            child: InkWell(
              child: WalletCatWidget(
                  textColor: textColor,
                  name: expenseHeader.expenseName,
                  amount: expenseHeader.total_amount),
              onTap: () {
                Provider.of<ExpenseLineProvider>(context, listen: false)
                    .updateHeaderModel(expenseHeader);
                AppRouter.appRouter.push(const ExpesnseLineScreen());
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 28.w),
            child: EditIconWidget(onTap: () {
              Provider.of<ExpenseHeaderProvider>(context, listen: false)
                  .loadDataForUpdate(expenseHeader);
              AppRouter.appRouter.showAlertDialog('Edit', AddExpenseHeader());
            }),
          )
        ],
      );
    } else {
      return WalletCatWidget(
        name: expenseHeader.expenseName,
        amount: expenseHeader.total_amount,
        textColor: textColor,
      );
    }
  }
}
