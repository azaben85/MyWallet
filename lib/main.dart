import 'package:flutter/material.dart';
import 'package:my_wallet/expenses/data_repository/db_helper.dart';
import 'package:my_wallet/expenses/providers/expense_category_provider.dart';
import 'package:my_wallet/expenses/providers/expense_header_provider.dart';
import 'package:my_wallet/screens/my_wallet_main_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.dbHelper.createDatabaseConnection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider<ExpenseCategoryProvider>(
        create: (context) {
          return ExpenseCategoryProvider();
        },
      ),
      ChangeNotifierProvider<ExpenseHeaderProvider>(
        create: (context) {
          return ExpenseHeaderProvider();
        },
      ),
    ], child: InitialApp());
  }
}

class InitialApp extends StatelessWidget {
  const InitialApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // theme: Provider.of<ToDoClassProvider>(context).isDarkMode
      //     ? ThemeData.dark()
      //     : ThemeData.light(),
      debugShowCheckedModeBanner: false,
      title: 'ToDo APP',
      home: MyWalletMainScreen(),
    );
  }
}
