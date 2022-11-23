// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:my_wallet/app_router/app_router.dart';
import 'package:my_wallet/expenses/expense_header/ui/screens/expense_header_add_screen_planned.dart';
import 'package:my_wallet/expenses/expense_lines/ui/screens/expense_header_line_screen.dart';
import 'package:my_wallet/expenses/providers/expense_header_provider.dart';

class ExpesneHeaderMainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseHeaderProvider>(builder: (context, provider, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Expense Header'),
        ),
        body: Stepper(
          // controlsBuilder: (context, details) {
          //   return StepperBuilder(
          //     onStepContinue: details.onStepContinue!,
          //     onStepCancel: details.onStepCancel!,
          //   );
          // },

          //type: StepperType.horizontal,
          currentStep: provider.currentStep,
          onStepContinue: () async {
            // bool result = await provider.insertUpdateExpenseHeader();
            // if (result) {
            provider.validateFields();
            // }
          },
          onStepCancel: () {
            provider.previousStep();
          },
          steps: [
            Step(
                isActive: provider.currentStep >= 0,
                title: const Text('Header'),
                content: AddExpensePlannedHeader()),
            Step(
                isActive: provider.currentStep >= 1,
                title: const Text('Lines'),
                content: const ExpenseLineScreen()),
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
