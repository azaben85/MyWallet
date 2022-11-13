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
