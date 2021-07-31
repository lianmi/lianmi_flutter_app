class PaiLie5Model {
  List<int>? geweiNumbers; //个位号码组合 0-9,
  List<int>? shiweiNumbers; //十位号码组合 0-9,
  List<int>? baiweiNumbers; //百位号码组合 0-9,
  List<int>? qianweiNumbers; //千位号码组合 0-9,
  List<int>? wanweiNumbers; //万位号码组合 0-9,

  PaiLie5Model(
      {this.geweiNumbers,
      this.shiweiNumbers,
      this.baiweiNumbers,
      this.qianweiNumbers,
      this.wanweiNumbers});

  PaiLie5Model.fromJson(Map<String, dynamic> json) {
    geweiNumbers = json['geweiNumbers'].cast<int>();
    shiweiNumbers = json['shiweiNumbers'].cast<int>();
    baiweiNumbers = json['baiweiNumbers'].cast<int>();
    qianweiNumbers = json['qianweiNumbers'].cast<int>();
    wanweiNumbers = json['wanweiNumbers'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['geweiNumbers'] = this.geweiNumbers;
    data['shiweiNumbers'] = this.shiweiNumbers;
    data['baiweiNumbers'] = this.baiweiNumbers;
    data['qianweiNumbers'] = this.qianweiNumbers;
    data['wanweiNumbers'] = this.wanweiNumbers;
    return data;
  }

  String toString() {
    return (StringBuffer('PaiLie5Model(')
          ..write('geweiNumbers: $geweiNumbers, ')
          ..write('shiweiNumbers: $shiweiNumbers, ')
          ..write('baiweiNumbers: $baiweiNumbers')
          ..write('qianweiNumbers: $qianweiNumbers')
          ..write('wanweiNumbers: $wanweiNumbers')
          ..write(')'))
        .toString();
  }
}
