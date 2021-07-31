class Fucai3dModel {
  List<int>? geweiNumbers; //个位号码组合 0-9,
  List<int>? shiweiNumbers; //十位号码组合 0-9,
  List<int>? baiweiNumbers; //百位号码组合 0-9,

  Fucai3dModel(
      {this.geweiNumbers,
      this.shiweiNumbers,
      this.baiweiNumbers});

  Fucai3dModel.fromJson(Map<String, dynamic> json) {
    geweiNumbers = json['geweiNumbers'].cast<int>();
    shiweiNumbers = json['shiweiNumbers'].cast<int>();
    baiweiNumbers = json['baiweiNumbers'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['geweiNumbers'] = this.geweiNumbers;
    data['shiweiNumbers'] = this.shiweiNumbers;
    data['baiweiNumbers'] = this.baiweiNumbers;
    return data;
  }

  String toString() {
    return (StringBuffer('Fucai3dModel(')
          ..write('geweiNumbers: $geweiNumbers, ')
          ..write('shiweiNumbers: $shiweiNumbers, ')
          ..write('baiweiNumbers: $baiweiNumbers')
          ..write(')'))
        .toString();
  }
}
