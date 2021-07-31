import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';

class StoreInfoViewModel extends ChangeNotifier {
  StoreInfo? _store;

  StoreInfo? get store => _store;

  ///更新商户信息
  void updateStoreInfo() {
    UserMod.getStoreInfoFromServer(AppManager.currentUsername!).then((value) {
      logI('updateStoreInfo: ${value.toJson()}');
      _store = value;
      notifyListeners();
    }).catchError((e) {
      logE(e);
    });
  }
}
