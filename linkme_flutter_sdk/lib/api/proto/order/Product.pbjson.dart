///
//  Generated code. Do not modify.
//  source: api/proto/order/Product.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use orderProductBodyDescriptor instead')
const OrderProductBody$json = const {
  '1': 'OrderProductBody',
  '2': const [
    const {'1': 'OrderID', '3': 1, '4': 1, '5': 9, '10': 'OrderID'},
    const {'1': 'productID', '3': 2, '4': 1, '5': 9, '10': 'productID'},
    const {'1': 'buyerUserName', '3': 3, '4': 1, '5': 9, '10': 'buyerUserName'},
    const {'1': 'storeUserName', '3': 5, '4': 1, '5': 9, '10': 'storeUserName'},
    const {'1': 'totalAmount', '3': 7, '4': 1, '5': 13, '10': 'totalAmount'},
    const {'1': 'payMode', '3': 8, '4': 1, '5': 13, '10': 'payMode'},
    const {'1': 'body', '3': 9, '4': 1, '5': 9, '10': 'body'},
    const {'1': 'fee', '3': 10, '4': 1, '5': 13, '10': 'fee'},
    const {'1': 'state', '3': 11, '4': 1, '5': 14, '6': '.cloud.lianmi.im.global.OrderState', '10': 'state'},
    const {'1': 'ticketCode', '3': 13, '4': 1, '5': 6, '10': 'ticketCode'},
    const {'1': 'orderImageFile', '3': 14, '4': 1, '5': 9, '10': 'orderImageFile'},
    const {'1': 'imageHash', '3': 15, '4': 1, '5': 9, '10': 'imageHash'},
    const {'1': 'prize', '3': 16, '4': 1, '5': 13, '10': 'prize'},
    const {'1': 'receiptQrCodeImageUrl', '3': 17, '4': 1, '5': 9, '10': 'receiptQrCodeImageUrl'},
    const {'1': 'prizeQrCodeImageUrl', '3': 18, '4': 1, '5': 9, '10': 'prizeQrCodeImageUrl'},
    const {'1': 'blockNumber', '3': 19, '4': 1, '5': 6, '10': 'blockNumber'},
    const {'1': 'txHash', '3': 20, '4': 1, '5': 9, '10': 'txHash'},
    const {'1': 'orderTime', '3': 21, '4': 1, '5': 6, '10': 'orderTime'},
  ],
};

/// Descriptor for `OrderProductBody`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List orderProductBodyDescriptor = $convert.base64Decode('ChBPcmRlclByb2R1Y3RCb2R5EhgKB09yZGVySUQYASABKAlSB09yZGVySUQSHAoJcHJvZHVjdElEGAIgASgJUglwcm9kdWN0SUQSJAoNYnV5ZXJVc2VyTmFtZRgDIAEoCVINYnV5ZXJVc2VyTmFtZRIkCg1zdG9yZVVzZXJOYW1lGAUgASgJUg1zdG9yZVVzZXJOYW1lEiAKC3RvdGFsQW1vdW50GAcgASgNUgt0b3RhbEFtb3VudBIYCgdwYXlNb2RlGAggASgNUgdwYXlNb2RlEhIKBGJvZHkYCSABKAlSBGJvZHkSEAoDZmVlGAogASgNUgNmZWUSOAoFc3RhdGUYCyABKA4yIi5jbG91ZC5saWFubWkuaW0uZ2xvYmFsLk9yZGVyU3RhdGVSBXN0YXRlEh4KCnRpY2tldENvZGUYDSABKAZSCnRpY2tldENvZGUSJgoOb3JkZXJJbWFnZUZpbGUYDiABKAlSDm9yZGVySW1hZ2VGaWxlEhwKCWltYWdlSGFzaBgPIAEoCVIJaW1hZ2VIYXNoEhQKBXByaXplGBAgASgNUgVwcml6ZRI0ChVyZWNlaXB0UXJDb2RlSW1hZ2VVcmwYESABKAlSFXJlY2VpcHRRckNvZGVJbWFnZVVybBIwChNwcml6ZVFyQ29kZUltYWdlVXJsGBIgASgJUhNwcml6ZVFyQ29kZUltYWdlVXJsEiAKC2Jsb2NrTnVtYmVyGBMgASgGUgtibG9ja051bWJlchIWCgZ0eEhhc2gYFCABKAlSBnR4SGFzaBIcCglvcmRlclRpbWUYFSABKAZSCW9yZGVyVGltZQ==');
