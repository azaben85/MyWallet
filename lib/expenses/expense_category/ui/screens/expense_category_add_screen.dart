import 'package:flutter/material.dart';
import 'package:my_wallet/components/custom_textformfield.dart';
import 'package:my_wallet/expenses/providers/expense_category_provider.dart';
import 'package:provider/provider.dart';

class AddExpenseCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseCategoryProvider>(
        builder: (context, provider, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Add New Category'),
        ),
        body: Form(
          key: provider.expenseCatKey,
          child: Column(
            children: [
              CustomTextField(
                  validation: provider.validateCategoryName,
                  onSave: provider.setCategoryName,
                  label: 'Expense Category'),
              ElevatedButton(
                  onPressed: () {
                    provider.insertExpenseCategor();
                  },
                  child: const Text('Create Expense Category'))
            ],
          ),
        ),
      );
    });
  }
}
