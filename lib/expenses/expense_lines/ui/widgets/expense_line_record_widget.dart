import 'package:flutter/material.dart';
import 'package:my_wallet/components/row_widget.dart';
import 'package:my_wallet/expenses/expense_lines/models/expense_line_model.dart';

class ExpLineRecordForAddWidget extends StatelessWidget {
  ExpenseLineModel expenseLineModel;
  bool showDesc;
  ExpLineRecordForAddWidget(
      {required this.expenseLineModel, this.showDesc = true});
  double height = 52;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        if (showDesc)
          RowWidget(height: height, label: expenseLineModel.description),
        RowWidget(height: height, label: expenseLineModel.duedate),
        RowWidget(height: height, label: '${expenseLineModel.subAmount}'),
      ],
    );
  }
}
