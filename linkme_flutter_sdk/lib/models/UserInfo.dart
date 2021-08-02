// To parse this JSON data, do
//
//     final userInfo = userInfoFromMap(jsonString);

import 'dart:convert';

class UserInfo {
  UserInfo({
    this.userName,
    this.gender,
    this.nick,
    this.avatar,
    this.label,
    this.mobile,
    this.email,
    this.userType,
    this.state,
    this.trueName,
    this.identityCard,
    this.province,
    this.city,
    this.area,
    this.address,
    this.vipEndDate,
  });

  String? userName;
  int? gender;
  String? nick;
  String? avatar;
  String? label;
  String? mobile;
  String? email;
  int? userType;
  int? state;
  String? trueName;
  String? identityCard;
  String? province;
  String? city;
  String? area;
  String? address;
  int? vipEndDate;

  factory UserInfo.fromJson(String str) => UserInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserInfo.fromMap(Map<String, dynamic> json) => UserInfo(
        userName: json["user_name"],
        gender: json["gender"],
        nick: json["nick"],
        avatar: json["avatar"],
        label: json["label"],
        mobile: json["mobile"],
        email: json["email"],
        userType: json["user_type"],
        state: json["state"],
        trueName: json["true_name"],
        identityCard: json["identity_card"],
        province: json["province"],
        city: json["city"],
        area: json["area"],
        address: json["address"],
        vipEndDate: json["vip_end_date"],
      );

  Map<String, dynamic> toMap() => {
        "user_name": userName,
        "gender": gender,
        "nick": nick,
        "avatar": avatar,
        "label": label,
        "mobile": mobile,
        "email": email,
        "user_type": userType,
        "state": state,
        "true_name": trueName,
        "identity_card": identityCard,
        "province": province,
        "city": city,
        "area": area,
        "address": address,
        "vip_end_date": vipEndDate,
      };
}
