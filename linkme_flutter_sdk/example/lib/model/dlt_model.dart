class DLTModel {
  List<int>? frontSectionNumbers; //前区号码组合 1-35, 当胆拖投注时为拖码, 最多只能选择15个
  List<int>? backSectionNumbers; //后区号码组合 1-12, 当胆拖投注时为拖码
  List<int>? danmaFrontNumbers; //前区胆码组合, 从01—35中选取1至4个号码为胆码
  bool? additional; //是否追加， 不追加是2元一注, 追加是3元一注

  DLTModel(
      {this.frontSectionNumbers,
      this.backSectionNumbers,
      this.danmaFrontNumbers,
      this.additional});

  DLTModel.fromJson(Map<String, dynamic> json) {
    frontSectionNumbers = json['frontSectionNumbers'].cast<int>();
    backSectionNumbers = json['backSectionNumbers'].cast<int>();
    if (json['danmaFrontNumbers'] != null) {
      danmaFrontNumbers = json['danmaFrontNumbers'].cast<int>();
    } else {
      danmaFrontNumbers = [];
    }

    additional = json['additional'] as bool;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['frontSectionNumbers'] = this.frontSectionNumbers;
    data['backSectionNumbers'] = this.backSectionNumbers;
    data['danmaFrontNumbers'] = this.danmaFrontNumbers;
    data['additional'] = this.additional;
    return data;
  }

  String toString() {
    return (StringBuffer('DLTModel(')
          ..write('frontSectionNumbers: $frontSectionNumbers, ')
          ..write('backSectionNumbers: $backSectionNumbers, ')
          ..write('danmaFrontNumbers: $danmaFrontNumbers, ')
          ..write('additional: $additional ')
          ..write(')'))
        .toString();
  }
}
