import 'package:lianmiapp/header/common_header.dart';
import 'dart:ui';
import 'package:flutter_qr_reader/flutter_qr_reader.dart';
import 'package:lianmiapp/util/action_utils.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';

class QrScanViewModel extends ChangeNotifier {
  ///扫描控制器
  late QrReaderViewController _controller;

  QrReaderViewController get qrController => _controller;

  set qrController(QrReaderViewController controller) {
    this._controller = controller;
    _canPop = true;
    notifyListeners();
  }

  bool _canPop = true;

  ///判断是否有权限
  bool _isPower = false;

  bool get isPower => _isPower;

  set isPower(bool isOk) {
    this._isPower = isOk;
    notifyListeners();
  }

  ///扫描得到的内容
  String? _scanData;

  String? get scanData => _scanData;

  set scanData(String? data) {
    this._scanData = data;
    notifyListeners();
  }

  void onScan(String v, List<Offset> offsets) {
    logD([v, offsets]);
    this._scanData = v;
    this._controller.stopCamera();
    // notify();
    if (_canPop) {
      HubView.showLoading();
      Future.delayed(Duration(seconds: 2), () {
        HubView.dismiss();
        AppNavigator.goBackWithParams(App.context!, v);
      });
      _canPop = false;
    }
  }

  void dispose() {
    super.dispose();
  }
}
