import 'package:flutter/material.dart';
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
        body: ListView(
          children: [
            TextFormField(
              controller: provider.nameTextController,
              decoration: const InputDecoration(label: Text('Expense Type')),
            ),
            Row(
              children: [
                const Text('Auto Bill'),
                Checkbox(
                  value: provider.inBank,
                  onChanged: (value) {
                    provider.setAutoBill(value!);
                  },
                ),
              ],
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: provider.amountTextController,
              decoration: const InputDecoration(label: Text('Amount')),
            ),
            ElevatedButton(
                onPressed: () {
                  Provider.of<ExpenseHeaderProvider>(context, listen: false)
                      .insertExpenseHeader();
                  Navigator.of(context).pop();
                },
                child: const Text('Add New Expense'))
          ],
        ),
      );
    });
  }
}
