import 'package:flutter/material.dart';
import 'package:my_wallet/app_router/app_router.dart';
import 'package:my_wallet/expenses/data_repository/db_expense_lines_helper.dart';
import 'package:my_wallet/expenses/expense_header/models/expense_header_model.dart';
import 'package:my_wallet/expenses/expense_lines/models/expense_line_model.dart';
import 'package:string_validator/string_validator.dart';

class ExpenseLineProvider extends ChangeNotifier {
  ExpenseLineProvider() {
    getExpenseLine();
  }

  List<ExpenseLineModel> allExpenseLines = [];

  List<ExpenseLineModel> tempExpenseLines = [];
  GlobalKey<FormState> expenseLineKey = GlobalKey<FormState>();

  TextEditingController dueDateContoller = TextEditingController();
  TextEditingController amountContoller = TextEditingController();

  int? headerId;
  ExpenseHeaderModel? headerModel;

  clearFields() {
    dueDateContoller.text = '';
    amountContoller.text = '';
    tempExpenseLines.clear();
  }

  setDueDate(String dueDate) {
    dueDateContoller.text = dueDate;
  }

  setAmount(String amount) {
    amountContoller.text = amount;
    notifyListeners();
  }

  String? validateDate(String dueDate) {
    if (!isDate(dueDate)) {
      return 'Must be date format';
    }
    return null;
  }

  String? validateAmount(String amount) {
    if (!isFloat(amount)) {
      return 'Must be numeric';
    }
    return null;
  }

  addToTempLines() {
    if (expenseLineKey.currentState!.validate()) {
      expenseLineKey.currentState!.save();
      ExpenseLineModel expenseLineModel = ExpenseLineModel(
          duedate: dueDateContoller.text,
          subAmount: double.parse(amountContoller.text));
      tempExpenseLines.add(expenseLineModel);

      dueDateContoller.text = '';
      amountContoller.text = '';
      notifyListeners();
    }
  }

  getExpenseLine() async {
    allExpenseLines = await ExpLinesDBHelper.dbHelper
        .getAllExpLines(expHeaderId: headerModel?.id ?? -1);

    notifyListeners();
  }

  updateHeaderModel(ExpenseHeaderModel headerModel) {
    this.headerModel = headerModel;
    getExpenseLine();
  }

  updateExpenseLine(ExpenseLineModel expenseLine) async {
    await ExpLinesDBHelper.dbHelper.updateExpLine(expenseLine);

    getExpenseLine();
  }

  insertExpenseLines(int headerId) async {
    for (ExpenseLineModel expenseLine in tempExpenseLines) {
      expenseLine.headerId = headerId;
      await ExpLinesDBHelper.dbHelper.insertNewExpLine(expenseLine);
    }
    clearFields();
    getExpenseLine();
    AppRouter.appRouter.pop();
  }
}
