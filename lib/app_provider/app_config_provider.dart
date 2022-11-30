import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const String dateFormat = 'MMM, yyyy';

class AppConfigProvider extends ChangeNotifier {
  String? currentMonth = DateFormat(dateFormat).format(DateTime.now());

  nextMonth() {
    DateTime date = DateFormat(dateFormat).parse(currentMonth!);
    DateTime nextMonth = DateTime(date.year, date.month + 1);
    currentMonth = DateFormat(dateFormat).format(nextMonth);
    notifyListeners();
  }

  previousMonth() {
    DateTime date = DateFormat(dateFormat).parse(currentMonth!);

    DateTime nextMonth = DateTime(date.year, date.month - 1);
    currentMonth = DateFormat(dateFormat).format(nextMonth);
    notifyListeners();
  }
}
