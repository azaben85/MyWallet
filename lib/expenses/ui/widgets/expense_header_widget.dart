import 'package:flutter/material.dart';
import 'package:my_wallet/expenses/models/expense_header_model.dart';
import 'package:my_wallet/expenses/providers/expense_line_provider.dart';
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
        child: Container(
          margin: EdgeInsets.all(3),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(width: 1, color: Colors.pink)),
          child: Center(
              child: Text(
                  '${expenseHeader.categoryId} - ${expenseHeader.expenseName}')),
        ));
  }
}
