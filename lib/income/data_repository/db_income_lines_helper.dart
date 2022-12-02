import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:my_wallet/app_data_repository/db_helper.dart';
import 'package:my_wallet/app_data_repository/db_helper.dart';
import 'package:my_wallet/app_data_repository/ddl/expense_ddl.dart';
import 'package:my_wallet/app_data_repository/ddl/expense_ddl.dart';
import 'package:my_wallet/app_provider/app_config_provider.dart';
import 'package:my_wallet/expenses/expense_lines/models/expense_line_model.dart';
import 'package:my_wallet/income/models/income_line_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqflite.dart';

class IncomeLineDBHelper {
  IncomeLineDBHelper._();

  static IncomeLineDBHelper dbHelper = IncomeLineDBHelper._();

  IncomeLinesDDL walletLineDDL = DBHelper.dbHelper.incomeLinesDDL;

  IncomeHeaderDDL walletHeaderDDL = DBHelper.dbHelper.incomeHeaderDDL;
  Future<double> getExpenseTotal(
      {int expHeaderId = -1, String? month = '', String? type}) async {
    String onDate = ' ';
    String header_id_condition = ' ';

    if (expHeaderId > -1) {
      header_id_condition =
          ' and  l.${walletLineDDL.headerIdColumn} = $expHeaderId';
    }
    if (month!.isNotEmpty) {
      DateTime tempDate = DateFormat(dateFormat).parse(month);
      String date = DateFormat("yyyy-MM-").format(tempDate);

      onDate = " and   l.${walletLineDDL.duedateColumn} like '$date%' ";
    }
    String sqlStatement =
        '''select sum(l.${walletLineDDL.subAmountColumn}) total_amount 
     from   ${walletLineDDL.tableName} l  ,  ${walletHeaderDDL.tableName} h
          
        where  l.${walletLineDDL.headerIdColumn} = h.${walletHeaderDDL.idColumn} 
        and h.${walletHeaderDDL.typeColumn} = '$type'
         $header_id_condition
         $onDate
     ''';

    List<Map<String, dynamic>> data =
        await DBHelper.dbHelper.database!.rawQuery(sqlStatement);

    return data[0]['total_amount'] ?? 0;
  }

  Future<List<IncomeLineModel>> getAllIncomeLines({int header_id = -1}) async {
    List<Map<String, dynamic>> data = await DBHelper.dbHelper.database!.query(
        walletLineDDL.tableName,
        where: '${walletLineDDL.headerIdColumn} = ?',
        whereArgs: [header_id]);

    return data.map((e) => IncomeLineModel.fromMap(e)).toList();
  }

  Future<int> insertNewIncomeLine(IncomeLineModel incomeLineModel) async {
    Database database = DBHelper.dbHelper.database!;
    int id =
        await database.insert(walletLineDDL.tableName, incomeLineModel.toMap());
    return id;
  }

  Future<int> updateIncomeLine(IncomeLineModel incomeLineModel) async {
    Database database = DBHelper.dbHelper.database!;

    int updatedCount = await database.update(
        walletLineDDL.tableName, incomeLineModel.toMap(),
        where: '${walletLineDDL.idColumn} = ?',
        whereArgs: [incomeLineModel.id]);
    return updatedCount;
  }

  Future<int> deleteIncomeLine(int id) async {
    Database database = DBHelper.dbHelper.database!;

    int updatedCount = await database.delete(walletLineDDL.tableName,
        where: '${walletLineDDL.idColumn} =?', whereArgs: [id]);
    return updatedCount;
  }

  Future<int> deleteIncomeLineByHeaderId(int header_id) async {
    Database database = DBHelper.dbHelper.database!;

    int updatedCount = await database.delete(walletLineDDL.tableName,
        where: '${walletLineDDL.headerIdColumn} =?', whereArgs: [header_id]);
    return updatedCount;
  }
}
