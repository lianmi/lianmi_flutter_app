import 'package:flutter/material.dart';
import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/models/store_review_data_model.dart';
import 'package:lianmiapp/util/text_utils.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';
import 'package:linkme_flutter_sdk/sdk/AuthMod.dart';

class StoreReviewProvider extends ChangeNotifier {
  StoreReviewDataModel _reviewData = StoreReviewDataModel();

  StoreReviewDataModel get reviewData => _reviewData;

  void submit() async {
    if (isValidString(_reviewData.legalPerson) == false) {
      HubView.showToast('请输入法人姓名');
      return;
    }
    if (isValidString(_reviewData.legalIdentityCard) == false) {
      HubView.showToast('请输入身份证号码');
      return;
    }
    if (isValidString(_reviewData.idCardFrontPhoto) == false) {
      HubView.showToast('请上传身份证正面');
      return;
    }
    if (isValidString(_reviewData.idCardBackPhoto) == false) {
      HubView.showToast('请上传身份证反面');
      return;
    }
    if (isValidString(_reviewData.branchesname) == false) {
      HubView.showToast('请输入商户名称');
      return;
    }
    if (isValidString(_reviewData.introductory) == false) {
      HubView.showToast('请输入简介');
      return;
    }
    if (_reviewData.storeType == 0) {
      HubView.showToast('请选择商户类型');
      return;
    }
    if (isValidString(_reviewData.province) == false) {
      HubView.showToast('请输入省份');
      return;
    }
    if (isValidString(_reviewData.city) == false) {
      HubView.showToast('请输入城市');
      return;
    }
    if (isValidString(_reviewData.area) == false) {
      HubView.showToast('请输入区县');
      return;
    }
    if (isValidString(_reviewData.address) == false) {
      HubView.showToast('请输入商户地址');
      return;
    }
    if (isValidString(_reviewData.businessLicenseUrl) == false) {
      HubView.showToast('请上传营业执照');
      return;
    }
    if (isValidString(_reviewData.imageUrl) == false) {
      HubView.showToast('请上传形象照片');
      return;
    }
    // if (isValidString(_reviewData.cardOwner) == false) {
    //   HubView.showToast('请输入银行卡姓名');
    //   return;
    // }
    // if (isValidString(_reviewData.bankName) == false) {
    //   HubView.showToast('请输入银行名称');
    //   return;
    // }
    // if (isValidString(_reviewData.bankBranch) == false) {
    //   HubView.showToast('请输入银行支行');
    //   return;
    // }
    // if (isValidString(_reviewData.cardNumber) == false) {
    //   HubView.showToast('请输入银行卡号');
    //   return;
    // }
    if (isValidString(_reviewData.wechat) == false) {
      HubView.showToast('请输入微信号');
      return;
    }
    HubView.showLoading();
    UserMod.completeBusinessUserAudit(
      storeType: _reviewData.storeType,
      branchesname: _reviewData.branchesname,
      imageUrl: _reviewData.imageUrl,
      contactMobile: AppManager.currentMobile!,
      wechat: _reviewData.wechat,
      legalPerson: _reviewData.legalPerson,
      legalIdentityCard: _reviewData.legalIdentityCard,
      idCardFrontPhoto: _reviewData.idCardFrontPhoto,
      idCardBackPhoto: _reviewData.idCardBackPhoto,
      licenseUrl: _reviewData.businessLicenseUrl,
      province: _reviewData.province,
      city: _reviewData.city,
      area: _reviewData.area,
      introductory: _reviewData.introductory,
      address: _reviewData.address,
    ).then((value) {
      Navigator.of(App.context!).popUntil(ModalRoute.withName('/'));
      HubView.showToast('已提交审核，请保持电话畅通或留意微信加好友');
    }).catchError((err) {
      HubView.showToast('提交失败:$err');
    });
  }

  void reset() {
    _reviewData = StoreReviewDataModel();
  }
}
