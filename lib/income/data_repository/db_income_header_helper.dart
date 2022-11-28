import 'package:my_wallet/app_data_repository/db_helper.dart';
import 'package:my_wallet/app_data_repository/ddl/expense_ddl.dart';
import 'package:my_wallet/income/models/income_header_model.dart';
import 'package:sqflite/sqflite.dart';

class IncomeHeaderDBHelper {
  IncomeHeaderDBHelper._();

  static IncomeHeaderDBHelper dbHelper = IncomeHeaderDBHelper._();

  IncomeHeaderDDL table = DBHelper.dbHelper.incomeHeaderDDL;

  Future<List<IncomeHeaderModel>> getAllIncomeHeaders(String type) async {
    List<Map<String, dynamic>> data = await DBHelper.dbHelper.database!.query(
        table.tableName,
        where: '${table.typeColumn} = ?',
        whereArgs: [type]);

    return data.map((e) => IncomeHeaderModel.fromMap(e)).toList();
  }

  Future<int> insertNewIncomeHeader(IncomeHeaderModel incomeHeaderModel) async {
    Database database = DBHelper.dbHelper.database!;
    int id = await database.insert(table.tableName, incomeHeaderModel.toMap());
    return id;
  }

  Future<int> updateIncomeHeader(IncomeHeaderModel incomeHeaderModel) async {
    Database database = DBHelper.dbHelper.database!;

    int updatedCount = await database.update(
        table.tableName, incomeHeaderModel.toMap(),
        where: '${table.idColumn} = ?', whereArgs: [incomeHeaderModel.id]);
    return updatedCount;
  }

  Future<int> deleteIncomeHeader(int id) async {
    Database database = DBHelper.dbHelper.database!;

    int updatedCount = await database.delete(table.tableName,
        where: '${table.idColumn} =?', whereArgs: [id]);
    return updatedCount;
  }
}
