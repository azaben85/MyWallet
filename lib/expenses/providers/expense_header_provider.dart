import 'package:flutter/material.dart';
import 'package:my_wallet/expenses/data_repository/db_expense_header_helper.dart';
import 'package:my_wallet/expenses/expense_category/models/expense_category_model.dart';
import 'package:my_wallet/expenses/expense_header/models/expense_header_model.dart';

class ExpenseHeaderProvider extends ChangeNotifier {
  ExpenseHeaderProvider() {
    getExpenseHeader();
  }

  List<ExpenseHeaderModel> allExpenseHeader = [];

  getExpenseHeader() async {
    allExpenseHeader = await ExpHeaderDBHelper.dbHelper
        .getAllExpHeaders(expCategoryId: expCategory?.id ?? -1);

    notifyListeners();
  }

  ExpenseCategoryModel? expCategory;

  updateCategoryModel(ExpenseCategoryModel expCategory) {
    this.expCategory = expCategory;
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
        categoryId: expCategory!.id!,
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
