import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_wallet/app_provider/app_config_provider.dart';
import 'package:my_wallet/app_router/app_router.dart';
import 'package:my_wallet/app_data_repository/db_helper.dart';
import 'package:my_wallet/expenses/providers/expense_category_provider.dart';
import 'package:my_wallet/expenses/providers/expense_header_provider.dart';
import 'package:my_wallet/expenses/providers/expense_line_provider.dart';
import 'package:my_wallet/income/providers/income_header_provider.dart';
import 'package:my_wallet/income/providers/income_line_provider.dart';
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
      ChangeNotifierProvider<ExpenseLineProvider>(
        create: (context) {
          return ExpenseLineProvider();
        },
      ),
      ChangeNotifierProvider<IncomeHeaderProvider>(
        create: (context) {
          return IncomeHeaderProvider();
        },
      ),
      ChangeNotifierProvider<IncomeLineProvider>(
        create: (context) {
          return IncomeLineProvider();
        },
      ),
      ChangeNotifierProvider<AppConfigProvider>(
        create: (context) {
          return AppConfigProvider();
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
    return ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (BuildContext context, Widget? child) {
          return MaterialApp(
            navigatorKey: AppRouter.appRouter.navigatorKey,
            debugShowCheckedModeBanner: false,
            title: 'My Wallet',
            home: MyWalletMainScreen(),
          );
        });
  }
}
