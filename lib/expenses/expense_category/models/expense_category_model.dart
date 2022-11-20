// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:my_wallet/expenses/data_repository/db_helper.dart';
import 'package:my_wallet/expenses/expense_header/models/expense_header_model.dart';
import 'package:my_wallet/helper/util.dart';

class ExpenseCategoryModel {
  int? id;
  String? name;
  bool? instant;
  List<ExpenseHeaderModel>? expenseHeaderList;
  ExpenseCategoryModel({
    this.id,
    this.name,
    this.instant,
    this.expenseHeaderList,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      DBHelper.dbHelper.expenseCategoryDDL.nameColumn: name,
      DBHelper.dbHelper.expenseCategoryDDL.instantColumn:
          boolToInt((instant ?? false))
    };
  }

  ExpenseCategoryModel.fromMap(Map<String, dynamic> map) {
    id = map[DBHelper.dbHelper.expenseCategoryDDL.idColumn];
    name = map[DBHelper.dbHelper.expenseCategoryDDL.nameColumn];
    instant =
        intToBool(map[DBHelper.dbHelper.expenseCategoryDDL.instantColumn] ?? 0);
  }
}
