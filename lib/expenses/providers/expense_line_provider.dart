import 'package:flutter/material.dart';
import 'package:my_wallet/expenses/data_repository/db_expense_lines_helper.dart';
import 'package:my_wallet/expenses/expense_header/models/expense_header_model.dart';
import 'package:my_wallet/expenses/expense_lines/models/expense_line_model.dart';

class ExpenseLineProvider extends ChangeNotifier {
  ExpenseLineProvider() {
    getExpenseLine();
  }

  List<ExpenseLineModel> allExpenseLines = [];

  getExpenseLine() async {
    allExpenseLines = await ExpLinesDBHelper.dbHelper
        .getAllExpLines(expHeaderId: headerModel?.id ?? -1);

    notifyListeners();
  }

  ExpenseHeaderModel? headerModel;

  updateHeaderModel(ExpenseHeaderModel headerModel) {
    this.headerModel = headerModel;
    getExpenseLine();
  }

  TextEditingController amountTextController = TextEditingController();
  TextEditingController dueDateTextController = TextEditingController();

  populateControlersForUpdate(ExpenseLineModel expenseLine) {
    amountTextController.text = expenseLine.subAmount.toString();
    dueDateTextController.text = expenseLine.duedate;

    notifyListeners();
  }

  updateExpenseLine(ExpenseLineModel expenseLine) async {
    expenseLine.subAmount = double.parse(amountTextController.text);
    expenseLine.duedate = dueDateTextController.text;
    await ExpLinesDBHelper.dbHelper.updateExpLine(expenseLine);
    amountTextController.text = '';
    dueDateTextController.text = '';
    getExpenseLine();
  }

  insertExpenseHeader() async {
    ExpenseLineModel expenseLine = ExpenseLineModel(
        headerId: headerModel?.id ?? -1,
        subAmount: double.parse(amountTextController.text),
        duedate: dueDateTextController.text);
    await ExpLinesDBHelper.dbHelper.insertNewExpLine(expenseLine);
    amountTextController.text = '';
    dueDateTextController.text = '';
    getExpenseLine();
  }
}
