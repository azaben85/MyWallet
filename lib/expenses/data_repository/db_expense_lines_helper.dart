import 'package:my_wallet/expenses/data_repository/db_helper.dart';
import 'package:my_wallet/expenses/data_repository/ddl/expense_ddl.dart';
import 'package:my_wallet/expenses/models/expense_line_model.dart';
import 'package:sqflite/sqflite.dart';

class ExpLinesDBHelper {
  ExpLinesDBHelper._();

  static ExpLinesDBHelper dbHelper = ExpLinesDBHelper._();

  ExpenseLinesDDL table = DBHelper.dbHelper.expenseLinesDDL;

  Future<List<ExpenseLineModel>> getAllExpLines({int expHeaderId = -1}) async {
    List<Map<String, dynamic>> data;
    if (expHeaderId == -1) {
      data = await DBHelper.dbHelper.database!.query(table.tableName);
    } else {
      data = await DBHelper.dbHelper.database!.query(table.tableName,
          where: '${table.headerIdColumn} = ?', whereArgs: [expHeaderId]);
    }

    return data.map((e) => ExpenseLineModel.fromMap(e)).toList();
  }

  Future<int> insertNewExpLine(ExpenseLineModel expenseLinesModel) async {
    Database database = DBHelper.dbHelper.database!;
    int id = await database.insert(table.tableName, expenseLinesModel.toMap());
    return id;
  }

  Future<int> updateExpLine(ExpenseLineModel expenseLineModel) async {
    Database database = DBHelper.dbHelper.database!;

    int updatedCount = await database.update(
        table.tableName, expenseLineModel.toMap(),
        where: 'id=?', whereArgs: [expenseLineModel.id]);
    return updatedCount;
  }

  Future<int> deleteExpLine(int linId) async {
    Database database = DBHelper.dbHelper.database!;

    int updatedCount = await database
        .delete(table.tableName, where: 'id=?', whereArgs: [linId]);
    return updatedCount;
  }
}
