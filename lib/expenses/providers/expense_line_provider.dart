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
  TextEditingController descContoller = TextEditingController();

  int? headerId;
  int? lineId;
  double? total_amount = 0;

  ExpenseHeaderModel? headerModel;

  clearFields() {
    dueDateContoller.text = '';
    amountContoller.text = '';
    descContoller.text = '';
    lineId = null;
    tempExpenseLines.clear();
  }

  loadDataForUpdate(ExpenseLineModel expenseLineModel) {
    dueDateContoller.text = expenseLineModel.duedate;
    amountContoller.text = expenseLineModel.subAmount.toString();
    descContoller.text = expenseLineModel.description ?? '';
    lineId = expenseLineModel.id;
  }

  String? validateDate(String dueDate) {
    if (!isDate(dueDate)) {
      return 'Must be date format';
    }
    return null;
  }

  String? validateAmount(String amount) {
    if (!isFloat(amountContoller.text) || amountContoller.text.isEmpty) {
      return 'Must be numeric';
    }
    return null;
  }

  String? validateDesc(String desc) {
    if (descContoller.text.isEmpty) {
      return 'Must have value';
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
    total_amount = await ExpLinesDBHelper.dbHelper
        .getExpenseTotal(expHeaderId: headerModel?.id ?? -1);
    notifyListeners();
  }

  updateHeaderModel(ExpenseHeaderModel headerModel) {
    this.headerModel = headerModel;
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

  insertExpenseLine() async {
    if (expenseLineKey.currentState!.validate()) {
      expenseLineKey.currentState!.save();
      ExpenseLineModel expenseLineModel = ExpenseLineModel(
          description: descContoller.text,
          headerId: headerModel!.id,
          duedate: dueDateContoller.text,
          subAmount: double.parse(amountContoller.text));
      if (lineId == null) {
        await ExpLinesDBHelper.dbHelper.insertNewExpLine(expenseLineModel);
      } else {
        expenseLineModel.id = lineId;
        await ExpLinesDBHelper.dbHelper.updateExpLine(expenseLineModel);
      }
      clearFields();
      getExpenseLine();
      AppRouter.appRouter.pop();
    }
  }

  deleteExpenseLine() async {
    AppRouter.appRouter.showConfirmDialog(
        'Delete Type', Text('Are you sure to delete the record?'), () async {
      await ExpLinesDBHelper.dbHelper.deleteExpLine(lineId ?? -1);
      clearFields();
      getExpenseLine();
      AppRouter.appRouter.pop();
    });
  }
}
