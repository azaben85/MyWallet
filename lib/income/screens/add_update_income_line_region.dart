import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_wallet/components/add_update_widget.dart';
import 'package:my_wallet/components/custom_datepicker.dart';
import 'package:my_wallet/components/custom_textformfield.dart';
import 'package:my_wallet/components/delete_widget.dart';
import 'package:my_wallet/helper/util.dart';
import 'package:my_wallet/income/providers/income_line_provider.dart';
import 'package:provider/provider.dart';

class AddUpdateIncomeLineScreen extends StatelessWidget {
  const AddUpdateIncomeLineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<IncomeLineProvider>(builder: (context, provider, child) {
      return Form(
          key: provider.incomeLineKey,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width * 0.75,
            child: Column(
              children: [
                CustomTextField(
                  initialValue: provider.incomeLineModel.desc,
                  onSave: provider.setDesc,
                  label: 'Description',
                ),
                CustomDatePicker(
                    dateInput: provider.dueDateController,
                    validation: validateDate,
                    onSave: provider.setDueDate),
                CustomTextField(
                    //contoller: provider.amountContoller,
                    initialValue: provider.incomeLineModel.amount.toString(),
                    textInputType: TextInputType.number,
                    onSave: provider.setAmount,
                    label: 'Amount',
                    validation: validateAmount),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AddUpdateButtonWidget(
                        margin: EdgeInsets.only(left: 8.w, right: 8.w),
                        onTap: () {
                          provider.insertUpdateLine();
                        },
                        label: provider.incomeLineModel.id == null
                            ? 'Add'
                            : 'Edit'),
                    if (provider.incomeLineModel.id != null)
                      DeleteButtonWidget(
                          margin: EdgeInsets.only(left: 8.w, right: 8.w),
                          onTap: () {
                            provider.deleteIncomeLine();
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
