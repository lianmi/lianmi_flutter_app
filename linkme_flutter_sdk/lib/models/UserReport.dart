// To parse this JSON data, do
//
//     final proposeFeedback = proposeFeedbackFromMap(jsonString);

import 'dart:convert';

class UserReportData {
  UserReportData({
    this.userName,
    this.type,
    this.description,
    this.image1,
    this.image2,
  });

  String? userName;
  int? type;
  String? description;
  String? image1;
  String? image2;

  factory UserReportData.fromJson(String str) =>
      UserReportData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserReportData.fromMap(Map<String, dynamic> json) => UserReportData(
        userName: json["user_name"],
        type: json["type"],
        description: json["description"],
        image1: json["image1"],
        image2: json["image2"],
      );

  Map<String, dynamic> toMap() => {
        "user_name": userName,
        "type": type,
        "description": description,
        "image1": image1,
        "image2": image2,
      };
}
