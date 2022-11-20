import 'package:flutter/material.dart';
import 'package:my_wallet/expenses/expense_category/models/expense_category_model.dart';
import 'package:my_wallet/expenses/expense_header/ui/screens/expense_header_screen.dart';
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
    return allowNavigate
        ? InkWell(
            child: IntExpenseCatWidget(expenseCategory: expenseCategory),
            onTap: () {
              Provider.of<ExpenseHeaderProvider>(context, listen: false)
                  .updateCategoryModel(expenseCategory);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return const ExpesnseHeaderScreen();
                },
              ));
            },
          )
        : IntExpenseCatWidget(expenseCategory: expenseCategory);
  }
}

class IntExpenseCatWidget extends StatelessWidget {
  IntExpenseCatWidget({
    super.key,
    required this.expenseCategory,
  });

  ExpenseCategoryModel expenseCategory;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88.h,
      margin: EdgeInsets.only(left: 28.w, right: 28.w),
      decoration: const BoxDecoration(
          //  borderRadius: BorderRadius.circular(20),
          border: Border(bottom: BorderSide(color: Colors.grey, width: 1.0))),
      child: Center(
          child: Row(
        children: [
          ImageAsset('Expenses.png', width: 48.w, height: 48.h),
          SizedBox(
            width: 12.w,
          ),
          Text(expenseCategory.name!),
          Text('  ${expenseCategory.instant!.toString()}')
        ],
      )),
    );
  }
}
