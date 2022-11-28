import 'package:my_wallet/app_data_repository/db_helper.dart';

class IncomeLineModel {
  int? id;
  int? headerId;

  String? duedate;
  String? desc;
  num? amount;
  IncomeLineModel({
    this.id,
    this.headerId,
    this.desc,
    this.amount,
    this.duedate,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      DBHelper.dbHelper.incomeLinesDDL.descColumn: desc,
      DBHelper.dbHelper.incomeLinesDDL.duedateColumn: duedate,
      DBHelper.dbHelper.incomeLinesDDL.headerIdColumn: headerId,
      DBHelper.dbHelper.incomeLinesDDL.subAmountColumn: amount,
    };
  }

  IncomeLineModel.fromMap(Map<String, dynamic> map) {
    id = map[DBHelper.dbHelper.incomeLinesDDL.idColumn];
    duedate = map[DBHelper.dbHelper.incomeLinesDDL.duedateColumn];
    desc = map[DBHelper.dbHelper.incomeLinesDDL.descColumn];
    amount = map[DBHelper.dbHelper.incomeLinesDDL.subAmountColumn] as num;
    headerId = map[DBHelper.dbHelper.incomeLinesDDL.headerIdColumn] as int;
  }
}
