import 'dart:developer';

import 'package:my_wallet/app_data_repository/db_helper.dart';
import 'package:my_wallet/app_data_repository/ddl/expense_ddl.dart';
import 'package:my_wallet/app_provider/app_config_provider.dart';
import 'package:my_wallet/expenses/expense_lines/models/expense_line_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

class ExpLinesDBHelper {
  ExpLinesDBHelper._();

  static ExpLinesDBHelper dbHelper = ExpLinesDBHelper._();

  ExpenseLinesDDL expenseLineTable = DBHelper.dbHelper.expenseLinesDDL;
  ExpenseHeaderDDL expenseHeaderTable = DBHelper.dbHelper.expenseHeaderDDL;
  ExpenseCategoryDDL expenseCategoryTable =
      DBHelper.dbHelper.expenseCategoryDDL;

  Future<double> getExpenseTotal({
    int expHeaderId = -1,
    String? month = '',
  }) async {
    String onDate = ' ';
    String header_id_condition = ' ';

    if (expHeaderId > -1) {
      header_id_condition =
          ' and  l.${expenseLineTable.headerIdColumn} = $expHeaderId';
    }
    if (month!.isNotEmpty) {
      DateTime tempDate = DateFormat(dateFormat).parse(month);
      String date = DateFormat("yyyy-MM-").format(tempDate);

      onDate = " and   l.${expenseLineTable.duedateColumn} like '$date%' ";
    }
    String sqlStatement =
        '''select sum(l.${expenseLineTable.subAmountColumn}) total_amount 
     from   ${expenseLineTable.tableName} l  
          
        where  1= 1 
         $header_id_condition
         $onDate
     ''';

    log(sqlStatement);
    List<Map<String, dynamic>> data =
        await DBHelper.dbHelper.database!.rawQuery(sqlStatement);

    return data[0]['total_amount'] ?? 0;
  }

  Future<List<ExpenseLineModel>> getAllExpLines({int expHeaderId = -1}) async {
    List<Map<String, dynamic>> data;
    if (expHeaderId == -1) {
      data =
          await DBHelper.dbHelper.database!.query(expenseLineTable.tableName);
    } else {
      data = await DBHelper.dbHelper.database!.query(expenseLineTable.tableName,
          where: '${expenseLineTable.headerIdColumn} = ?',
          whereArgs: [expHeaderId],
          orderBy: expenseLineTable.duedateColumn);
    }
    return data.map((e) => ExpenseLineModel.fromMap(e)).toList();
  }

  Future<int> insertNewExpLine(ExpenseLineModel expenseLinesModel) async {
    Database database = DBHelper.dbHelper.database!;
    int id = await database.insert(
        expenseLineTable.tableName, expenseLinesModel.toMap());
    return id;
  }

  Future<int> updateExpLine(ExpenseLineModel expenseLineModel) async {
    Database database = DBHelper.dbHelper.database!;

    int updatedCount = await database.update(
        expenseLineTable.tableName, expenseLineModel.toMap(),
        where: 'id=?', whereArgs: [expenseLineModel.id]);
    return updatedCount;
  }

  Future<int> deleteExpLine(int linId) async {
    Database database = DBHelper.dbHelper.database!;

    int updatedCount = await database
        .delete(expenseLineTable.tableName, where: 'id=?', whereArgs: [linId]);
    return updatedCount;
  }
}
