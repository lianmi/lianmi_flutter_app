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

/*
 {
  user_name: id1, 
  gender: 1, 
  nick: 李示佳, 
  avatar: https://lianmi-ipfs.oss-cn-hangzhou.aliyuncs.com/avatars/id1/2021/07/05/550e2c202c2933609207c81bee8fc5ff?x-oss-process=image/resize,w_50/quality,q_50?x-oss-process=image/resize,w_50/quality,q_50, 
  label:  区块链彩票专家, 
  mobile: 13702290109, 
  email: lianmicloud@163.com, 
  user_type: 1, 
  true_name: 李示佳, 
  identity_card: 440725197207290017, 
  province: 广东省, 
  city: 鹤山市, 
  area: 沙坪街道, 
  address: 新鹤路乐民村116号302房
 }  
 */
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
