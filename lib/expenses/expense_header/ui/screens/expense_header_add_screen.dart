import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_wallet/app_router/app_router.dart';
import 'package:my_wallet/components/add_update_widget.dart';
import 'package:my_wallet/components/custom_customcheckboxtile.dart';
import 'package:my_wallet/components/custom_textformfield.dart';
import 'package:my_wallet/components/delete_widget.dart';
import 'package:my_wallet/expenses/providers/expense_header_provider.dart';
import 'package:provider/provider.dart';

class AddExpenseHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseHeaderProvider>(builder: (context, provider, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(provider.headerId == null ? 'Add Type' : 'Edit Type'),
        ),
        body: Form(
          key: provider.expenseHeaderKey,
          child: ListView(
            children: [
              CustomTextField(
                  initialValue: provider.headerName,
                  validation: provider.validateString,
                  onSave: provider.setHeaderName,
                  label: 'Title'),
              CustomTextField(
                  initialValue: provider.headerDesc,
                  // validation: provider.validateString,
                  onSave: provider.setHeaderDesc,
                  label: 'Description'),
              CustomCheckBoxTile(
                label: 'In Bank',
                value: provider.inBank ?? false,
                onChanged: provider.setInBank,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AddUpdateButtonWidget(
                      margin: EdgeInsets.only(left: 8.w, right: 8.w),
                      onTap: () async {
                        int id = await provider.insertUpdateExpenseHeader();
                        if (id != -1) {
                          provider.resetFields();
                          AppRouter.appRouter.pop();
                        }
                      },
                      label:
                          provider.headerId == null ? 'Add Type' : 'Edit Type'),
                  if (provider.headerId != null)
                    DeleteButtonWidget(
                        margin: EdgeInsets.only(left: 8.w, right: 8.w),
                        onTap: () {
                          provider.deleteExpenseHeader();
                        },
                        label: 'Delete'),
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
