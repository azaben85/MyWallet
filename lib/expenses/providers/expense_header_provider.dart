import 'package:flutter/material.dart';
import 'package:my_wallet/expenses/data_repository/db_expense_header_helper.dart';
import 'package:my_wallet/expenses/models/expense_header_model.dart';

class ExpenseHeaderProvider extends ChangeNotifier {
  ExpenseHeaderProvider() {
    getExpenseHeader();
  }

  List<ExpenseHeaderModel> allExpenseHeader = [];

  getExpenseHeader() async {
    allExpenseHeader = await ExpHeaderDBHelper.dbHelper
        .getAllExpHeaders(expCategoryId: expCategoryId ?? -1);

    notifyListeners();
  }

  int? expCategoryId;

  updateCategoryId(int expCategoryId) {
    this.expCategoryId = expCategoryId;
    getExpenseHeader();
  }

  TextEditingController nameTextController = TextEditingController();
  TextEditingController amountTextController = TextEditingController();
  bool autoBill = false;
  TextEditingController endDateTextController = TextEditingController();
  TextEditingController startDateTextController = TextEditingController();
  setAutoBill(bool value) {
    autoBill = value;
    notifyListeners();
  }

  insertExpenseHeader() async {
    ExpenseHeaderModel expenseHeader = ExpenseHeaderModel(
        expenseName: nameTextController.text,
        amount: double.parse(amountTextController.text),
        autoBill: autoBill,
        categoryId: expCategoryId!,
        endDate: endDateTextController.text,
        startDate: startDateTextController.text);
    await ExpHeaderDBHelper.dbHelper.insertNewExpHeader(expenseHeader);
    nameTextController.text = '';
    amountTextController.text = '';
    endDateTextController.text = '';
    startDateTextController.text = '';
    autoBill = false;
    getExpenseHeader();
  }
}
