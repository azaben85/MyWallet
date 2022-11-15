import 'package:flutter/material.dart';
import 'package:my_wallet/expenses/data_repository/db_expense_category_helper.dart';
import 'package:my_wallet/expenses/models/expense_category_model.dart';

class ExpenseCategoryProvider extends ChangeNotifier {
  ExpenseCategoryProvider() {
    getExpenseCategories();
  }

  List<ExpenseCategoryModel> allExpenseCategories = [];
  TextEditingController textController = TextEditingController();
  ExpenseCategoryModel? expCategory;

  updateCategory(ExpenseCategoryModel expCategoryId) {
    this.expCategory = expCategoryId;
    notifyListeners();
  }

  getExpenseCategories() async {
    allExpenseCategories =
        await ExpCatDBHelper.expCatDBHelper.getAllExpCategories();

    notifyListeners();
  }

  insertExpenseCategor() async {
    ExpenseCategoryModel expenseCategory =
        ExpenseCategoryModel(name: textController.text);
    await ExpCatDBHelper.expCatDBHelper.insertNewExpCategory(expenseCategory);
    textController.text = '';
    getExpenseCategories();
  }
}
