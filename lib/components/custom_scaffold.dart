// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:my_wallet/components/custom_appbar.dart';

class CustomScaffold extends StatelessWidget {
  String title;
  Widget? body;
  CustomScaffold({
    Key? key,
    required this.title,
    this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: body,
    );
  }
}
