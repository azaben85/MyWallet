import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_wallet/expenses/data_repository/db_expense_lines_helper.dart';
import 'package:my_wallet/income/data_repository/db_income_header_helper.dart';
import 'package:my_wallet/income/data_repository/db_income_lines_helper.dart';

const String dateFormat = 'MMM, yyyy';

class AppConfigProvider extends ChangeNotifier {
  AppConfigProvider() {
    updateFields();
  }
  String? currentMonth = DateFormat(dateFormat).format(DateTime.now());
  double? expenseTotal;
  double? savingTotal;
  double? incomeTotal;

  updateFields() async {
    // currentMonth = DateFormat(dateFormat).format(DateTime.now());
    expenseTotal =
        await ExpLinesDBHelper.dbHelper.getExpenseTotal(month: currentMonth);

    savingTotal = await IncomeLineDBHelper.dbHelper
        .getExpenseTotal(month: currentMonth, type: 'SAVING');
    incomeTotal = await IncomeLineDBHelper.dbHelper
        .getExpenseTotal(month: currentMonth, type: 'INCOME');
    notifyListeners();
  }

  nextMonth() {
    DateTime date = DateFormat(dateFormat).parse(currentMonth!);
    DateTime nextMonth = DateTime(date.year, date.month + 1);
    currentMonth = DateFormat(dateFormat).format(nextMonth);

    updateFields();
  }

  previousMonth() {
    DateTime date = DateFormat(dateFormat).parse(currentMonth!);

    DateTime nextMonth = DateTime(date.year, date.month - 1);
    currentMonth = DateFormat(dateFormat).format(nextMonth);
    updateFields();
  }
}
