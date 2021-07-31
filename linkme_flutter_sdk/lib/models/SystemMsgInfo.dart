// // To parse this JSON data, do
// //
// //     final systemMsgInfo = systemMsgInfoFromMap(jsonString);

// import 'dart:convert';

// class SystemMsgInfo {
//   SystemMsgInfo({
//     this.publishTime,
//     this.level,
//     this.title,
//     this.content,
//   });

//   String? publishTime;
//   int? level;
//   String? title;
//   String? content;

//   factory SystemMsgInfo.fromJson(String str) =>
//       SystemMsgInfo.fromMap(json.decode(str));

//   String toJson() => json.encode(toMap());

//   factory SystemMsgInfo.fromMap(Map<String, dynamic> json) => SystemMsgInfo(
//         publishTime: json["publish_time"],
//         level: json["level"],
//         title: json["title"],
//         content: json["content"],
//       );

//   Map<String, dynamic> toMap() => {
//         "publish_time": publishTime,
//         "level": level,
//         "title": title,
//         "content": content,
//       };
// }
