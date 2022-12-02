import 'dart:developer';

import 'package:my_wallet/app_provider/app_config_provider.dart';
import 'package:my_wallet/expenses/data_repository/db_expense_header_helper.dart';
import 'package:my_wallet/app_data_repository/db_helper.dart';
import 'package:my_wallet/app_data_repository/ddl/expense_ddl.dart';
import 'package:my_wallet/expenses/expense_category/models/expense_category_model.dart';
import 'package:my_wallet/expenses/expense_header/models/expense_header_model.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class ExpCatDBHelper {
  ExpCatDBHelper._();

  static ExpCatDBHelper expCatDBHelper = ExpCatDBHelper._();

  ExpenseCategoryDDL expenseCategoryTable =
      DBHelper.dbHelper.expenseCategoryDDL;

  ExpenseLinesDDL expenseLineTable = DBHelper.dbHelper.expenseLinesDDL;
  ExpenseHeaderDDL expenseHeaderTable = DBHelper.dbHelper.expenseHeaderDDL;

  Future<List<ExpenseCategoryModel>> getAllExpCategories(
      {String? month = ''}) async {
    String onDate = ' ';
    if (month!.isNotEmpty) {
      DateTime tempDate = DateFormat(dateFormat).parse(month);
      String date = DateFormat("yyyy-MM-").format(tempDate);

      onDate = " and   l.${expenseLineTable.duedateColumn} like '$date%' ";
    }

    String sqlStatement =
        '''select ${getColumns('c')}   ,sum(l.${expenseLineTable.subAmountColumn}) total_amount 
     from 
     ${expenseCategoryTable.tableName} c left outer join ${expenseHeaderTable.tableName} h 
          on h.${expenseHeaderTable.categoryIdColumn} = c.${expenseCategoryTable.idColumn}
      left outer join  ${expenseLineTable.tableName} l on l.${expenseLineTable.headerIdColumn} = h.${expenseHeaderTable.idColumn}
          $onDate 
     ''';

    sqlStatement = '$sqlStatement      group by ${getColumns('c')}  ';
    log(sqlStatement);
    List<Map<String, dynamic>> data =
        await DBHelper.dbHelper.database!.rawQuery(sqlStatement);

    return data.map((e) => ExpenseCategoryModel.fromMap(e)).toList();
  }

  String getColumns(String alias) {
    return ' $alias.${expenseCategoryTable.idColumn} , $alias.${expenseCategoryTable.instantColumn} , $alias.${expenseCategoryTable.nameColumn} ';
  }
  // Future<List<ExpenseCategoryModel>> getAllExpCategories() async {
  //   List<Map<String, dynamic>> data =
  //       await DBHelper.dbHelper.database!.query(expenseCategoryTable.tableName);

  //   return data.map((e) => ExpenseCategoryModel.fromMap(e)).toList();
  // }

  Future<int> insertNewExpCategory(
      ExpenseCategoryModel expenseCategoryModel) async {
    Database database = DBHelper.dbHelper.database!;
    int id = await database.insert(
        expenseCategoryTable.tableName, expenseCategoryModel.toMap());
    return id;
  }

  Future<int> updateExpCategory(
      ExpenseCategoryModel expenseCategoryModel) async {
    Database database = DBHelper.dbHelper.database!;

    int updatedCount = await database.update(
        expenseCategoryTable.tableName, expenseCategoryModel.toMap(),
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
    int updatedCount = await database
        .delete(expenseCategoryTable.tableName, where: 'id=?', whereArgs: [id]);
    return updatedCount;
  }
}
