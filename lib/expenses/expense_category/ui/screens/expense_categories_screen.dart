import 'package:flutter/material.dart';
import 'package:my_wallet/app_router/app_router.dart';
import 'package:my_wallet/components/custom_scaffold.dart';
import 'package:my_wallet/expenses/expense_category/ui/screens/expense_category_add_region.dart';
import 'package:my_wallet/expenses/expense_category/ui/widgets/expense_category_widget.dart';
import 'package:my_wallet/expenses/providers/expense_category_provider.dart';
import 'package:provider/provider.dart';

class ExpesnseCategories extends StatelessWidget {
  const ExpesnseCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseCategoryProvider>(
        builder: (context, provider, child) {
      return CustomScaffold(
        title: 'Expense Categories',
        floatingActionButton: FloatingActionButton(
            backgroundColor: Color.fromRGBO(202, 192, 248, 1),
            onPressed: () {
              provider.clearFields();
              //AppRouter.appRouter.push(AddExpenseCategory());
              AppRouter.appRouter
                  .showAlertDialog('Add New', AddExpenseCategoryContent());
            },
            child: const Icon(Icons.add)),
        body: ListView.builder(
          itemCount: provider.allExpenseCategories.length,
          itemBuilder: (context, index) {
            return ExpenseCategoryWidget(provider.allExpenseCategories[index]);
          },
        ),
      );
    });
  }
}
