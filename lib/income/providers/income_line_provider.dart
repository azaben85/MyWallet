import 'package:flutter/material.dart';
import 'package:my_wallet/app_router/app_router.dart';
import 'package:my_wallet/income/data_repository/db_income_lines_helper.dart';
import 'package:my_wallet/income/models/income_header_model.dart';
import 'package:my_wallet/income/models/income_line_model.dart';

class IncomeLineProvider extends ChangeNotifier {
  IncomeLineProvider() {
    getIncomeLines();
  }

  List<IncomeLineModel> allIncomeLines = [];
  GlobalKey<FormState> incomeLineKey = GlobalKey<FormState>();

  getIncomeLines() async {
    allIncomeLines = await IncomeLineDBHelper.dbHelper
        .getAllIncomeLines(header_id: incomeHeaderModel?.id ?? -1);

    notifyListeners();
  }

  TextEditingController? dueDateController = TextEditingController();

  IncomeHeaderModel? incomeHeaderModel;
  IncomeLineModel incomeLineModel = IncomeLineModel();

  loadDataForUpdate(IncomeLineModel incomeLine) {
    incomeLineModel.id = incomeLine.id;
    incomeLineModel.amount = incomeLine.amount;
    incomeLineModel.desc = incomeLine.desc;
    incomeLineModel.duedate = incomeLine.duedate;
    incomeLineModel.headerId = incomeLine.headerId;
    dueDateController!.text = incomeLine.duedate!;
  }

  setIncomeHeader(IncomeHeaderModel incomeHeaderModel) {
    this.incomeHeaderModel = incomeHeaderModel;
    getIncomeLines();
  }

  insertUpdateLine() async {
    if (incomeLineKey.currentState!.validate()) {
      incomeLineKey.currentState!.save();
      incomeLineModel.duedate = dueDateController!.text;
      if (incomeLineModel.id == null) {
        incomeLineModel.headerId = incomeHeaderModel!.id;

        await IncomeLineDBHelper.dbHelper.insertNewIncomeLine(incomeLineModel);
      } else {
        await IncomeLineDBHelper.dbHelper.updateIncomeLine(incomeLineModel);
      }
      resetFields();
      getIncomeLines();

      AppRouter.appRouter.pop();
    }
  }

  deleteIncomeLine() async {
    await IncomeLineDBHelper.dbHelper
        .deleteIncomeLine(incomeLineModel.id ?? -1);

    resetFields();
    getIncomeLines();

    AppRouter.appRouter.pop();
  }

  setDueDate(String duedate) {
    dueDateController!.text = duedate;
  }

  setAmount(String amount) {
    incomeLineModel.amount = double.parse(amount);
  }

  setDesc(String desc) {
    incomeLineModel.desc = desc;
  }

  setId(int id) {
    incomeLineModel.id = id;
  }

  resetFields() {
    dueDateController!.text = '';
    incomeLineModel.resetFields(headerId: incomeHeaderModel!.id);
  }
}
