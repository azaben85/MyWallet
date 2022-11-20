import 'package:flutter/material.dart';
import 'package:my_wallet/components/custom_scaffold.dart';
import 'package:my_wallet/expenses/expense_category/ui/widgets/expense_category_widget.dart';
import 'package:my_wallet/expenses/expense_header/ui/screens/expense_header_add_screen.dart';
import 'package:my_wallet/expenses/expense_header/ui/widgets/expense_header_widget.dart';
import 'package:my_wallet/expenses/providers/expense_header_provider.dart';
import 'package:provider/provider.dart';

class ExpesnseHeaderScreen extends StatelessWidget {
  const ExpesnseHeaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseHeaderProvider>(
        builder: (context, eHeaderProvider, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(eHeaderProvider.expCategory!.name!,
              style: TextStyle(color: Colors.white)),
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
            ExpenseCategoryWidget(eHeaderProvider.expCategory!,
                allowNavigate: false),
            Expanded(
              child: GridView.builder(
                itemCount: eHeaderProvider.allExpenseHeader.length,
                itemBuilder: (context, index) {
                  return ExpenseHeaderWidget(
                      eHeaderProvider.allExpenseHeader[index]);
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
              ),
            )
          ],
        ),
      );
    });
  }
}
