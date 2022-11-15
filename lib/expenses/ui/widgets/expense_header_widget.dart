import 'package:flutter/material.dart';
import 'package:my_wallet/expenses/models/expense_header_model.dart';

class ExpenseHeaderWidget extends StatelessWidget {
  ExpenseHeaderModel expenseHeader;
  ExpenseHeaderWidget(this.expenseHeader);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(3),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 1, color: Colors.pink)),
      child: Center(
          child: Text(
              '${expenseHeader.categoryId} - ${expenseHeader.expenseName}')),
    );
  }
}
