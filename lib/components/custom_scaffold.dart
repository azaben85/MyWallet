// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_wallet/app_provider/app_config_provider.dart';
import 'package:my_wallet/components/custom_appbar.dart';
import 'package:my_wallet/components/custom_appbar_bottom.dart';
import 'package:my_wallet/components/custom_datepicker.dart';
import 'package:my_wallet/helper/util.dart';
import 'package:my_wallet/income/providers/income_line_provider.dart';
import 'package:provider/provider.dart';

class CustomScaffold extends StatelessWidget {
  Widget? floatingActionButton;
  Widget? body;
  Widget? titleWidget;
  String? title;
  CustomScaffold({
    this.floatingActionButton,
    this.body,
    this.title,
    this.titleWidget,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: AppBar(
          title:
              title != null && titleWidget == null ? Text(title ?? '') : null,
          centerTitle: true,
          backgroundColor: Colors.black,
          bottom: CustomBottomAppBar(title: titleWidget ?? Text(title ?? '')),
          actions: [
            Container(
                height: 52.h,
                width: 150.w,
                padding: const EdgeInsets.all(5),
                child: Center(
                  child: Consumer<AppConfigProvider>(
                      builder: (context, provider, child) {
                    return Row(
                      children: [
                        InkWell(
                          child: Icon(Icons.arrow_upward),
                          onTap: () {
                            provider.nextMonth();
                          },
                        ),
                        Text(provider.currentMonth!),
                        InkWell(
                          child: Icon(Icons.arrow_downward),
                          onTap: () {
                            provider.previousMonth();
                          },
                        ),
                      ],
                    );
                  }),
                ))
          ],
        ),
        body: body);
  }
}
