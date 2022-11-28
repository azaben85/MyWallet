import 'package:my_wallet/app_data_repository/db_helper.dart';
import 'package:my_wallet/helper/util.dart';

class IncomeHeaderModel {
  int? id;
  String? type;

  String? name;
  String? desc;
  num? amount;
  bool? flag1;
  bool? flag2;
  IncomeHeaderModel({
    this.id,
    this.type,
    this.name,
    this.desc,
    this.amount,
    this.flag1,
    this.flag2,
  });

  resetFields({String? type}) {
    id = null;
    this.type = type;
    name = '';
    amount = null;
    desc = '';
    flag1 = null;
    flag2 = null;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      DBHelper.dbHelper.incomeHeaderDDL.typeColumn: type,
      DBHelper.dbHelper.incomeHeaderDDL.nameColumn: name,
      DBHelper.dbHelper.incomeHeaderDDL.descColumn: desc,
      DBHelper.dbHelper.incomeHeaderDDL.amountColumn: amount,
      DBHelper.dbHelper.incomeHeaderDDL.flag1Column:
          boolToInt((flag1 ?? false)),
      DBHelper.dbHelper.incomeHeaderDDL.flag2Column:
          boolToInt((flag2 ?? false)),
    };
  }

  IncomeHeaderModel.fromMap(Map<String, dynamic> map) {
    id = map[DBHelper.dbHelper.incomeHeaderDDL.idColumn];
    type = map[DBHelper.dbHelper.incomeHeaderDDL.typeColumn];
    name = map[DBHelper.dbHelper.incomeHeaderDDL.nameColumn];
    desc = map[DBHelper.dbHelper.incomeHeaderDDL.descColumn];
    amount =
        (map[DBHelper.dbHelper.incomeHeaderDDL.amountColumn] ?? 0.0) as num;
    flag1 = intToBool(map[DBHelper.dbHelper.incomeHeaderDDL.flag1Column] ?? 0);
    flag2 = intToBool(map[DBHelper.dbHelper.incomeHeaderDDL.flag2Column] ?? 0);
  }
}
