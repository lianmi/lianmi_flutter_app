class WXPayModel {
  String? appid;//应用id
  String? partnerid; //
  String? prepayid; //预支付id
  String? package; //
  String? noncestr;  //
  int? timestamp;//时间戳
  String? sign;//签名

  WXPayModel({
    this.appid, 
    this.partnerid,
    this.prepayid,
    this.package,
    this.noncestr,
    this.timestamp,
    this.sign,
  });

  WXPayModel.fromJsonMap(Map<String, dynamic> map)
      : appid = map['appid'] as String,
        partnerid = map['partnerid'] as String,
        prepayid = map['prepayid'] as String,
        package = map['package'] as String,
        noncestr = map['noncestr'] as String,
        timestamp =  int.parse(map['timestamp']),
        sign = map['paySign'] as String;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['appid'] = appid;
    data['partnerid'] = partnerid;
    data['prepayid'] = prepayid;
    data['package'] = package;
    data['noncestr'] = noncestr;
    data['timestamp'] = timestamp;
    data['paySign'] = sign;
    return data;
  }

  String toString() {
    return (StringBuffer('HistoryDeposit(')
      ..write('uuid: $appid, ')
      ..write('partnerid: ${partnerid.toString()}, ')
      ..write('prepayid: ${prepayid.toString()}, ')
      ..write('package: $package, ')
      ..write('noncestr: ${noncestr.toString()}, ')
      ..write('timestamp: $timestamp, ')
      ..write('sign: ${sign.toString()}')
      ..write(')'))
        .toString();
  }
}