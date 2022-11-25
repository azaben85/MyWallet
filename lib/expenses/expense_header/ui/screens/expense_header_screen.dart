import 'package:flutter/material.dart';
import 'package:my_wallet/app_router/app_router.dart';
import 'package:my_wallet/expenses/expense_category/ui/widgets/expense_category_widget.dart';
import 'package:my_wallet/expenses/expense_header/ui/screens/expense_header_add_planned_screen.dart';
import 'package:my_wallet/expenses/expense_header/ui/screens/expense_header_add_screen.dart';
import 'package:my_wallet/expenses/expense_header/ui/widgets/expense_header_widget.dart';
import 'package:my_wallet/expenses/providers/expense_header_provider.dart';
import 'package:my_wallet/expenses/providers/expense_line_provider.dart';
import 'package:provider/provider.dart';

class ExpenseHeaderScreen extends StatelessWidget {
  const ExpenseHeaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseHeaderProvider>(
        builder: (context, eHeaderProvider, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(eHeaderProvider.expCategory!.name!,
              style: TextStyle(color: Colors.white)),
          actions: [
            InkWell(
              child:
                  const SizedBox(width: 52, height: 52, child: Icon(Icons.add)),
              onTap: () {
                eHeaderProvider.resetFields();
                Provider.of<ExpenseLineProvider>(context, listen: false)
                    .clearFields();
                if (eHeaderProvider.expCategory!.instant!) {
                  AppRouter.appRouter.push(AddExpenseHeader());
                } else {
                  AppRouter.appRouter.push(AddPlannedExpesneHeaderScreen());
                }
              },
            )
          ],
        ),
        body: Column(
          children: [
            ExpenseCategoryWidget(eHeaderProvider.expCategory!,
                allowNavigate: false),
            Expanded(
              child: ListView.builder(
                itemCount: eHeaderProvider.allExpenseHeader.length,
                itemBuilder: (context, index) {
                  return ExpenseHeaderWidget(
                      eHeaderProvider.allExpenseHeader[index]);
                },
              ),
            )
          ],
        ),
      );
    });
  }
}
