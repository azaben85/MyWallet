import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_wallet/components/add_update_widget.dart';
import 'package:my_wallet/components/custom_textformfield.dart';
import 'package:my_wallet/components/delete_widget.dart';
import 'package:my_wallet/helper/util.dart';
import 'package:my_wallet/income/providers/income_header_provider.dart';
import 'package:provider/provider.dart';

class AddIncomeHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<IncomeHeaderProvider>(builder: (context, provider, child) {
      return Form(
        key: provider.incomeHeaderKey,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width * 0.60,
          child: Column(
            children: [
              CustomTextField(
                  initialValue: provider.incomeHeaderModel.name,
                  validation: validateDesc,
                  onSave: provider.setName,
                  label: 'Name'),
              CustomTextField(
                  initialValue: provider.incomeHeaderModel.desc,
                  // validation: provider.validateString,
                  onSave: provider.setDesc,
                  label: 'Description'),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AddUpdateButtonWidget(
                      margin: EdgeInsets.only(left: 8.w, right: 8.w),
                      onTap: () async {
                        await provider.insertUpdateHeader();
                      },
                      label: provider.incomeHeaderModel.id == null
                          ? 'Add'
                          : 'Edit'),
                  if (provider.incomeHeaderModel.id != null)
                    DeleteButtonWidget(
                        margin: EdgeInsets.only(left: 8.w, right: 8.w),
                        onTap: () {
                          provider.deleteIncomeHeader();
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
