// To parse this JSON data, do
//
//     final storeInfoData = storeInfoDataFromMap(jsonString);

import 'dart:convert';

class StoreInfo {
  StoreInfo({
    this.userName,
    this.avatar, //店铺用户头像
    this.storeType,
    this.licenseUrl,
    this.legalPerson,
    this.legalIdentityCard,
    this.idCardFrontPhoto,
    this.idCardBackPhoto,
    this.imageUrl,
    this.introductory,
    this.keys,
    this.contactMobile,
    this.wechat,
    this.branchesName,
    this.openingHours,
    this.province,
    this.city,
    this.area,
    this.address,
    this.longitude,
    this.latitude,
    this.businessCode,
    this.cardOwner,
    this.bankName,
    this.bankBranch,
    this.cardNumber,
    this.auditState,
  });

  String? userName;
  String? avatar;
  int? storeType;
  String? licenseUrl;
  String? legalPerson;
  String? legalIdentityCard;
  String? idCardFrontPhoto;
  String? idCardBackPhoto;
  String? imageUrl;
  String? introductory;
  String? keys;
  String? contactMobile;
  String? wechat;
  String? branchesName;
  String? openingHours;
  String? province;
  String? city;
  String? area;
  String? address;
  String? longitude;
  String? latitude;
  String? businessCode;
  String? cardOwner;
  String? bankName;
  String? bankBranch;
  String? cardNumber;
  int? auditState;

  factory StoreInfo.fromJson(String str) => StoreInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StoreInfo.fromMap(Map<String, dynamic> json) => StoreInfo(
        userName: json["user_name"],
        avatar: json["avatar"],
        storeType: json["store_type"],
        licenseUrl: json["license_url"],
        legalPerson: json["legal_person"],
        legalIdentityCard: json["legal_identity_card"],
        idCardFrontPhoto: json["id_card_front_photo"],
        idCardBackPhoto: json["id_card_back_photo"],
        imageUrl: json["image_url"],
        introductory: json["introductory"],
        keys: json["keys"],
        contactMobile: json["contact_mobile"],
        wechat: json["wechat"],
        branchesName: json["branches_name"],
        openingHours: json["opening_hours"],
        province: json["province"],
        city: json["city"],
        area: json["area"],
        address: json["address"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        businessCode: json["business_code"],
        cardOwner: json["card_owner"],
        bankName: json["bank_name"],
        bankBranch: json["bank_branch"],
        cardNumber: json["card_number"],
        auditState: json["audit_state"],
      );

  Map<String, dynamic> toMap() => {
        "user_name": userName,
        "avatar": avatar,
        "store_type": storeType,
        "license_url": licenseUrl,
        "legal_person": legalPerson,
        "legal_identity_card": legalIdentityCard,
        "id_card_front_photo": idCardFrontPhoto,
        "id_card_back_photo": idCardBackPhoto,
        "image_url": imageUrl,
        "introductory": introductory,
        "keys": keys,
        "contact_mobile": contactMobile,
        "wechat": wechat,
        "branches_name": branchesName,
        "opening_hours": openingHours,
        "province": province,
        "city": city,
        "area": area,
        "address": address,
        "longitude": longitude,
        "latitude": latitude,
        "business_code": businessCode,
        "card_owner": cardOwner,
        "bank_name": bankName,
        "bank_branch": bankBranch,
        "card_number": cardNumber,
        "audit_state": auditState,
      };
}
