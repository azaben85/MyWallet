import 'package:flutter/material.dart';
import 'package:my_wallet/components/custom_customcheckboxtile.dart';
import 'package:my_wallet/components/custom_textformfield.dart';
import 'package:my_wallet/expenses/providers/expense_header_provider.dart';
import 'package:provider/provider.dart';

class AddExpensePlannedHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseHeaderProvider>(builder: (context, provider, child) {
      return Form(
        key: provider.expenseHeaderKey,
        child: Column(
          children: [
            CustomTextField(
                initialValue: provider.headerName,
                validation: provider.validateString,
                onSave: provider.setHeaderName,
                label: 'To'),
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
          ],
        ),
      );
    });
  }
}
