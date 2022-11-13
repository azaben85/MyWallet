// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:my_wallet/expenses/data_repository/db_helper.dart';
import 'package:my_wallet/expenses/models/expense_header_model.dart';

class ExpenseCategoryModel {
  int? id;
  String? name;
  List<ExpenseHeaderModel>? expenseHeaderList;
  ExpenseCategoryModel({
    this.id,
    this.name,
    this.expenseHeaderList,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      DBHelper.dbHelper.expenseCategoryDDL.idColumn: id,
      DBHelper.dbHelper.expenseCategoryDDL.nameColumn: name
    };
  }

  ExpenseCategoryModel.fromMap(Map<String, dynamic> map) {
    id = map[DBHelper.dbHelper.expenseCategoryDDL.idColumn];
    name = map[DBHelper.dbHelper.expenseCategoryDDL.nameColumn];
  }
}
