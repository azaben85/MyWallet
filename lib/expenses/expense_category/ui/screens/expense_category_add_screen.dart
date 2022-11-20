// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:my_wallet/components/custom_textformfield.dart';
import 'package:my_wallet/expenses/providers/expense_category_provider.dart';

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
              CustomCheckBoxTile(
                  value: provider.instantType ?? false,
                  onChanged: provider.setInstantType),
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

class CustomCheckBoxTile extends StatelessWidget {
  Function onChanged;
  bool value;
  CustomCheckBoxTile({
    Key? key,
    required this.onChanged,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: const Text('Instant Expense'),
      value: value,
      onChanged: (value) => onChanged(value),
    );
  }
}
