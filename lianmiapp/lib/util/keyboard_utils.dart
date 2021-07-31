import 'package:flutter/cupertino.dart';

class KeyboardUtils {
  //隐藏键盘
  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }
}