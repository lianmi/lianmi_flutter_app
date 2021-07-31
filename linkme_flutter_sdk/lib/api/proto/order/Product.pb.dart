///
//  Generated code. Do not modify.
//  source: api/proto/order/Product.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import '../global/Global.pbenum.dart' as $0;

class OrderProductBody extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'OrderProductBody', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'cloud.lianmi.im.order'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'OrderID', protoName: 'OrderID')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'productID', protoName: 'productID')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'buyerUserName', protoName: 'buyerUserName')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'storeUserName', protoName: 'storeUserName')
    ..a<$core.int>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalAmount', $pb.PbFieldType.OU3, protoName: 'totalAmount')
    ..a<$core.int>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payMode', $pb.PbFieldType.OU3, protoName: 'payMode')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'body')
    ..a<$core.int>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fee', $pb.PbFieldType.OU3)
    ..e<$0.OrderState>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'state', $pb.PbFieldType.OE, defaultOrMaker: $0.OrderState.OS_Undefined, valueOf: $0.OrderState.valueOf, enumValues: $0.OrderState.values)
    ..e<$0.LotteryType>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'subType', $pb.PbFieldType.OE, protoName: 'subType', defaultOrMaker: $0.LotteryType.LT_Undefined, valueOf: $0.LotteryType.valueOf, enumValues: $0.LotteryType.values)
    ..a<$fixnum.Int64>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ticketCode', $pb.PbFieldType.OF6, protoName: 'ticketCode', defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'orderImageFile', protoName: 'orderImageFile')
    ..aOS(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'imageHash', protoName: 'imageHash')
    ..a<$core.int>(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'prize', $pb.PbFieldType.OU3)
    ..aOS(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receiptQrCodeImageUrl', protoName: 'receiptQrCodeImageUrl')
    ..aOS(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'prizeQrCodeImageUrl', protoName: 'prizeQrCodeImageUrl')
    ..a<$fixnum.Int64>(19, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'blockNumber', $pb.PbFieldType.OF6, protoName: 'blockNumber', defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(20, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'txHash', protoName: 'txHash')
    ..a<$fixnum.Int64>(21, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'orderTime', $pb.PbFieldType.OF6, protoName: 'orderTime', defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  OrderProductBody._() : super();
  factory OrderProductBody({
    $core.String? orderID,
    $core.String? productID,
    $core.String? buyerUserName,
    $core.String? storeUserName,
    $core.int? totalAmount,
    $core.int? payMode,
    $core.String? body,
    $core.int? fee,
    $0.OrderState? state,
    $0.LotteryType? subType,
    $fixnum.Int64? ticketCode,
    $core.String? orderImageFile,
    $core.String? imageHash,
    $core.int? prize,
    $core.String? receiptQrCodeImageUrl,
    $core.String? prizeQrCodeImageUrl,
    $fixnum.Int64? blockNumber,
    $core.String? txHash,
    $fixnum.Int64? orderTime,
  }) {
    final _result = create();
    if (orderID != null) {
      _result.orderID = orderID;
    }
    if (productID != null) {
      _result.productID = productID;
    }
    if (buyerUserName != null) {
      _result.buyerUserName = buyerUserName;
    }
    if (storeUserName != null) {
      _result.storeUserName = storeUserName;
    }
    if (totalAmount != null) {
      _result.totalAmount = totalAmount;
    }
    if (payMode != null) {
      _result.payMode = payMode;
    }
    if (body != null) {
      _result.body = body;
    }
    if (fee != null) {
      _result.fee = fee;
    }
    if (state != null) {
      _result.state = state;
    }
    if (subType != null) {
      _result.subType = subType;
    }
    if (ticketCode != null) {
      _result.ticketCode = ticketCode;
    }
    if (orderImageFile != null) {
      _result.orderImageFile = orderImageFile;
    }
    if (imageHash != null) {
      _result.imageHash = imageHash;
    }
    if (prize != null) {
      _result.prize = prize;
    }
    if (receiptQrCodeImageUrl != null) {
      _result.receiptQrCodeImageUrl = receiptQrCodeImageUrl;
    }
    if (prizeQrCodeImageUrl != null) {
      _result.prizeQrCodeImageUrl = prizeQrCodeImageUrl;
    }
    if (blockNumber != null) {
      _result.blockNumber = blockNumber;
    }
    if (txHash != null) {
      _result.txHash = txHash;
    }
    if (orderTime != null) {
      _result.orderTime = orderTime;
    }
    return _result;
  }
  factory OrderProductBody.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory OrderProductBody.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  OrderProductBody clone() => OrderProductBody()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  OrderProductBody copyWith(void Function(OrderProductBody) updates) => super.copyWith((message) => updates(message as OrderProductBody)) as OrderProductBody; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static OrderProductBody create() => OrderProductBody._();
  OrderProductBody createEmptyInstance() => create();
  static $pb.PbList<OrderProductBody> createRepeated() => $pb.PbList<OrderProductBody>();
  @$core.pragma('dart2js:noInline')
  static OrderProductBody getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OrderProductBody>(create);
  static OrderProductBody? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get orderID => $_getSZ(0);
  @$pb.TagNumber(1)
  set orderID($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasOrderID() => $_has(0);
  @$pb.TagNumber(1)
  void clearOrderID() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get productID => $_getSZ(1);
  @$pb.TagNumber(2)
  set productID($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasProductID() => $_has(1);
  @$pb.TagNumber(2)
  void clearProductID() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get buyerUserName => $_getSZ(2);
  @$pb.TagNumber(3)
  set buyerUserName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasBuyerUserName() => $_has(2);
  @$pb.TagNumber(3)
  void clearBuyerUserName() => clearField(3);

  @$pb.TagNumber(5)
  $core.String get storeUserName => $_getSZ(3);
  @$pb.TagNumber(5)
  set storeUserName($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(5)
  $core.bool hasStoreUserName() => $_has(3);
  @$pb.TagNumber(5)
  void clearStoreUserName() => clearField(5);

  @$pb.TagNumber(7)
  $core.int get totalAmount => $_getIZ(4);
  @$pb.TagNumber(7)
  set totalAmount($core.int v) { $_setUnsignedInt32(4, v); }
  @$pb.TagNumber(7)
  $core.bool hasTotalAmount() => $_has(4);
  @$pb.TagNumber(7)
  void clearTotalAmount() => clearField(7);

  @$pb.TagNumber(8)
  $core.int get payMode => $_getIZ(5);
  @$pb.TagNumber(8)
  set payMode($core.int v) { $_setUnsignedInt32(5, v); }
  @$pb.TagNumber(8)
  $core.bool hasPayMode() => $_has(5);
  @$pb.TagNumber(8)
  void clearPayMode() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get body => $_getSZ(6);
  @$pb.TagNumber(9)
  set body($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(9)
  $core.bool hasBody() => $_has(6);
  @$pb.TagNumber(9)
  void clearBody() => clearField(9);

  @$pb.TagNumber(10)
  $core.int get fee => $_getIZ(7);
  @$pb.TagNumber(10)
  set fee($core.int v) { $_setUnsignedInt32(7, v); }
  @$pb.TagNumber(10)
  $core.bool hasFee() => $_has(7);
  @$pb.TagNumber(10)
  void clearFee() => clearField(10);

  @$pb.TagNumber(11)
  $0.OrderState get state => $_getN(8);
  @$pb.TagNumber(11)
  set state($0.OrderState v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasState() => $_has(8);
  @$pb.TagNumber(11)
  void clearState() => clearField(11);

  @$pb.TagNumber(12)
  $0.LotteryType get subType => $_getN(9);
  @$pb.TagNumber(12)
  set subType($0.LotteryType v) { setField(12, v); }
  @$pb.TagNumber(12)
  $core.bool hasSubType() => $_has(9);
  @$pb.TagNumber(12)
  void clearSubType() => clearField(12);

  @$pb.TagNumber(13)
  $fixnum.Int64 get ticketCode => $_getI64(10);
  @$pb.TagNumber(13)
  set ticketCode($fixnum.Int64 v) { $_setInt64(10, v); }
  @$pb.TagNumber(13)
  $core.bool hasTicketCode() => $_has(10);
  @$pb.TagNumber(13)
  void clearTicketCode() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get orderImageFile => $_getSZ(11);
  @$pb.TagNumber(14)
  set orderImageFile($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(14)
  $core.bool hasOrderImageFile() => $_has(11);
  @$pb.TagNumber(14)
  void clearOrderImageFile() => clearField(14);

  @$pb.TagNumber(15)
  $core.String get imageHash => $_getSZ(12);
  @$pb.TagNumber(15)
  set imageHash($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(15)
  $core.bool hasImageHash() => $_has(12);
  @$pb.TagNumber(15)
  void clearImageHash() => clearField(15);

  @$pb.TagNumber(16)
  $core.int get prize => $_getIZ(13);
  @$pb.TagNumber(16)
  set prize($core.int v) { $_setUnsignedInt32(13, v); }
  @$pb.TagNumber(16)
  $core.bool hasPrize() => $_has(13);
  @$pb.TagNumber(16)
  void clearPrize() => clearField(16);

  @$pb.TagNumber(17)
  $core.String get receiptQrCodeImageUrl => $_getSZ(14);
  @$pb.TagNumber(17)
  set receiptQrCodeImageUrl($core.String v) { $_setString(14, v); }
  @$pb.TagNumber(17)
  $core.bool hasReceiptQrCodeImageUrl() => $_has(14);
  @$pb.TagNumber(17)
  void clearReceiptQrCodeImageUrl() => clearField(17);

  @$pb.TagNumber(18)
  $core.String get prizeQrCodeImageUrl => $_getSZ(15);
  @$pb.TagNumber(18)
  set prizeQrCodeImageUrl($core.String v) { $_setString(15, v); }
  @$pb.TagNumber(18)
  $core.bool hasPrizeQrCodeImageUrl() => $_has(15);
  @$pb.TagNumber(18)
  void clearPrizeQrCodeImageUrl() => clearField(18);

  @$pb.TagNumber(19)
  $fixnum.Int64 get blockNumber => $_getI64(16);
  @$pb.TagNumber(19)
  set blockNumber($fixnum.Int64 v) { $_setInt64(16, v); }
  @$pb.TagNumber(19)
  $core.bool hasBlockNumber() => $_has(16);
  @$pb.TagNumber(19)
  void clearBlockNumber() => clearField(19);

  @$pb.TagNumber(20)
  $core.String get txHash => $_getSZ(17);
  @$pb.TagNumber(20)
  set txHash($core.String v) { $_setString(17, v); }
  @$pb.TagNumber(20)
  $core.bool hasTxHash() => $_has(17);
  @$pb.TagNumber(20)
  void clearTxHash() => clearField(20);

  @$pb.TagNumber(21)
  $fixnum.Int64 get orderTime => $_getI64(18);
  @$pb.TagNumber(21)
  set orderTime($fixnum.Int64 v) { $_setInt64(18, v); }
  @$pb.TagNumber(21)
  $core.bool hasOrderTime() => $_has(18);
  @$pb.TagNumber(21)
  void clearOrderTime() => clearField(21);
}

