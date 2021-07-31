import 'package:flutter/material.dart';
import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/models/propose_feedbak_model.dart';
import 'package:lianmiapp/util/text_utils.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';

class ProposeFeedbackProvider extends ChangeNotifier {
  ProposeFeedbackDataModel _proposeData = ProposeFeedbackDataModel();

  ProposeFeedbackDataModel get proposeData => _proposeData;

  void submit() async {
    if (isValidString(_proposeData.title) == false) {
      HubView.showToast('请输入标题');
      return;
    }
    if (isValidString(_proposeData.detail) == false) {
      HubView.showToast('请输入内容');
      return;
    }

    HubView.showLoading();
    UserMod.submitProposeFeedback(
      title: _proposeData.title,
      detail: _proposeData.detail,
      image1: _proposeData.image1,
      image2: _proposeData.image2,
    ).then((value) {
      Navigator.of(App.context!).popUntil(ModalRoute.withName('/'));
      HubView.showToast('已提交');
    }).catchError((err) {
      HubView.showToast('提交失败:$err');
    });
  }

  void reset() {
    _proposeData = ProposeFeedbackDataModel();
  }
}
