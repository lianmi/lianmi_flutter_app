// To parse this JSON data, do
//
//     final proposeFeedback = proposeFeedbackFromMap(jsonString);

import 'dart:convert';

class ProposeFeedbackData {
  ProposeFeedbackData({
    this.userName,
    this.title,
    this.detail,
    this.image1,
    this.image2,
  });

  String? userName;
  String? title;
  String? detail;
  String? image1;
  String? image2;

  factory ProposeFeedbackData.fromJson(String str) =>
      ProposeFeedbackData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProposeFeedbackData.fromMap(Map<String, dynamic> json) =>
      ProposeFeedbackData(
        userName: json["user_name"],
        title: json["title"],
        detail: json["detail"],
        image1: json["image1"],
        image2: json["image2"],
      );

  Map<String, dynamic> toMap() => {
        "user_name": userName,
        "title": title,
        "detail": detail,
        "image1": image1,
        "image2": image2,
      };
}
