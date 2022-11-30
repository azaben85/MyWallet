import 'package:flutter/material.dart';
import 'package:my_wallet/app_router/app_router.dart';
import 'package:my_wallet/components/custom_scaffold.dart';
import 'package:my_wallet/income/providers/income_header_provider.dart';
import 'package:my_wallet/income/screens/income_header_add_screen.dart';
import 'package:my_wallet/income/widgets/income_header_widget.dart';
import 'package:my_wallet/saving/providers/saving_header_provider.dart';
import 'package:my_wallet/saving/screens/saving_header_add_screen.dart';
import 'package:my_wallet/saving/widgets/saving_header_widget.dart';
import 'package:provider/provider.dart';

class SavingHeaderScreen extends StatelessWidget {
  const SavingHeaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SavingHeaderProvider>(
        builder: (context, iHeaderProvider, child) {
      return CustomScaffold(
        title: 'Saving',
        floatingActionButton: FloatingActionButton(
            backgroundColor: Color.fromRGBO(244, 207, 166, 1),
            onPressed: () {
              iHeaderProvider.resetFields();

              AppRouter.appRouter.showAlertDialog('Add New', AddSavingHeader());
            },
            child: const Icon(Icons.add)),
        body: ListView.builder(
          itemCount: iHeaderProvider.allIncomeHeaders.length,
          itemBuilder: (context, index) {
            return SavingHeaderWidget(iHeaderProvider.allIncomeHeaders[index]);
          },
        ),
      );
    });
  }
}
