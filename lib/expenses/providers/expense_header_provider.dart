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
  int? categoryId;
  int? headerId;

  int currentStep = 0;

  nextStep() async {
    if (currentStep == 1) {
      await insertUpdateExpenseHeader();
    } else {
      currentStep++;
      notifyListeners();
    }
  }

  previousStep() {
    if (currentStep == 0) {
      AppRouter.appRouter.pop();
    } else {
      currentStep--;
      notifyListeners();
    }
  }

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

  loadDataForUpdate(ExpenseHeaderModel expenseHeaderModel) {
    categoryId = expenseHeaderModel.categoryId;
    headerName = expenseHeaderModel.expenseName;
    headerDesc = expenseHeaderModel.expenseDesc;
    inBank = expenseHeaderModel.inBank;
    headerId = expenseHeaderModel.id;
    notifyListeners();
  }

  resetFields() {
    headerName = '';
    headerDesc = '';
    inBank = false;
    headerId = null;
    currentStep = 0;
  }

  String? validateString(String? value) {
    if (value == null || value.isEmpty) {
      return 'Must have value';
    }
    return null;
  }

  validateFields() {
    if (expenseHeaderKey.currentState!.validate()) {
      nextStep();
    }
  }

  insertUpdateExpenseHeader() async {
    if (expenseHeaderKey.currentState!.validate()) {
      expenseHeaderKey.currentState!.save();
      ExpenseHeaderModel expenseHeader = ExpenseHeaderModel(
          id: headerId,
          expenseName: headerName ?? '',
          expenseDesc: headerDesc ?? '',
          amount: 0.0,
          inBank: inBank ?? false,
          categoryId: expCategory!.id!,
          endDate: '',
          startDate: '');

      if (headerId == null) {
        await ExpHeaderDBHelper.dbHelper.insertNewExpHeader(expenseHeader);
      } else {
        await ExpHeaderDBHelper.dbHelper.updateExpHeader(expenseHeader);
      }
      resetFields();
      getExpenseHeader();
      AppRouter.appRouter.pop();
    }
  }

  deleteExpenseHeader() async {
    await ExpHeaderDBHelper.dbHelper.deleteExpHeader(headerId ?? -1);
    resetFields();

    getExpenseHeader();
    AppRouter.appRouter.pop();
  }
}
