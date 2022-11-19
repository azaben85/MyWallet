import 'package:flutter/material.dart';
import 'package:my_wallet/expenses/expense_category/ui/screens/expense_category_add_screen.dart';
import 'package:my_wallet/expenses/providers/expense_category_provider.dart';
import 'package:my_wallet/expenses/expense_category/ui/widgets/expense_category_widget.dart';
import 'package:provider/provider.dart';

class ExpesnseCategories extends StatelessWidget {
  const ExpesnseCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses'),
        actions: [
          InkWell(
            child:
                const SizedBox(width: 52, height: 52, child: Icon(Icons.add)),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return AddExpenseCategory();
                },
              ));
            },
          )
        ],
      ),
      body: Consumer<ExpenseCategoryProvider>(
          builder: (context, provider, child) {
        return ListView.builder(
          itemCount: provider.allExpenseCategories.length,
          itemBuilder: (context, index) {
            return ExpenseCategoryWidget(provider.allExpenseCategories[index]);
          },
        );
      }),
    );
  }
}
