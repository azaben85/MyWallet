import 'package:flutter/material.dart';
import 'package:my_wallet/app_router/app_router.dart';
import 'package:my_wallet/income/data_repository/db_income_header_helper.dart';
import 'package:my_wallet/income/data_repository/db_income_lines_helper.dart';
import 'package:my_wallet/income/models/income_header_model.dart';

class SavingHeaderProvider extends ChangeNotifier {
  SavingHeaderProvider() {
    getIncomeHeaders();
  }
  final String _type = 'SAVING';

  List<IncomeHeaderModel> allIncomeHeaders = [];
  GlobalKey<FormState> incomeHeaderKey = GlobalKey<FormState>();

  getIncomeHeaders() async {
    incomeHeaderModel.type = _type;
    allIncomeHeaders =
        await IncomeHeaderDBHelper.dbHelper.getAllIncomeHeaders(_type);

    notifyListeners();
  }

  IncomeHeaderModel incomeHeaderModel = IncomeHeaderModel();
  loadDataForUpdate(IncomeHeaderModel headerModel) {
    incomeHeaderModel.id = headerModel.id;
    incomeHeaderModel.amount = headerModel.amount;
    incomeHeaderModel.name = headerModel.name;
    incomeHeaderModel.desc = headerModel.desc;
    incomeHeaderModel.flag1 = headerModel.flag1;
    incomeHeaderModel.flag2 = headerModel.flag2;
    incomeHeaderModel.type = headerModel.type;
  }

  insertUpdateHeader() async {
    if (incomeHeaderKey.currentState!.validate()) {
      incomeHeaderKey.currentState!.save();
      if (incomeHeaderModel.id == null) {
        await IncomeHeaderDBHelper.dbHelper
            .insertNewIncomeHeader(incomeHeaderModel);
      } else {
        await IncomeHeaderDBHelper.dbHelper
            .updateIncomeHeader(incomeHeaderModel);
      }
      resetFields();
      getIncomeHeaders();

      AppRouter.appRouter.pop();
    }
  }

  deleteIncomeHeader() async {
    await IncomeLineDBHelper.dbHelper
        .deleteIncomeLineByHeaderId(incomeHeaderModel.id ?? -1);
    await IncomeHeaderDBHelper.dbHelper
        .deleteIncomeHeader(incomeHeaderModel.id ?? -1);

    resetFields();
    getIncomeHeaders();

    AppRouter.appRouter.pop();
  }

  setName(String name) {
    incomeHeaderModel.name = name;
  }

  setAmount(num amount) {
    incomeHeaderModel.amount = amount;
  }

  setDesc(String desc) {
    incomeHeaderModel.desc = desc;
  }

  setId(int id) {
    incomeHeaderModel.id = id;
  }

  setFlag1(bool flag) {
    incomeHeaderModel.flag1 = flag;
  }

  setFlag2(bool flag) {
    incomeHeaderModel.flag2 = flag;
  }

  resetFields() {
    incomeHeaderModel.resetFields(type: _type);
  }
}
