import 'package:flutter/material.dart';
import 'package:my_wallet/app_router/app_router.dart';
import 'package:my_wallet/expenses/data_repository/db_expense_category_helper.dart';
import 'package:my_wallet/expenses/expense_category/models/expense_category_model.dart';

class ExpenseCategoryProvider extends ChangeNotifier {
  ExpenseCategoryProvider() {
    getExpenseCategories();
  }
  GlobalKey<FormState> expenseCatKey = GlobalKey<FormState>();

  List<ExpenseCategoryModel> allExpenseCategories = [];
  String? categoryName;
  bool? instantType = false;
  int? catId;
  ExpenseCategoryModel? expCategory;

  setCategoryName(String categoryName) {
    this.categoryName = categoryName;
  }

  setInstantType(bool instantType) {
    this.instantType = instantType;
    notifyListeners();
  }

  loadDataForUpdate(ExpenseCategoryModel expenseCategoryModel) {
    catId = expenseCategoryModel.id;
    categoryName = expenseCategoryModel.name;
    instantType = expenseCategoryModel.instant;
    // notifyListeners();
  }

  String? validateCategoryName(String? categoryName) {
    if (categoryName == null || categoryName.isEmpty) {
      return 'Must have value';
    }
    return null;
  }

  getExpenseCategories() async {
    allExpenseCategories =
        await ExpCatDBHelper.expCatDBHelper.getAllExpCategories();

    notifyListeners();
  }

  insertExpenseCategor() async {
    if (expenseCatKey.currentState!.validate()) {
      expenseCatKey.currentState!.save();
      ExpenseCategoryModel expenseCategory =
          ExpenseCategoryModel(name: categoryName, instant: instantType);
      await ExpCatDBHelper.expCatDBHelper.insertNewExpCategory(expenseCategory);
      categoryName = '';
      instantType = false;
      getExpenseCategories();
      AppRouter.appRouter.pop();
    }
  }

  updateExpenseCategor() async {
    if (expenseCatKey.currentState!.validate()) {
      expenseCatKey.currentState!.save();
      ExpenseCategoryModel expenseCategory = ExpenseCategoryModel(
          id: catId, name: categoryName, instant: instantType);
      await ExpCatDBHelper.expCatDBHelper.updateExpCategory(expenseCategory);
      categoryName = '';
      instantType = false;
      catId = null;
      getExpenseCategories();
      AppRouter.appRouter.pop();
    }
  }
}
