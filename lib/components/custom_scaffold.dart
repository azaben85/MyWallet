// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:my_wallet/components/custom_appbar.dart';

class CustomScaffold extends StatelessWidget {
  Widget? title;
  Widget? bottomAppBar;
  Widget? body;
  CustomScaffold({
    Key? key,
    this.title,
    this.body,
    this.bottomAppBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: title, bottomAppBar: bottomAppBar),
      body: body,
    );
  }
}
