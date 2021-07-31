class HistoryNoticeModel {
  String? publishTime;
  int? level;
  String? title;
  String? content;

  HistoryNoticeModel({
    this.publishTime,
    this.level,
    this.title,
    this.content,
  });

  HistoryNoticeModel.fromJson(dynamic json) {
    publishTime = json["publish_time"];
    level = json["level"];
    title = json["title"];
    content = json["content"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["publishTime"] = publishTime;
    map["level"] = level;
    map["title"] = title;
    map["content"] = content;
    return map;
  }
}
