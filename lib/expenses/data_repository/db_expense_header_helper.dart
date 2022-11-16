import 'package:my_wallet/expenses/data_repository/db_helper.dart';
import 'package:my_wallet/expenses/data_repository/ddl/expense_ddl.dart';
import 'package:my_wallet/expenses/models/expense_header_model.dart';
import 'package:sqflite/sqflite.dart';

class ExpHeaderDBHelper {
  ExpHeaderDBHelper._();

  static ExpHeaderDBHelper dbHelper = ExpHeaderDBHelper._();

  ExpenseHeaderDDL table = DBHelper.dbHelper.expenseHeaderDDL;

  Future<List<ExpenseHeaderModel>> getAllExpHeaders(
      {int expCategoryId = -1}) async {
    List<Map<String, dynamic>> data;
    if (expCategoryId == -1) {
      data = await DBHelper.dbHelper.database!.query(table.tableName);
    } else {
      data = await DBHelper.dbHelper.database!.query(table.tableName,
          where: '${table.categoryIdColumn} = ?', whereArgs: [expCategoryId]);
    }

    return data.map((e) => ExpenseHeaderModel.fromMap(e)).toList();
  }

  Future<int> insertNewExpHeader(ExpenseHeaderModel expenseHeaderModel) async {
    Database database = DBHelper.dbHelper.database!;
    int id = await database.insert(table.tableName, expenseHeaderModel.toMap());
    return id;
  }

  Future<int> updateExpHeader(ExpenseHeaderModel expenseHeaderModel) async {
    Database database = DBHelper.dbHelper.database!;

    int updatedCount = await database.update(
        table.tableName, expenseHeaderModel.toMap(),
        where: 'id=?', whereArgs: [expenseHeaderModel.id]);
    return updatedCount;
  }
}