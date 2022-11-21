import 'dart:developer';

import 'package:my_wallet/expenses/data_repository/db_helper.dart';
import 'package:my_wallet/expenses/data_repository/ddl/expense_ddl.dart';
import 'package:my_wallet/expenses/expense_category/models/expense_category_model.dart';
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
}
