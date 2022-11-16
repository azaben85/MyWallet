import 'package:flutter/material.dart';
import 'package:my_wallet/expenses/models/expense_category_model.dart';
import 'package:my_wallet/expenses/providers/expense_header_provider.dart';
import 'package:my_wallet/expenses/ui/screens/expense_header_screen.dart';
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
  const IntExpenseCatWidget({
    super.key,
    required this.expenseCategory,
  });

  final ExpenseCategoryModel expenseCategory;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(3),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 1, color: Colors.pink)),
      child: Center(child: Text(expenseCategory.name!)),
    );
  }
}
