import 'package:flutter/material.dart';
import 'package:my_wallet/components/custom_scaffold.dart';
import 'package:my_wallet/expenses/expense_header/ui/screens/expense_header_add_screen_planned.dart';
import 'package:my_wallet/expenses/expense_header/ui/screens/add_planned_line_screen.dart';
import 'package:my_wallet/expenses/providers/expense_category_provider.dart';
import 'package:my_wallet/expenses/providers/expense_header_provider.dart';
import 'package:my_wallet/expenses/providers/expense_line_provider.dart';
import 'package:provider/provider.dart';

class AddPlannedExpesneHeaderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<ExpenseHeaderProvider, ExpenseLineProvider>(
        builder: (context, headerProvider, lineProvider, child) {
      return CustomScaffold(
        title: 'New Planned Expense',
        body: Stepper(
          // controlsBuilder: (context, details) {
          //   return StepperBuilder(
          //     onStepContinue: details.onStepContinue!,
          //     onStepCancel: details.onStepCancel!,
          //   );
          // },

          type: StepperType.horizontal,
          currentStep: headerProvider.currentStep,
          onStepContinue: () async {
            if (headerProvider.currentStep == 0) {
              headerProvider.validateFields();
            } else {
              int id = await headerProvider.insertUpdateExpenseHeader();
              await lineProvider.insertExpenseLines(id);

              Provider.of<ExpenseCategoryProvider>(context, listen: false)
                  .getExpenseCategories();
              Provider.of<ExpenseHeaderProvider>(context, listen: false)
                  .getExpenseHeader();
            }
          },
          onStepCancel: () {
            headerProvider.previousStep();
          },
          steps: [
            Step(
                isActive: headerProvider.currentStep >= 0,
                title: const Text('To'),
                content: AddExpensePlannedHeader()),
            Step(
                isActive: headerProvider.currentStep >= 1,
                title: const Text('Scheduled Expense'),
                content: const AddPlannedLineScreen()),
          ],
        ),
      );
    });
  }
}

class StepperBuilder extends StatelessWidget {
  VoidCallback onStepContinue;
  VoidCallback onStepCancel;
  StepperBuilder({
    Key? key,
    required this.onStepContinue,
    required this.onStepCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ElevatedButton(
            onPressed: onStepCancel,
            child: const Text('BACK'),
          ),
          ElevatedButton(
            onPressed: onStepContinue,
            child: const Text('NEXT'),
          ),
        ]);
    ;
  }
}
