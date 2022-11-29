import 'package:flutter/material.dart';
import 'package:my_wallet/components/row_widget.dart';
import 'package:my_wallet/income/models/income_line_model.dart';

class IncomeLineRecordForAddWidget extends StatelessWidget {
  IncomeLineModel incomeLineModel;
  bool showDesc;
  IncomeLineRecordForAddWidget(
      {required this.incomeLineModel, this.showDesc = true});
  double height = 52;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        if (showDesc) RowWidget(height: height, label: incomeLineModel.desc),
        RowWidget(height: height, label: incomeLineModel.duedate),
        RowWidget(height: height, label: '${incomeLineModel.amount}'),
      ],
    );
  }
}
