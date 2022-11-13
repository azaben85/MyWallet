import 'package:flutter/material.dart';
import 'package:my_wallet/expenses/providers/expense_category_provider.dart';
import 'package:provider/provider.dart';

class AddExpenseCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseCategoryProvider>(
        builder: (context, provider, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Add New Category'),
        ),
        body: Column(
          children: [
            TextFormField(
              controller: provider.textController,
              decoration:
                  const InputDecoration(label: Text('Expense Category')),
            ),
            ElevatedButton(
                onPressed: () async {
                  await provider.insertExpenseCategor();
                  Navigator.of(context).pop();
                },
                child: Text('Create Expense Category'))
          ],
        ),
      );
    });
  }
}
