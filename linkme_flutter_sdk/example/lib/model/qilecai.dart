class QilecaiModel {
  List<int>? numbers; //30个号码里任选7个

  QilecaiModel({
    this.numbers,
  });

  QilecaiModel.fromJson(Map<String, dynamic> json) {
    numbers = json['numbers'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['numbers'] = this.numbers;
    return data;
  }

  String toString() {
    return (StringBuffer('QilecaiModel(')
          ..write('numbers: $numbers, ')
          ..write(')'))
        .toString();
  }
}
