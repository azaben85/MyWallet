import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_wallet/components/add_update_widget.dart';
import 'package:my_wallet/components/custom_datepicker.dart';
import 'package:my_wallet/components/custom_textformfield.dart';
import 'package:my_wallet/components/delete_widget.dart';
import 'package:my_wallet/expenses/providers/expense_line_provider.dart';
import 'package:provider/provider.dart';

class AddUpdateLineScreen extends StatelessWidget {
  const AddUpdateLineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseLineProvider>(builder: (context, provider, child) {
      return Form(
          key: provider.expenseLineKey,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width * 0.75,
            child: Column(
              children: [
                CustomTextField(
                  contoller: provider.descContoller,
                  label: 'Description',
                ),
                CustomDatePicker(
                    validation: provider.validateDate,
                    dateInput: provider.dueDateContoller),
                CustomTextField(
                    contoller: provider.amountContoller,
                    // initialValue: provider.amount?.toString() ?? '',
                    textInputType: TextInputType.number,
                    // onSave: provider.setAmount,
                    label: 'Amount',
                    validation: provider.validateAmount),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AddUpdateButtonWidget(
                        margin: EdgeInsets.only(left: 8.w, right: 8.w),
                        onTap: () {
                          provider.insertExpenseLine();
                        },
                        label: provider.lineId == null ? 'Add' : 'Edit'),
                    if (provider.lineId != null)
                      DeleteButtonWidget(
                          margin: EdgeInsets.only(left: 8.w, right: 8.w),
                          onTap: () {
                            provider.deleteExpenseLine();
                          },
                          label: 'Delete'),
                  ],
                )
              ],
            ),
          ));
    });
  }
}
