import 'dart:typed_data';

class AssertTool {
  static bool isNotEmpty(String value) {
    if (value == null) {
      return false;
    } else {
      return value.isNotEmpty;
    }
  }
}
