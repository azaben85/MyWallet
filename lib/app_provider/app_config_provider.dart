import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppConfigProvider extends ChangeNotifier {
  bool? dark_mode;
  String? dateValue = DateFormat('MMM, yyyy').format(DateTime.now());
  TextEditingController? globalDateInput = TextEditingController(
      text: DateFormat('MMM, yyyy').format(DateTime.now()));

  GlobalKey<FormState> appDateKey = GlobalKey<FormState>();

  setDateValue(String date) {
    if (appDateKey.currentState!.validate() == true) {
      appDateKey.currentState!.save();

      log('message');
      globalDateInput!.text = date;
      notifyListeners();
    }
  }
}
