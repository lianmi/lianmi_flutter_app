///
//  Generated code. Do not modify.
//  source: api/proto/msg/RecvMsgEvent.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use recvMsgEventRspDescriptor instead')
const RecvMsgEventRsp$json = const {
  '1': 'RecvMsgEventRsp',
  '2': const [
    const {'1': 'scene', '3': 1, '4': 1, '5': 14, '6': '.cloud.lianmi.im.msg.MessageScene', '10': 'scene'},
    const {'1': 'type', '3': 2, '4': 1, '5': 14, '6': '.cloud.lianmi.im.msg.MessageType', '10': 'type'},
    const {'1': 'body', '3': 3, '4': 1, '5': 12, '10': 'body'},
    const {'1': 'from', '3': 4, '4': 1, '5': 9, '10': 'from'},
    const {'1': 'fromDeviceId', '3': 5, '4': 1, '5': 9, '10': 'fromDeviceId'},
    const {'1': 'recv', '3': 6, '4': 1, '5': 9, '10': 'recv'},
    const {'1': 'serverMsgId', '3': 7, '4': 1, '5': 9, '10': 'serverMsgId'},
    const {'1': 'workflowID', '3': 8, '4': 1, '5': 9, '10': 'workflowID'},
    const {'1': 'seq', '3': 9, '4': 1, '5': 6, '10': 'seq'},
    const {'1': 'uuid', '3': 10, '4': 1, '5': 9, '10': 'uuid'},
    const {'1': 'time', '3': 11, '4': 1, '5': 6, '10': 'time'},
  ],
};

/// Descriptor for `RecvMsgEventRsp`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List recvMsgEventRspDescriptor = $convert.base64Decode('Cg9SZWN2TXNnRXZlbnRSc3ASNwoFc2NlbmUYASABKA4yIS5jbG91ZC5saWFubWkuaW0ubXNnLk1lc3NhZ2VTY2VuZVIFc2NlbmUSNAoEdHlwZRgCIAEoDjIgLmNsb3VkLmxpYW5taS5pbS5tc2cuTWVzc2FnZVR5cGVSBHR5cGUSEgoEYm9keRgDIAEoDFIEYm9keRISCgRmcm9tGAQgASgJUgRmcm9tEiIKDGZyb21EZXZpY2VJZBgFIAEoCVIMZnJvbURldmljZUlkEhIKBHJlY3YYBiABKAlSBHJlY3YSIAoLc2VydmVyTXNnSWQYByABKAlSC3NlcnZlck1zZ0lkEh4KCndvcmtmbG93SUQYCCABKAlSCndvcmtmbG93SUQSEAoDc2VxGAkgASgGUgNzZXESEgoEdXVpZBgKIAEoCVIEdXVpZBISCgR0aW1lGAsgASgGUgR0aW1l');
