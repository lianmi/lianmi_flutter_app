/**
 * 常量定义
 * 
 */

import 'package:flutter/foundation.dart';

class Constant {
  /// debug开关，上线需要关闭
  /// App运行在Release环境时，inProduction为true；当App运行在Debug和Profile环境时，inProduction为false
  static const bool inProduction = kReleaseMode;

  static bool isDriverTest = false;
  static bool isUnitTest = false;

  static const String data = 'data';
  static const String message = 'message';
  static const String code = 'code';

  static const String keyGuide = 'keyGuide';
  static const String phone = 'phone';
  // static const String accessToken = 'accessToken';
  static const String refreshToken = 'refreshToken';

  static const String theme = 'AppTheme';

  static const String baseUrl = 'https://api.lianmi.cloud';

  static const String isLogined = 'IsLogined';

  /// 获取当前用户的最后登录时间戳
  static const String lastLoginTimeAt = 'LastLoginTimeAt';

  /// @nodoc 获取最后一次登陆的用户名
  static const String lastLoginName = 'LastLoginName';

  /// @nodoc 获取最后一次选择省
  static const String provinceId = 'ProvinceId';

  /// @nodoc 获取最后一次选择城市
  static const String cityId = 'CityId';

  /// @nodoc 当前app版本号
  static const String curVersion = 'CurVersion';

  /// @nodoc 获取最后一次登陆的用户手机号
  static const String lastMobile = 'LastMobile';

  /// @nodoc 最后一次登陆的 用户Token
  static const String lastLoginToken = 'LastLoginToken';

  /// @nodoc 最后一次登陆的 用户state
  static const String lastLoginState = 'LastLoginState';

  /// @nodoc 最后一次登陆的 用户类型
  static const String lastLoginUserType = 'LastLoginUserType';

  /// @nodoc 获取最后一次登陆的用户协商公钥
  static const String localPubkey = 'LocalPubkey';

  /// @nodoc 获取最后一次登陆的用户协商私钥
  static const String localPrikey = 'LocalPrikey';

  /// @nodoc 获取最后一次登陆的商户的RSA公钥
  static const String notaryServicePublickey = 'NotaryServicePublickey';
}
