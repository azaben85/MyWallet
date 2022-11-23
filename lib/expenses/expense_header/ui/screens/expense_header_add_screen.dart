import 'package:flutter/material.dart';
import 'package:my_wallet/components/custom_customcheckboxtile.dart';
import 'package:my_wallet/components/custom_textformfield.dart';
import 'package:my_wallet/expenses/providers/expense_header_provider.dart';
import 'package:provider/provider.dart';

class AddExpenseHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseHeaderProvider>(builder: (context, provider, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Add Expense Type'),
        ),
        body: Form(
          key: provider.expenseHeaderKey,
          child: ListView(
            children: [
              CustomTextField(
                  initialValue: provider.headerName,
                  validation: provider.validateString,
                  onSave: provider.setHeaderName,
                  label: 'Title'),
              CustomTextField(
                  initialValue: provider.headerDesc,
                  // validation: provider.validateString,
                  onSave: provider.setHeaderDesc,
                  label: 'Description'),
              CustomCheckBoxTile(
                label: 'In Bank',
                value: provider.inBank ?? false,
                onChanged: provider.setInBank,
              ),
              ElevatedButton(
                  onPressed: () {
                    provider.insertUpdateExpenseHeader();
                  },
                  child: const Text('Add New Expense'))
            ],
          ),
        ),
      );
    });
  }
}
