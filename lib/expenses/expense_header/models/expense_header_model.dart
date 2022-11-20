// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:my_wallet/expenses/data_repository/db_helper.dart';
import 'package:my_wallet/expenses/models/expense_line_model.dart';
import 'package:my_wallet/helper/util.dart';

class ExpenseHeaderModel {
  int? id;
  String expenseName;
  String? expenseDesc;
  num amount;
  bool inBank;
  String startDate;
  String endDate;
  int categoryId;
  List<ExpenseLineModel>? expenseLinesModelList;
  ExpenseHeaderModel({
    this.id,
    required this.expenseName,
    this.expenseDesc = '',
    required this.amount,
    required this.startDate,
    required this.endDate,
    required this.categoryId,
    this.inBank = false,
    this.expenseLinesModelList,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      //  DBHelper.dbHelper.expenseHeaderDDL.idColumn: id,
      DBHelper.dbHelper.expenseHeaderDDL.expenseNameColumn: expenseName,
      DBHelper.dbHelper.expenseHeaderDDL.expenseDescColumn: expenseDesc,
      DBHelper.dbHelper.expenseHeaderDDL.amountColumn: amount,
      DBHelper.dbHelper.expenseHeaderDDL.inBankColumn: boolToInt(inBank),
      DBHelper.dbHelper.expenseHeaderDDL.startDateColumn: startDate,
      DBHelper.dbHelper.expenseHeaderDDL.endDateColumn: endDate,
      DBHelper.dbHelper.expenseHeaderDDL.categoryIdColumn: categoryId,
    };
  }

  factory ExpenseHeaderModel.fromMap(Map<String, dynamic> map) {
    return ExpenseHeaderModel(
        id: map[DBHelper.dbHelper.expenseHeaderDDL.idColumn] as int,
        expenseName:
            map[DBHelper.dbHelper.expenseHeaderDDL.expenseDescColumn] as String,
        expenseDesc:
            map[DBHelper.dbHelper.expenseHeaderDDL.expenseNameColumn] as String,
        amount: map[DBHelper.dbHelper.expenseHeaderDDL.amountColumn] as num,
        inBank: intToBool(
            map[DBHelper.dbHelper.expenseHeaderDDL.inBankColumn] as int),
        startDate:
            map[DBHelper.dbHelper.expenseHeaderDDL.startDateColumn] as String,
        endDate:
            map[DBHelper.dbHelper.expenseHeaderDDL.endDateColumn] as String,
        categoryId:
            map[DBHelper.dbHelper.expenseHeaderDDL.categoryIdColumn] as int);
  }
}
