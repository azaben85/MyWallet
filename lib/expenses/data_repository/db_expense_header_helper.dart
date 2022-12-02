import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:my_wallet/app_data_repository/db_helper.dart';
import 'package:my_wallet/app_data_repository/ddl/expense_ddl.dart';
import 'package:my_wallet/app_provider/app_config_provider.dart';
import 'package:my_wallet/expenses/data_repository/db_expense_lines_helper.dart';
import 'package:my_wallet/expenses/expense_header/models/expense_header_model.dart';
import 'package:my_wallet/expenses/expense_lines/models/expense_line_model.dart';
import 'package:sqflite/sqflite.dart';

class ExpHeaderDBHelper {
  ExpHeaderDBHelper._();

  static ExpHeaderDBHelper dbHelper = ExpHeaderDBHelper._();
  ExpenseCategoryDDL expenseCategoryTable =
      DBHelper.dbHelper.expenseCategoryDDL;

  ExpenseLinesDDL expenseLineTable = DBHelper.dbHelper.expenseLinesDDL;
  ExpenseHeaderDDL expenseHeaderTable = DBHelper.dbHelper.expenseHeaderDDL;

  Future<List<ExpenseHeaderModel>> getAllExpHeaders(
      {String? month = '', int expCategoryId = -1}) async {
    String onDate = ' ';
    if (month!.isNotEmpty) {
      DateTime tempDate = DateFormat(dateFormat).parse(month);
      String date = DateFormat("yyyy-MM-").format(tempDate);

      onDate = " and   l.${expenseLineTable.duedateColumn} like '$date%' ";
    }

    String sqlStatement =
        '''select ${getColumns('h')}   ,sum(l.${expenseLineTable.subAmountColumn}) total_amount 
     from 
     ${expenseCategoryTable.tableName} c left outer join ${expenseHeaderTable.tableName} h 
          on h.${expenseHeaderTable.categoryIdColumn} = c.${expenseCategoryTable.idColumn}
      left outer join  ${expenseLineTable.tableName} l on l.${expenseLineTable.headerIdColumn} = h.${expenseHeaderTable.idColumn}
          $onDate 
          where 
          h.${expenseHeaderTable.categoryIdColumn} = $expCategoryId
     ''';
    sqlStatement = '$sqlStatement      group by ${getColumns('h')}  ';

    log(sqlStatement);
    List<Map<String, dynamic>> data =
        await DBHelper.dbHelper.database!.rawQuery(sqlStatement);

    return data.map((e) => ExpenseHeaderModel.fromMap(e)).toList();
  }

  String getColumns(String alias) {
    return ' $alias.${expenseHeaderTable.idColumn} , $alias.${expenseHeaderTable.amountColumn} ,$alias.${expenseHeaderTable.categoryIdColumn},$alias.${expenseHeaderTable.endDateColumn},$alias.${expenseHeaderTable.expenseDescColumn},$alias.${expenseHeaderTable.expenseNameColumn},$alias.${expenseHeaderTable.idColumn} ,$alias.${expenseHeaderTable.inBankColumn},$alias.${expenseHeaderTable.startDateColumn} ';
  }
  // Future<List<ExpenseHeaderModel>> getAllExpHeaders(
  //     {int expCategoryId = -1}) async {
  //   List<Map<String, dynamic>> data;
  //   if (expCategoryId == -1) {
  //     data = await DBHelper.dbHelper.database!.query(expenseHeaderTable.tableName);
  //   } else {
  //     data = await DBHelper.dbHelper.database!.query(expenseHeaderTable.tableName,
  //         where: '${expenseHeaderTable.categoryIdColumn} = ?', whereArgs: [expCategoryId]);
  //   }

  //   return data.map((e) => ExpenseHeaderModel.fromMap(e)).toList();
  // }

  Future<int> insertNewExpHeader(ExpenseHeaderModel expenseHeaderModel) async {
    Database database = DBHelper.dbHelper.database!;
    int id = await database.insert(
        expenseHeaderTable.tableName, expenseHeaderModel.toMap());
    return id;
  }

  Future<int> updateExpHeader(ExpenseHeaderModel expenseHeaderModel) async {
    Database database = DBHelper.dbHelper.database!;

    int updatedCount = await database.update(
        expenseHeaderTable.tableName, expenseHeaderModel.toMap(),
        where: 'id=?', whereArgs: [expenseHeaderModel.id]);
    return updatedCount;
  }

  Future<int> deleteExpHeader(int id) async {
    Database database = DBHelper.dbHelper.database!;

    List<ExpenseLineModel> expenseLineList =
        await ExpLinesDBHelper.dbHelper.getAllExpLines(expHeaderId: id);

    for (ExpenseLineModel expenseLine in expenseLineList) {
      await ExpLinesDBHelper.dbHelper.deleteExpLine(expenseLine.id!);
    }

    int updatedCount = await database
        .delete(expenseHeaderTable.tableName, where: 'id=?', whereArgs: [id]);
    return updatedCount;
  }
}
