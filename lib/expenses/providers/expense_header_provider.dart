import 'package:flutter/material.dart';
import 'package:my_wallet/app_router/app_router.dart';
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

  GlobalKey<FormState> expenseHeaderKey = GlobalKey<FormState>();

  String? headerName;

  String? headerDesc;
  bool? inBank;

  setHeaderName(String headerName) {
    this.headerName = headerName;
  }

  setHeaderDesc(String? headerDesc) {
    this.headerDesc = headerDesc;
  }

  setInBank(bool value) {
    inBank = value;
    notifyListeners();
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Must have value';
    }
    return null;
  }

  insertExpenseHeader() async {
    if (expenseHeaderKey.currentState!.validate()) {
      expenseHeaderKey.currentState!.save();
      ExpenseHeaderModel expenseHeader = ExpenseHeaderModel(
          expenseName: headerName ?? '',
          expenseDesc: headerDesc ?? '',
          amount: 0.0,
          inBank: inBank ?? false,
          categoryId: expCategory!.id!,
          endDate: '',
          startDate: '');
      await ExpHeaderDBHelper.dbHelper.insertNewExpHeader(expenseHeader);
      headerName = '';
      headerDesc = '';
      inBank = false;
      getExpenseHeader();
      AppRouter.appRouter.pop();
    }
  }
}
