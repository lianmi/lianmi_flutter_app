import 'dart:convert';

class OrderInfoData {
  OrderInfoData({
    this.orderId,
    this.orderTime,
    this.ticketCode,
    this.productId,
    this.body,
    this.buyerUsername,
    this.storeUsername,
    this.totalAmount, //以分为单位
    this.fee, //服务费
    this.payMode,
    this.state,
    this.isPayed,
    this.bodyType,
    this.orderImagefile,
    this.imageHash,
    this.blockNumber,
    this.txHash,
    this.prize,
    this.prizedPhoto,
    this.content, //手工输入内容
    this.photos, //交互图片数组
  });

  String? orderId; //订单id
  int? orderTime; //订单时间
  int? ticketCode; //出票码
  String? productId; //商品id
  String? body; //订单选号内容
  String? buyerUsername; //买家id
  String? storeUsername; //商户id
  int? totalAmount; //以分为单位
  int? fee; //以分为单位
  int? payMode; //支付方式 1-微信 2-支付宝
  int? state; //订单状态
  bool? isPayed; //是否已支付
  int? bodyType; //暂时无用
  String? orderImagefile; //彩票图片
  String? imageHash; //彩票图片哈希
  int? blockNumber; //上链之后的区块高度
  String? txHash; //交易哈希
  int? prize; //以分为单位
  String? prizedPhoto; //兑奖后的图片

  ///2021-08-06新增
  String? content; //订单内容说明，支持多行
  List<String>? photos; //交互的图片，用户和商户在订单完成之前都有权上传及删除

  factory OrderInfoData.fromJson(String str) =>
      OrderInfoData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OrderInfoData.fromMap(Map<String, dynamic> json) => OrderInfoData(
        orderId: json["order_id"],
        orderTime: json["order_time"],
        ticketCode: json["ticket_code"],
        productId: json["product_id"],
        body: json["body"],
        buyerUsername: json["buyer_username"],
        storeUsername: json["store_username"],
        totalAmount: json["total_amount"],
        fee: json["fee"],
        payMode: json["pay_mode"],
        state: json["state"],
        isPayed: json["is_payed"],
        bodyType: json["body_type"],
        orderImagefile: json["order_imagefile"],
        imageHash: json["image_hash"],
        blockNumber: json["block_number"],
        txHash: json["tx_hash"],
        prize: json["prize"],
        prizedPhoto: json["prized_photo"],
        content: json["content"],
        photos: json["photos"] == null ? [] : json["photos"].cast<String>(),
      );

  Map<String, dynamic> toMap() => {
        "order_id": orderId,
        "order_time": orderTime,
        "ticket_code": ticketCode,
        "product_id": productId,
        "body": body,
        "buyer_username": buyerUsername,
        "store_username": storeUsername,
        "total_amount": totalAmount,
        "fee": fee,
        "pay_mode": payMode,
        "state": state,
        "is_payed": isPayed,
        "body_type": bodyType,
        "order_imagefile": orderImagefile,
        "image_hash": imageHash,
        "block_number": blockNumber,
        "tx_hash": txHash,
        "prize": prize,
        "prized_photo": prizedPhoto,
        "content": content,
        "photos": json.encode(photos), //将photos转为字符串s
      };
}
