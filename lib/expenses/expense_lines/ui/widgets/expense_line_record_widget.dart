import 'package:flutter/material.dart';
import 'package:my_wallet/expenses/expense_lines/models/expense_line_model.dart';

class ExpLineRecordForAddWidget extends StatelessWidget {
  ExpenseLineModel expenseLineModel;
  ExpLineRecordForAddWidget({required this.expenseLineModel});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(right: 2, left: 2),
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: Text(expenseLineModel.duedate),
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(right: 2, left: 2),
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: Text('${expenseLineModel.subAmount}'),
          ),
        ),
      ],
    );
  }
}
