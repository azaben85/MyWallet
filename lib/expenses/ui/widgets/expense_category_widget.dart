import 'package:flutter/material.dart';

import 'package:my_wallet/expenses/models/expense_category_model.dart';

class ExpenseCategoryWidget extends StatelessWidget {
  ExpenseCategoryModel expenseCategory;
  ExpenseCategoryWidget(this.expenseCategory);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 1, color: Colors.pink)),
      child: Text(expenseCategory.name!),
    );
  }
}
