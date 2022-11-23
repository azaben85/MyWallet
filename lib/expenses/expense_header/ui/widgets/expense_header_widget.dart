import 'package:flutter/material.dart';
import 'package:my_wallet/app_router/app_router.dart';
import 'package:my_wallet/expenses/expense_header/models/expense_header_model.dart';
import 'package:my_wallet/expenses/expense_header/ui/screens/expense_header_add_screen.dart';
import 'package:my_wallet/expenses/providers/expense_header_provider.dart';
import 'package:my_wallet/expenses/providers/expense_line_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_wallet/expenses/ui/screens/expense_header_line_screen.dart';
import 'package:provider/provider.dart';

class ExpenseHeaderWidget extends StatelessWidget {
  ExpenseHeaderModel expenseHeader;
  ExpenseHeaderWidget(this.expenseHeader);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Provider.of<ExpenseLineProvider>(context, listen: false)
              .updateHeaderModel(expenseHeader);
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return const ExpenseLineScreen();
            },
          ));
        },
        child: Row(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.all(3),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 1, color: Colors.pink)),
                child: Center(
                    child: Text(
                        '${expenseHeader.categoryId} - ${expenseHeader.expenseName}')),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 28.w),
              child: InkWell(
                child: const Icon(Icons.edit),
                onTap: () {
                  Provider.of<ExpenseHeaderProvider>(context, listen: false)
                      .loadDataForUpdate(expenseHeader);
                  AppRouter.appRouter.push(AddExpenseHeader());
                },
              ),
            )
          ],
        ));
  }
}
