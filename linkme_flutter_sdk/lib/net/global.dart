// import 'package:linkme_flutter_sdk/util/common/common_header.dart';
import 'dart:convert';
import 'package:linkme_flutter_sdk/manager/LogManager.dart';

/// 全局配置
class Global {
  /// token
  // static String accessToken = "";
  static bool retryEnable = true;
  // static String? imToken = '';

  // /// IM的用户名和密码
  // static String? get imUsername {
  //   try {
  //     if (imToken == null || imToken!.length == 0) {
  //       return "";
  //     }
  //     Map json = jsonDecode(imToken!);
  //     return json['userid'];
  //   } catch (e) {
  //     logE('获取imUsername错误: $e');
  //     return '';
  //   }
  // }

  // static String? get imPassword {
  //   if (imToken == null || imToken!.length == 0) {
  //     return "";
  //   } else {
  //     Map json = jsonDecode(imToken!);
  //     return json['password'];
  //   }
  // }

  /// 是否 release
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");
}
