import 'package:my_wallet/app_data_repository/db_helper.dart';

class ExpenseLineModel {
  int? id;
  num subAmount;
  String duedate;
  String? description;
  int? headerId;

  ExpenseLineModel(
      {this.id,
      required this.subAmount,
      required this.duedate,
      this.headerId,
      this.description});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      DBHelper.dbHelper.expenseLinesDDL.subAmountColumn: subAmount,
      DBHelper.dbHelper.expenseLinesDDL.duedateColumn: duedate,
      DBHelper.dbHelper.expenseLinesDDL.headerIdColumn: headerId,
      DBHelper.dbHelper.expenseLinesDDL.descriptionColumn: description,
    };
  }

  factory ExpenseLineModel.fromMap(Map<String, dynamic> map) {
    return ExpenseLineModel(
      id: map[DBHelper.dbHelper.expenseLinesDDL.idColumn] as int,
      subAmount: map[DBHelper.dbHelper.expenseLinesDDL.subAmountColumn] as num,
      duedate: map[DBHelper.dbHelper.expenseLinesDDL.duedateColumn] as String,
      description: (map[DBHelper.dbHelper.expenseLinesDDL.descriptionColumn] ??
          '') as String,
      headerId: map[DBHelper.dbHelper.expenseLinesDDL.headerIdColumn] as int,
    );
  }
}
