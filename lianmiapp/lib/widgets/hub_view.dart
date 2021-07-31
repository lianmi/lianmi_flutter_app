import 'package:flutter_easyloading/flutter_easyloading.dart';

class HubView {
  static showLoading() {
    EasyLoading.show(status: '加载中...');
  }

  static showLoadingWithText(String text) {
    EasyLoading.show(status: '${text}...');
  }

  static dismiss() {
    EasyLoading.dismiss();
  }

  static showSuccess(String text) {
    EasyLoading.showSuccess(text);
  }

  static showError(String text) {
    EasyLoading.showError(text);
  }

  static showToast(String text) {
    EasyLoading.showToast(text);
  }

  static showToastAfterLoadingHubDismiss(String text) {
    Future.delayed(Duration(milliseconds: 300), (){
      EasyLoading.showToast(text);
    });
  }
}