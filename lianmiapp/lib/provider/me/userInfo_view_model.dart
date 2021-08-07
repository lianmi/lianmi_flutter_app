import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lianmiapp/util/math_utils.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';
import 'package:linkme_flutter_sdk/sdk/WalletMod.dart';

class UserInfoViewModel extends ChangeNotifier {
  UserInfo? _user;

  UserInfo? get user => _user;

  int _balance = 0;

  int get balance => _balance;

  double get balanceValue => _balance / 100;

  String get balanceText =>
      MathUtils.getTargetTextFromDouble(balanceValue) + '元';

  ///更新用户信息
  void updateUserInfo() {
    updateProfile();
    updateBalance();
  }

  void updateProfile() {
    UserMod.getMyProfile().then((value) {
      // logI(value);
      // _user = _convertUserInfo(value);
      _user = value;
      notifyListeners();
    }).catchError((e) {
      logE(e);
    });
  }

  void updateBalance() {
    WalletMod.getBalance().then((value) {
      _balance = value;
      notifyListeners();
    });
  }

/*
  User _convertUserInfo(UserInfo userInfo) {
    User user = User(
      username: userInfo.userName!,
      nick: userInfo.nick,
      avatar: userInfo.avatar,
      label: userInfo.label,
      gender: userInfo.gender,
      mobile: userInfo.mobile,
      email: userInfo.email,
      userType: userInfo.userType,
      trueName: userInfo.trueName,
      identityCard: userInfo.identityCard,
      province: userInfo.province,
      city: userInfo.city,
      area: userInfo.area,
      vipEndDate: userInfo.vipEndDate,
    );

    return user;
  }
  */
}
