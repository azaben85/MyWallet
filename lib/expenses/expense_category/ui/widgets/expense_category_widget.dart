import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_wallet/app_router/app_router.dart';
import 'package:my_wallet/components/wallet_cat_widget.dart';
import 'package:my_wallet/expenses/expense_category/models/expense_category_model.dart';
import 'package:my_wallet/expenses/expense_category/ui/screens/expense_category_add_region.dart';
import 'package:my_wallet/expenses/expense_header/ui/screens/expense_header_screen.dart';
import 'package:my_wallet/expenses/providers/expense_category_provider.dart';
import 'package:my_wallet/expenses/providers/expense_header_provider.dart';
import 'package:provider/provider.dart';

class ExpenseCategoryWidget extends StatelessWidget {
  ExpenseCategoryModel expenseCategory;
  double? amount;
  bool allowNavigate;
  ExpenseCategoryWidget(this.expenseCategory,
      {this.allowNavigate = true, this.amount});

  @override
  Widget build(BuildContext context) {
    if (allowNavigate) {
      return Row(
        children: [
          Expanded(
            child: InkWell(
              child: WalletCatWidget(
                name: expenseCategory.name!,
                amount: expenseCategory.total_amount!,
              ),
              onTap: () {
                Provider.of<ExpenseHeaderProvider>(context, listen: false)
                    .updateCategoryModel(expenseCategory);
                AppRouter.appRouter.push(const ExpenseHeaderScreen());
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 28.w),
            child: InkWell(
              child: Container(width: 52, child: const Icon(Icons.edit)),
              onTap: () {
                Provider.of<ExpenseCategoryProvider>(context, listen: false)
                    .loadDataForUpdate(expenseCategory);
                //AppRouter.appRouter.push(AddExpenseCategory());
                AppRouter.appRouter
                    .showAlertDialog('Add New', AddExpenseCategoryContent());
              },
            ),
          )
        ],
      );
    } else {
      return WalletCatWidget(
        name: expenseCategory.name!,
        amount: expenseCategory.total_amount!,
      );
    }
  }
}
