import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_wallet/components/constants_widgets/edit_icon_widget.dart';
import 'package:my_wallet/expenses/expense_category/ui/widgets/expense_category_widget.dart';
import 'package:my_wallet/income/models/income_header_model.dart';

class IncomeHeaderWidget extends StatelessWidget {
  IncomeHeaderModel incomeHeader;
  bool allowNavigate;
  IncomeHeaderWidget(this.incomeHeader, {this.allowNavigate = true});

  @override
  Widget build(BuildContext context) {
    if (allowNavigate) {
      return Row(
        children: [
          Expanded(
            child: InkWell(
              child: IntExpenseCatWidget(name: incomeHeader.name!),
              onTap: () {},
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 28.w),
            child: EditIconWidget(onTap: () {}),
          )
        ],
      );
    } else {
      return IntExpenseCatWidget(name: incomeHeader.name!);
    }
  }
}
