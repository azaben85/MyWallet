import 'package:my_wallet/app_data_repository/db_helper.dart';
import 'package:my_wallet/app_data_repository/ddl/expense_ddl.dart';
import 'package:my_wallet/income/models/income_line_model.dart';
import 'package:sqflite/sqflite.dart';

class IncomeLineDBHelper {
  IncomeLineDBHelper._();

  static IncomeLineDBHelper dbHelper = IncomeLineDBHelper._();

  IncomeLinesDDL table = DBHelper.dbHelper.incomeLinesDDL;

  Future<List<IncomeLineModel>> getAllIncomeLines({int header_id = -1}) async {
    List<Map<String, dynamic>> data = await DBHelper.dbHelper.database!.query(
        table.tableName,
        where: '${table.headerIdColumn} = ?',
        whereArgs: [header_id]);

    return data.map((e) => IncomeLineModel.fromMap(e)).toList();
  }

  Future<int> insertNewIncomeLine(IncomeLineModel incomeLineModel) async {
    Database database = DBHelper.dbHelper.database!;
    int id = await database.insert(table.tableName, incomeLineModel.toMap());
    return id;
  }

  Future<int> updateIncomeLine(IncomeLineModel incomeLineModel) async {
    Database database = DBHelper.dbHelper.database!;

    int updatedCount = await database.update(
        table.tableName, incomeLineModel.toMap(),
        where: '${table.idColumn} = ?', whereArgs: [incomeLineModel.id]);
    return updatedCount;
  }

  Future<int> deleteIncomeLine(int id) async {
    Database database = DBHelper.dbHelper.database!;

    int updatedCount = await database.delete(table.tableName,
        where: '${table.idColumn} =?', whereArgs: [id]);
    return updatedCount;
  }

  Future<int> deleteIncomeLineByHeaderId(int header_id) async {
    Database database = DBHelper.dbHelper.database!;

    int updatedCount = await database.delete(table.tableName,
        where: '${table.headerIdColumn} =?', whereArgs: [header_id]);
    return updatedCount;
  }
}
