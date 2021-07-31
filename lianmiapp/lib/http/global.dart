
import 'dart:convert';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';

/// 全局配置
class Global {
  /// token
  // static String accessToken = "";
  //测试token
  // static String accessToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkZXZpY2VJRCI6Ijk1OWJiMGFlLTFjMTItNGI2MC04NzQxLTE3MzM2MWNlYmE4YSIsImV4cCI6MTYwOTY4MDcyOCwib3JpZ19pYXQiOjE2MDcwODg3MjgsInVzZXJOYW1lIjoiaWQ4MSIsInVzZXJSb2xlcyI6Ilt7XCJpZFwiOjc5LFwidXNlcl9pZFwiOjc5LFwidXNlcl9uYW1lXCI6XCJpZDgxXCIsXCJ2YWx1ZVwiOlwiXCJ9XSJ9.jhxk7Ha7Cg6yjsDFuqtntGSMHPsoQeGNhzggCzo9UIo';
  // static String accessToken = AuthMod.getLastLoginToken()??'';
  static String get accessToken{
    return AuthMod.getLastLoginToken()??'';
  }
  static bool retryEnable = true;
  static String imToken = '';
}
