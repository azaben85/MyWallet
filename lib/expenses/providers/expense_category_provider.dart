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
  TextEditingController textController = TextEditingController();
  String? categoryName;
  ExpenseCategoryModel? expCategory;

  setCategoryName(String categoryName) {
    this.categoryName = categoryName;
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
          ExpenseCategoryModel(name: categoryName);
      await ExpCatDBHelper.expCatDBHelper.insertNewExpCategory(expenseCategory);
      categoryName = '';
      getExpenseCategories();
      AppRouter.appRouter.pop();
    }
  }
}
