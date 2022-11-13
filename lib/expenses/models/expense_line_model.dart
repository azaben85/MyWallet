import 'package:my_wallet/expenses/data_repository/db_helper.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ExpenseLineModel {
  int id;
  num subAmount;
  String duedate;
  int headerId;

  ExpenseLineModel({
    required this.id,
    required this.subAmount,
    required this.duedate,
    required this.headerId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      DBHelper.dbHelper.expenseLinesDDL.idColumn: id,
      DBHelper.dbHelper.expenseLinesDDL.subAmountColumn: subAmount,
      DBHelper.dbHelper.expenseLinesDDL.duedateColumn: duedate,
      DBHelper.dbHelper.expenseLinesDDL.headerIdColumn: headerId,
    };
  }

  factory ExpenseLineModel.fromMap(Map<String, dynamic> map) {
    return ExpenseLineModel(
      id: map[DBHelper.dbHelper.expenseLinesDDL.idColumn] as int,
      subAmount: map[DBHelper.dbHelper.expenseLinesDDL.subAmountColumn] as num,
      duedate: map[DBHelper.dbHelper.expenseLinesDDL.duedateColumn] as String,
      headerId: map[DBHelper.dbHelper.expenseLinesDDL.headerIdColumn] as int,
    );
  }
}
