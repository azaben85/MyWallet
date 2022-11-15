import 'package:flutter/material.dart';
import 'package:my_wallet/expenses/models/expense_category_model.dart';
import 'package:my_wallet/expenses/providers/expense_category_provider.dart';
import 'package:my_wallet/expenses/providers/expense_header_provider.dart';
import 'package:my_wallet/expenses/ui/screens/expense_header_screen.dart';
import 'package:provider/provider.dart';

class ExpenseCategoryWidget extends StatelessWidget {
  ExpenseCategoryModel expenseCategory;
  ExpenseCategoryWidget(this.expenseCategory);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: const EdgeInsets.all(3),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 1, color: Colors.pink)),
        child: Center(child: Text(expenseCategory.name!)),
      ),
      onTap: () {
        print(expenseCategory.name);
        Provider.of<ExpenseCategoryProvider>(context, listen: false)
            .updateCategory(expenseCategory);
        Provider.of<ExpenseHeaderProvider>(context, listen: false)
            .updateCategoryId(expenseCategory.id!);
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return const ExpesnseHeaderScreen();
          },
        ));
      },
    );
  }
}
