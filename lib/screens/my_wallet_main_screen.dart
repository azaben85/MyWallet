import 'package:flutter/material.dart';
import 'package:my_wallet/expenses/ui/screens/expense_categories_screen.dart';

class MyWalletMainScreen extends StatelessWidget {
  const MyWalletMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Wallet'),
      ),
      body: Container(
        child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return ExpesnseCategories();
                },
              ));
            },
            child: Text('Expenses')),
      ),
    );
  }
}