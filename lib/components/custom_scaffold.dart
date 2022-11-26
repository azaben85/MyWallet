// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:my_wallet/components/custom_appbar.dart';

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
          centerTitle: true,
          backgroundColor: Colors.black,
          title: titleWidget ?? Text(title ?? ''),
        ),
        body: body);
  }
}
