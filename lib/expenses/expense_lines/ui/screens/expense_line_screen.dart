import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_wallet/app_router/app_router.dart';
import 'package:my_wallet/components/constants_widgets/edit_icon_widget.dart';
import 'package:my_wallet/components/custom_scaffold.dart';
import 'package:my_wallet/components/row_widget.dart';
import 'package:my_wallet/expenses/expense_header/ui/widgets/expense_header_widget.dart';
import 'package:my_wallet/expenses/expense_lines/ui/screens/add_update_line_region.dart';
import 'package:my_wallet/expenses/expense_lines/ui/widgets/expense_line_record_widget.dart';
import 'package:my_wallet/expenses/providers/expense_line_provider.dart';
import 'package:provider/provider.dart';

class ExpesnseLineScreen extends StatelessWidget {
  const ExpesnseLineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseLineProvider>(builder: (context, provider, child) {
      return CustomScaffold(
        titleWidget:
            ExpenseHeaderWidget(provider.headerModel!, allowNavigate: false),
        floatingActionButton: FloatingActionButton(
            backgroundColor: const Color.fromRGBO(202, 192, 248, 1),
            onPressed: () {
              provider.clearFields();

              AppRouter.appRouter
                  .showAlertDialog('Add New', const AddUpdateLineScreen());
            },
            child: const Icon(Icons.add)),
        body: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 52.h,
                  height: 52.h,
                ),
                Expanded(
                  child: Row(
                    children: [
                      RowWidget(label: 'Description', isHeader: true),
                      RowWidget(label: 'Due Date', isHeader: true),
                      RowWidget(label: 'Amount', isHeader: true),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: provider.allExpenseLines.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      SizedBox(
                        width: 52.h,
                        height: 52.h,
                        child: EditIconWidget(onTap: () {
                          provider.loadDataForUpdate(
                              provider.allExpenseLines[index]);
                          AppRouter.appRouter.showAlertDialog(
                              'Edit', const AddUpdateLineScreen());
                        }),
                      ),
                      Expanded(
                        child: ExpLineRecordForAddWidget(
                            expenseLineModel: provider.allExpenseLines[index]),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
