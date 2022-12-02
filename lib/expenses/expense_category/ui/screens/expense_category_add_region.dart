// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_wallet/components/add_update_widget.dart';
import 'package:my_wallet/components/custom_customcheckboxtile.dart';
import 'package:my_wallet/components/delete_widget.dart';
import 'package:my_wallet/expenses/providers/expense_header_provider.dart';
import 'package:provider/provider.dart';

import 'package:my_wallet/components/custom_textformfield.dart';
import 'package:my_wallet/expenses/providers/expense_category_provider.dart';

class AddExpenseCategoryContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseCategoryProvider>(
        builder: (context, provider, child) {
      return Form(
        key: provider.expenseCatKey,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width * 0.60,
          child: ListView(
            children: [
              CustomTextField(
                  initialValue: provider.categoryName,
                  validation: provider.validateCategoryName,
                  onSave: provider.setCategoryName,
                  label: 'Expense Category'),
              CustomCheckBoxTile(
                  label: 'Instant Expense',
                  value: provider.instantType ?? false,
                  onChanged: provider.setInstantType),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AddUpdateButtonWidget(
                      margin: EdgeInsets.only(left: 8.w, right: 8.w),
                      onTap: () {
                        provider.insertUpdateExpenseCategory();
                      },
                      label: provider.catId == null ? 'Add' : 'Edit'),
                  if (provider.catId != null)
                    DeleteButtonWidget(
                        margin: EdgeInsets.only(left: 8.w, right: 8.w),
                        onTap: () {
                          provider.deleteExpenseCategory();
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
