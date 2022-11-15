import 'package:flutter/material.dart';
import 'package:my_wallet/expenses/providers/expense_category_provider.dart';
import 'package:my_wallet/expenses/providers/expense_header_provider.dart';
import 'package:my_wallet/expenses/ui/screens/expense_header_add_screen.dart';
import 'package:my_wallet/expenses/ui/widgets/expense_category_widget.dart';
import 'package:my_wallet/expenses/ui/widgets/expense_header_widget.dart';
import 'package:provider/provider.dart';

class ExpesnseHeaderScreen extends StatelessWidget {
  const ExpesnseHeaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ExpenseCategoryProvider, ExpenseHeaderProvider>(
        builder: (context, catProvider, eHeaderProvider, child) {
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
                    return AddExpenseHeader();
                  },
                ));
              },
            )
          ],
        ),
        body: Column(
          children: [
            ExpenseCategoryWidget(catProvider.expCategory!),
            Expanded(
              child: GridView.builder(
                itemCount: eHeaderProvider.allExpenseHeader.length,
                itemBuilder: (context, index) {
                  return ExpenseHeaderWidget(
                      eHeaderProvider.allExpenseHeader[index]);
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
              ),
            )
          ],
        ),
      );
    });
  }
}
