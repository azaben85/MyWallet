import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_wallet/app_router/app_router.dart';
import 'package:my_wallet/components/constants_widgets/edit_icon_widget.dart';
import 'package:my_wallet/components/custom_scaffold.dart';
import 'package:my_wallet/components/row_widget.dart';
import 'package:my_wallet/income/providers/income_line_provider.dart';
import 'package:my_wallet/income/screens/add_update_income_line_region.dart';
import 'package:my_wallet/income/widgets/income_line_record_widget.dart';
import 'package:my_wallet/saving/widgets/saving_header_widget.dart';
import 'package:provider/provider.dart';

class SavingLineScreen extends StatelessWidget {
  const SavingLineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<IncomeLineProvider>(builder: (context, provider, child) {
      return CustomScaffold(
        bottom: SavingHeaderWidget(provider.incomeHeaderModel!,
            allowNavigate: false),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Color.fromRGBO(244, 207, 166, 1),
            onPressed: () {
              provider.resetFields();

              AppRouter.appRouter.showAlertDialog(
                  'Add New', const AddUpdateIncomeLineScreen());
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
                itemCount: provider.allIncomeLines.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      SizedBox(
                        width: 52.h,
                        height: 52.h,
                        child: EditIconWidget(onTap: () {
                          provider.loadDataForUpdate(
                              provider.allIncomeLines[index]);

                          AppRouter.appRouter.showAlertDialog(
                              'Edit', const AddUpdateIncomeLineScreen());
                        }),
                      ),
                      Expanded(
                        child: IncomeLineRecordForAddWidget(
                            incomeLineModel: provider.allIncomeLines[index]),
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
