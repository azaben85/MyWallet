import 'package:flutter/material.dart';
import 'package:my_wallet/components/custom_datepicker.dart';
import 'package:my_wallet/components/custom_textformfield.dart';
import 'package:my_wallet/components/row_widget.dart';
import 'package:my_wallet/expenses/expense_lines/ui/widgets/expense_line_record_widget.dart';
import 'package:my_wallet/expenses/providers/expense_line_provider.dart';
import 'package:provider/provider.dart';

class AddPlannedLineScreen extends StatelessWidget {
  const AddPlannedLineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseLineProvider>(builder: (context, provider, child) {
      return Form(
          key: provider.expenseLineKey,
          child: Column(
            children: [
              SizedBox(
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: CustomDatePicker(
                            validation: provider.validateDate,
                            dateInput: provider.dueDateContoller)),
                    Expanded(
                      child: CustomTextField(
                          contoller: provider.amountContoller,
                          // initialValue: provider.amount?.toString() ?? '',
                          textInputType: TextInputType.number,
                          //    onSave: provider.setAmount,
                          label: 'Amount',
                          validation: provider.validateAmount),
                    ),
                    InkWell(
                      child: const Icon(Icons.add),
                      onTap: () {
                        provider.addToTempLines();
                      },
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  RowWidget(label: 'Due Date', isHeader: true),
                  RowWidget(label: 'Amount', isHeader: true),
                ],
              ),
              ...provider.tempExpenseLines
                  .map((e) => ExpLineRecordForAddWidget(
                        expenseLineModel: e,
                        showDesc: false,
                      ))
                  .toList()
            ],
          ));
    });
  }
}
