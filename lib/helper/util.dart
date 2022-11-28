import 'package:string_validator/string_validator.dart';

int boolToInt(bool value) {
  if (value) {
    return 1;
  } else {
    return 0;
  }
}

bool intToBool(int value) {
  if (value == 0) {
    return false;
  } else {
    return true;
  }
}

String? validateAmount(String amount) {
  if (!isFloat(amount) || amount.isEmpty) {
    return 'Must be numeric';
  }
  return null;
}

String? validateDate(String date) {
  if (!isDate(date)) {
    return 'Must be date format';
  }
  return null;
}

String? validateDesc(String desc) {
  if (desc.isEmpty) {
    return 'Must have value';
  }
  return null;
}
