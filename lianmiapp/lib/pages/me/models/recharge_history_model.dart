class RechargeHistoryModel {
  int? id;
  int? createdAt;
  int? totalAmount;
  String? subject;
  int? transactionType;
  String? outTradeNo;

  RechargeHistoryModel({
      this.id, 
      this.createdAt, 
      this.totalAmount, 
      this.subject, 
      this.transactionType, 
      this.outTradeNo});

  RechargeHistoryModel.fromJson(dynamic json) {
    id = json["ID"];
    createdAt = json["CreatedAt"];
    totalAmount = json["total_amount"];
    subject = json["subject"];
    transactionType = json["transaction_type"];
    outTradeNo = json["out_trade_no"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["ID"] = id;
    map["CreatedAt"] = createdAt;
    map["total_amount"] = totalAmount;
    map["subject"] = subject;
    map["transaction_type"] = transactionType;
    map["out_trade_no"] = outTradeNo;
    return map;
  }

}