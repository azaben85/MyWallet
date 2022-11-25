import 'package:my_wallet/expenses/data_repository/db_expense_header_helper.dart';
import 'package:my_wallet/expenses/data_repository/db_helper.dart';
import 'package:my_wallet/expenses/data_repository/ddl/expense_ddl.dart';
import 'package:my_wallet/expenses/expense_category/models/expense_category_model.dart';
import 'package:my_wallet/expenses/expense_header/models/expense_header_model.dart';
import 'package:sqflite/sqflite.dart';

class ExpCatDBHelper {
  ExpCatDBHelper._();

  static ExpCatDBHelper expCatDBHelper = ExpCatDBHelper._();

  ExpenseCategoryDDL table = DBHelper.dbHelper.expenseCategoryDDL;

  Future<List<ExpenseCategoryModel>> getAllExpCategories() async {
    List<Map<String, dynamic>> data =
        await DBHelper.dbHelper.database!.query(table.tableName);

    return data.map((e) => ExpenseCategoryModel.fromMap(e)).toList();
  }

  Future<int> insertNewExpCategory(
      ExpenseCategoryModel expenseCategoryModel) async {
    Database database = DBHelper.dbHelper.database!;
    int id =
        await database.insert(table.tableName, expenseCategoryModel.toMap());
    return id;
  }

  Future<int> updateExpCategory(
      ExpenseCategoryModel expenseCategoryModel) async {
    Database database = DBHelper.dbHelper.database!;

    int updatedCount = await database.update(
        table.tableName, expenseCategoryModel.toMap(),
        where: 'id=?', whereArgs: [expenseCategoryModel.id]);
    return updatedCount;
  }

  Future<int> deleteExpCategory(int id) async {
    Database database = DBHelper.dbHelper.database!;

    List<ExpenseHeaderModel> expenseHeaderList =
        await ExpHeaderDBHelper.dbHelper.getAllExpHeaders(expCategoryId: id);

    for (ExpenseHeaderModel expenseHeader in expenseHeaderList) {
      await ExpHeaderDBHelper.dbHelper.deleteExpHeader(expenseHeader.id!);
    }
    int updatedCount =
        await database.delete(table.tableName, where: 'id=?', whereArgs: [id]);
    return updatedCount;
  }
}
