import 'package:flutter/material.dart';
import 'package:my_wallet/app_router/app_router.dart';
import 'package:my_wallet/expenses/expense_category/models/expense_category_model.dart';
import 'package:my_wallet/expenses/expense_category/ui/screens/expense_category_add_region.dart';
import 'package:my_wallet/expenses/expense_category/ui/screens/expense_category_add_screen.dart';
import 'package:my_wallet/expenses/expense_header/ui/screens/expense_header_screen.dart';
import 'package:my_wallet/expenses/providers/expense_category_provider.dart';
import 'package:my_wallet/expenses/providers/expense_header_provider.dart';
import 'package:my_wallet/widgets/image_assets/expense_image_asset.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ExpenseCategoryWidget extends StatelessWidget {
  ExpenseCategoryModel expenseCategory;
  bool allowNavigate;
  ExpenseCategoryWidget(this.expenseCategory, {this.allowNavigate = true});

  @override
  Widget build(BuildContext context) {
    if (allowNavigate) {
      return Row(
        children: [
          Expanded(
            child: InkWell(
              child: IntExpenseCatWidget(name: expenseCategory.name!),
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
      return IntExpenseCatWidget(name: expenseCategory.name!);
    }
  }
}

class IntExpenseCatWidget extends StatelessWidget {
  String name;
  IntExpenseCatWidget({
    super.key,
    required this.name,
  });

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
          ImageAsset('Expenses.png', width: 40.w, height: 40.h),
          SizedBox(
            width: 12.w,
          ),
          Text(name),
        ],
      )),
    );
  }
}
