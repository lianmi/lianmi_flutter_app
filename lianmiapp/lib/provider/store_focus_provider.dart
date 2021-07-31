import 'package:flutter/material.dart';
import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/net/http_api.dart';
// import 'package:lianmiapp/pages/discovery/models/store_list_model.dart';
import 'package:lianmiapp/util/http_utils.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';

class StoreFocusProvider extends ChangeNotifier {
  List<StoreInfo> _storeFocus = [];

  List<StoreInfo> get storeFocus => _storeFocus;

  ///是否已关注
  bool isFocus(String businessUsername) {
    int index = _storeFocus
        .lastIndexWhere((element) => element.userName == businessUsername);
    return index >= 0;
  }

  ///更新所有我的关注
  Future updateAllFocusStore() async {
    try {
      //TODO ,一次性返回复合数据StoreInfo数组，不需要单独拉取
      _storeFocus.clear();
      _storeFocus = await UserMod.getWatchingStores();
      // for (var item in stores) {
      //   var val = await HttpUtils.get(
      //       HttpApi.storeInfo + '/${item.businessUsername}');
      //   if (val is Map<String, dynamic>) {
      //     StoreInfo model = StoreInfo.fromMap(val); //lishijia
      //     _storeFocus.add(model);
      //   }
      // }
      notifyListeners();
    } catch (e) {
      logE('获取我的关注失败');
      return [];
    }
  }

  ///我的关注
  void focusStore(String businessUsername) {
    UserMod.watchingStore(businessUsername).then((value) {
      HubView.showToast('关注成功');
      updateAllFocusStore();
      notifyListeners();
    }).catchError((err) {
      logE('我的关注失败:$err');
    });
  }

  ///取消我的关注
  void unFocusStore(String businessUsername) {
    UserMod.cancelWatchingStore(businessUsername).then((value) {
      HubView.showToast('已取消关注');
      updateAllFocusStore();
      notifyListeners();
    }).catchError((err) {
      logE('取消关注失败:$err');
    });
  }
}
