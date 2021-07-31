class FeeHistoryModel {
  String? branchName;
  String? orderId;
  int? fee;
  int? createdAt;

  FeeHistoryModel({
      this.branchName, 
      this.orderId, 
      this.fee, 
      this.createdAt});

  FeeHistoryModel.fromJson(dynamic json) {
    branchName = json["branch_name"];
    orderId = json["order_id"];
    fee = json["fee"];
    createdAt = json["CreatedAt"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["branch_name"] = branchName;
    map["order_id"] = orderId;
    map["fee"] = fee;
    map["CreatedAt"] = createdAt;
    return map;
  }

}