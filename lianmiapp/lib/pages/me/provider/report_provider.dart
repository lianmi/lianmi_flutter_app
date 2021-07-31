import 'package:flutter/material.dart';
import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/models/report_model.dart';
import 'package:lianmiapp/util/text_utils.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';

class ReportProvider extends ChangeNotifier {
  ReportDataModel _reportData = ReportDataModel();

  ReportDataModel get reportData => _reportData;

  void submit() async {
    if (_reportData.type == 0) {
      HubView.showToast('请选择举报类型');
      return;
    }
    if (isValidString(_reportData.description) == false) {
      HubView.showToast('请输入内容');
      return;
    }

    HubView.showLoading();
    UserMod.submitReport(
      type: _reportData.type,
      description: _reportData.description,
      image1: _reportData.image1,
      image2: _reportData.image2,
    ).then((value) {
      Navigator.of(App.context!).popUntil(ModalRoute.withName('/'));
      HubView.showToast('已提交');
    }).catchError((err) {
      HubView.showToast('提交失败:$err');
    });
  }

  void reset() {
    _reportData = ReportDataModel();
  }
}
