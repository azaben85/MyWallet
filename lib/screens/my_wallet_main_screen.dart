import 'package:flutter/material.dart';
import 'package:my_wallet/components/custom_scaffold.dart';
import 'package:my_wallet/expenses/expense_category/ui/screens/expense_categories_screen.dart';
import 'package:my_wallet/income/screens/income_header_screen.dart';
import 'package:my_wallet/saving/screens/saving_header_screen.dart';

class MyWalletMainScreen extends StatelessWidget {
  const MyWalletMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'My Wallet',
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return const ExpesnseCategories();
                  },
                ));
              },
              child: const Text('Expenses')),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return const IncomeHeaderScreen();
                  },
                ));
              },
              child: const Text('Income')),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return const SavingHeaderScreen();
                  },
                ));
              },
              child: const Text('Saving')),
        ],
      ),
    );

    Scaffold(
      appBar: AppBar(
        title: const Text('My Wallet'),
      ),
      body: Container(
        child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return const ExpesnseCategories();
                },
              ));
            },
            child: const Text('Expenses')),
      ),
    );
  }
}
