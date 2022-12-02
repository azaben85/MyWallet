import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_wallet/app_provider/app_config_provider.dart';
import 'package:my_wallet/app_router/app_router.dart';
import 'package:my_wallet/components/custom_scaffold.dart';
import 'package:my_wallet/components/wallet_cat_widget.dart';
import 'package:my_wallet/components/wallet_region.dart';
import 'package:my_wallet/expenses/expense_category/ui/screens/expense_categories_screen.dart';
import 'package:my_wallet/income/screens/income_header_screen.dart';
import 'package:my_wallet/saving/screens/saving_header_screen.dart';
import 'package:my_wallet/widgets/image_assets/expense_image_asset.dart';
import 'package:provider/provider.dart';

class MyWalletMainScreen extends StatelessWidget {
  const MyWalletMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppConfigProvider>(builder: (context, provider, child) {
      return CustomScaffold(
        title: 'My Wallet',
        bottom: Row(children: [
          WalletRegion(
              onTap: () {
                AppRouter.appRouter.push(ExpesnseCategories());
              },
              height: 160.h,
              width: 130.w,
              borderColor: const Color.fromRGBO(202, 192, 248, 1),
              widget: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ImageAsset(
                      'Expenses.png',
                      width: 40.w,
                      height: 40.h,
                    ),
                    const Text(
                      'Expenses',
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    ),
                    Text(
                      '${provider.expenseTotal}',
                      style: const TextStyle(color: Colors.white),
                    )
                  ],
                ),
              )),
          WalletRegion(
              onTap: () {
                AppRouter.appRouter.push(IncomeHeaderScreen());
              },
              height: 160.h,
              width: 130.w,
              borderColor: const Color.fromRGBO(224, 250, 177, 1),
              widget: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ImageAsset(
                      'Income.png',
                      width: 40.w,
                      height: 40.h,
                    ),
                    const Text(
                      'Income',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Text(
                      '${provider.incomeTotal}',
                      style: const TextStyle(color: Colors.white),
                    )
                  ],
                ),
              )),
          WalletRegion(
              onTap: () {
                AppRouter.appRouter.push(SavingHeaderScreen());
              },
              height: 160.h,
              width: 130.w,
              borderColor: Color.fromRGBO(244, 207, 166, 1),
              widget: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ImageAsset(
                      'Saving.png',
                      width: 40.w,
                      height: 40.h,
                    ),
                    const Text(
                      'Saving',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Text(
                      '${provider.incomeTotal}',
                      style: const TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ))
        ]),
        body: Column(
          children: [],
        ),
      );
    });
  }
}
