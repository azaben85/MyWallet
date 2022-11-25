import 'package:flutter/material.dart';
import 'package:my_wallet/expenses/expense_header/ui/widgets/expense_header_widget.dart';
import 'package:my_wallet/expenses/expense_lines/ui/widgets/expense_line_record_widget.dart';
import 'package:my_wallet/expenses/providers/expense_line_provider.dart';
import 'package:provider/provider.dart';

class ExpesnseLineScreen extends StatelessWidget {
  const ExpesnseLineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseLineProvider>(builder: (context, provider, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(provider.headerModel!.expenseName,
              style: TextStyle(color: Colors.white)),
          actions: [
            InkWell(
              child:
                  const SizedBox(width: 52, height: 52, child: Icon(Icons.add)),
              onTap: () {},
            )
          ],
        ),
        body: Column(
          children: [
            ExpenseHeaderWidget(provider.headerModel!),
            Expanded(
              child: ListView.builder(
                itemCount: provider.allExpenseLines.length,
                itemBuilder: (context, index) {
                  return ExpLineRecordForAddWidget(
                      expenseLineModel: provider.allExpenseLines[index]);
                },
              ),
            )
          ],
        ),
      );
    });
  }
}
