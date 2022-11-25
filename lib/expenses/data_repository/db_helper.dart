import 'dart:developer';
import 'dart:io';

import 'package:my_wallet/expenses/data_repository/ddl/expense_ddl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  Database? database;

  DBHelper._();

  static DBHelper dbHelper = DBHelper._();

  bool dropMode = false;
  ExpenseLinesDDL expenseLinesDDL = ExpenseLinesDDL();
  ExpenseHeaderDDL expenseHeaderDDL = ExpenseHeaderDDL();
  ExpenseCategoryDDL expenseCategoryDDL = ExpenseCategoryDDL();

  Future<Database> createDatabaseConnection() async {
    Directory folderDirectory = await getApplicationDocumentsDirectory();
    String folderPath = folderDirectory.path;
    database = await openDatabase(
      '$folderPath/mywallet.db',
      version: 1,
      onCreate: (db, version) {
        log('the db is created');
      },
      onOpen: (db) {
        log('Connected');
      },
    );
    await createTables();
    return database!;
  }

  createTables() async {
    createTable(expenseLinesDDL.tableName, ''' 
        CREATE TABLE ${expenseLinesDDL.tableName} (
          ${expenseLinesDDL.idColumn} INTEGER  primary key autoincrement , 
          ${expenseLinesDDL.headerIdColumn} INTEGER,
          ${expenseLinesDDL.subAmountColumn} REAL,
            ${expenseLinesDDL.duedateColumn} TEXT
        )
      ''');

    createTable(expenseHeaderDDL.tableName, ''' 
        CREATE TABLE ${expenseHeaderDDL.tableName} (
          ${expenseHeaderDDL.idColumn} INTEGER  primary key autoincrement , 
          ${expenseHeaderDDL.expenseNameColumn} TEXT,
          ${expenseHeaderDDL.amountColumn} REAL,
            ${expenseHeaderDDL.categoryIdColumn} INTEGER,
            ${expenseHeaderDDL.inBankColumn} INTEGER,
            ${expenseHeaderDDL.expenseDescColumn} TEXT,
            ${expenseHeaderDDL.startDateColumn} TEXT,
            ${expenseHeaderDDL.endDateColumn} TEXT
        )
      ''');

    createTable(expenseCategoryDDL.tableName, ''' 
        CREATE TABLE ${expenseCategoryDDL.tableName} (
          ${expenseCategoryDDL.idColumn} INTEGER  primary key autoincrement , 
          ${expenseCategoryDDL.nameColumn} TEXT,
          ${expenseCategoryDDL.instantColumn} int
        )
      ''');
  }

  createTable(String tableName, String ddl) async {
    int exists = await checkIfTableExists(tableName);
    if (exists > 0) {
      exists = await dropTable(tableName);
    }
    if (exists == 0) {
      await database!.execute(ddl);
      log('$tableName was created');
    }
  }

  Future<int> dropTable(String tableName) async {
    if (dropMode) {
      await database!.execute('''drop table $tableName''');
      log('$tableName was DROPPED');
      return 0;
    }
    return 1;
  }

  Future<int> checkIfTableExists(String tableName) async {
    List<Map<String, dynamic>> table = await database!
        .query('sqlite_master', where: 'name = ?', whereArgs: [tableName]);
    return table.length;
  }

  connectIfClosed() async {
    if (database == null || !database!.isOpen) {
      await createDatabaseConnection();
    }
  }
}
