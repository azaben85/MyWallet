import 'package:flutter/material.dart';
import 'package:my_wallet/components/custom_scaffold.dart';
import 'package:my_wallet/expenses/expense_category/ui/screens/expense_categories_screen.dart';

class MyWalletMainScreen extends StatelessWidget {
  const MyWalletMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: const Text('MyWallet', style: TextStyle(color: Colors.white)),
      body: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return const ExpesnseCategories();
              },
            ));
          },
          child: const Text('Expenses')),
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
