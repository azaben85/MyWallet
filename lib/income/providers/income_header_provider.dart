import 'package:flutter/material.dart';
import 'package:my_wallet/income/data_repository/db_income_header_helper.dart';
import 'package:my_wallet/income/models/income_header_model.dart';

class IncomeHeaderProvider extends ChangeNotifier {
  List<IncomeHeaderModel> allExpenseCategories = [];
  final _type = 'INCOME';
  getExpenseCategories() async {
    allExpenseCategories =
        await IncomeHeaderDBHelper.dbHelper.getAllIncomeHeaders(_type);

    notifyListeners();
  }
}
