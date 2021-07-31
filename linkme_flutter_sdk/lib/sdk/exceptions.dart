// 自定义异常

class LoginTypeUndefineException implements Exception {
  String errMsg() => 'Undefine login type';
}

class SmscodeException implements Exception {
  String errMsg() => 'Smscode error';
}

class PasswordException implements Exception {
  String errMsg() => 'Password error';
}
