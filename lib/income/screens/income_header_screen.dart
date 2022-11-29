import 'package:flutter/material.dart';
import 'package:my_wallet/app_router/app_router.dart';
import 'package:my_wallet/components/custom_scaffold.dart';
import 'package:my_wallet/income/providers/income_header_provider.dart';
import 'package:my_wallet/income/screens/income_header_add_screen.dart';
import 'package:my_wallet/income/widgets/income_header_widget.dart';
import 'package:provider/provider.dart';

class IncomeHeaderScreen extends StatelessWidget {
  const IncomeHeaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<IncomeHeaderProvider>(
        builder: (context, iHeaderProvider, child) {
      return CustomScaffold(
        title: 'Incomes',
        floatingActionButton: FloatingActionButton(
            backgroundColor: Color.fromRGBO(224, 250, 177, 1),
            onPressed: () {
              iHeaderProvider.resetFields();

              AppRouter.appRouter.showAlertDialog('Add New', AddIncomeHeader());
            },
            child: const Icon(Icons.add)),
        body: ListView.builder(
          itemCount: iHeaderProvider.allIncomeHeaders.length,
          itemBuilder: (context, index) {
            return IncomeHeaderWidget(iHeaderProvider.allIncomeHeaders[index]);
          },
        ),
      );
    });
  }
}
