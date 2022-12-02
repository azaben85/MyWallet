import 'package:flutter/material.dart';
import 'package:my_wallet/app_provider/app_config_provider.dart';
import 'package:my_wallet/app_router/app_router.dart';
import 'package:my_wallet/expenses/data_repository/db_expense_category_helper.dart';
import 'package:intl/intl.dart';
import 'package:my_wallet/expenses/data_repository/db_expense_lines_helper.dart';
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

  String? monthDate = DateFormat(dateFormat).format(DateTime.now());
  setMonthDate(String monthDate) async {
    this.monthDate = monthDate;
    await getExpenseCategories();
  }

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
    allExpenseCategories = await ExpCatDBHelper.expCatDBHelper
        .getAllExpCategories(month: monthDate);

    notifyListeners();
  }

  insertUpdateExpenseCategory() async {
    if (expenseCatKey.currentState!.validate()) {
      expenseCatKey.currentState!.save();
      ExpenseCategoryModel expenseCategory = ExpenseCategoryModel(
          id: catId, name: categoryName, instant: instantType);
      if (catId == null) {
        await ExpCatDBHelper.expCatDBHelper
            .insertNewExpCategory(expenseCategory);
      } else {
        await ExpCatDBHelper.expCatDBHelper.updateExpCategory(expenseCategory);
      }
      clearFields();
      getExpenseCategories();
      AppRouter.appRouter.pop();
    }
  }

  void clearFields() {
    categoryName = '';
    instantType = false;
    catId = null;
  }

  deleteExpenseCategory() async {
    AppRouter.appRouter.showConfirmDialog(
        'Delete Category', Text('Are you sure to delete the category?'),
        () async {
      await ExpCatDBHelper.expCatDBHelper.deleteExpCategory(catId ?? -1);
      clearFields();

      getExpenseCategories();
      AppRouter.appRouter.pop();
    });
  }
}
