class QixingcaiModel {
  List<int>? oneNumbers; //第一行号码组合 0-9,
  List<int>? twoNumbers; //第二行号码组合 0-9,
  List<int>? threeNumbers; //第三行号码组合 0-9,
  List<int>? fourNumbers; //第四行号码组合 0-9,
  List<int>? fiveNumbers; //第五行号码组合 0-9,
  List<int>? sixNumbers; //第六行号码组合 0-9,
  List<int>? sevenNumbers; //第七行号码组合 0-14,

  QixingcaiModel(
      {this.oneNumbers,
      this.twoNumbers,
      this.threeNumbers,
      this.fourNumbers,
      this.fiveNumbers,
      this.sixNumbers,
      this.sevenNumbers,
      });

  QixingcaiModel.fromJson(Map<String, dynamic> json) {
    oneNumbers = json['oneNumbers'].cast<int>();
    twoNumbers = json['twoNumbers'].cast<int>();
    threeNumbers = json['threeNumbers'].cast<int>();
    fourNumbers = json['fourNumbers'].cast<int>();
    fiveNumbers = json['fiveNumbers'].cast<int>();
    sixNumbers = json['sixNumbers'].cast<int>();
    sevenNumbers = json['sevenNumbers'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['oneNumbers'] = this.oneNumbers;
    data['twoNumbers'] = this.twoNumbers;
    data['threeNumbers'] = this.threeNumbers;
    data['fourNumbers'] = this.fourNumbers;
    data['fiveNumbers'] = this.fiveNumbers;
    data['sixNumbers'] = this.sixNumbers;
    data['sevenNumbers'] = this.sevenNumbers;
    return data;
  }

  String toString() {
    return (StringBuffer('QixingcaiModel(')
          ..write('oneNumbers: $oneNumbers, ')
          ..write('twoNumbers: $twoNumbers, ')
          ..write('threeNumbers: $threeNumbers, ')
          ..write('fourNumbers: $fourNumbers, ')
          ..write('fiveNumbers: $fiveNumbers, ')
          ..write('sixNumbers: $sixNumbers,  ')
          ..write('sevenNumbers: $sevenNumbers, ')
          ..write(')'))
        .toString();
  }
}
