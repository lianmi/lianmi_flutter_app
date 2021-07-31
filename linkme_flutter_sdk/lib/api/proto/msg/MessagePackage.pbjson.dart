///
//  Generated code. Do not modify.
//  source: api/proto/msg/MessagePackage.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use messagePackageDescriptor instead')
const MessagePackage$json = const {
  '1': 'MessagePackage',
  '2': const [
    const {'1': 'scene', '3': 1, '4': 1, '5': 14, '6': '.cloud.lianmi.im.msg.MessageScene', '10': 'scene'},
    const {'1': 'type', '3': 2, '4': 1, '5': 14, '6': '.cloud.lianmi.im.msg.MessageType', '10': 'type'},
    const {'1': 'serverMsgId', '3': 3, '4': 1, '5': 9, '10': 'serverMsgId'},
    const {'1': 'workflowID', '3': 4, '4': 1, '5': 9, '10': 'workflowID'},
    const {'1': 'uuid', '3': 5, '4': 1, '5': 9, '10': 'uuid'},
    const {'1': 'seq', '3': 6, '4': 1, '5': 6, '10': 'seq'},
    const {'1': 'status', '3': 7, '4': 1, '5': 14, '6': '.cloud.lianmi.im.msg.MessageStatus', '10': 'status'},
    const {'1': 'from', '3': 8, '4': 1, '5': 9, '10': 'from'},
    const {'1': 'to', '3': 9, '4': 1, '5': 9, '10': 'to'},
    const {'1': 'body', '3': 10, '4': 1, '5': 12, '10': 'body'},
    const {'1': 'userUpdateTime', '3': 11, '4': 1, '5': 6, '10': 'userUpdateTime'},
    const {'1': 'time', '3': 12, '4': 1, '5': 6, '10': 'time'},
  ],
};

/// Descriptor for `MessagePackage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List messagePackageDescriptor = $convert.base64Decode('Cg5NZXNzYWdlUGFja2FnZRI3CgVzY2VuZRgBIAEoDjIhLmNsb3VkLmxpYW5taS5pbS5tc2cuTWVzc2FnZVNjZW5lUgVzY2VuZRI0CgR0eXBlGAIgASgOMiAuY2xvdWQubGlhbm1pLmltLm1zZy5NZXNzYWdlVHlwZVIEdHlwZRIgCgtzZXJ2ZXJNc2dJZBgDIAEoCVILc2VydmVyTXNnSWQSHgoKd29ya2Zsb3dJRBgEIAEoCVIKd29ya2Zsb3dJRBISCgR1dWlkGAUgASgJUgR1dWlkEhAKA3NlcRgGIAEoBlIDc2VxEjoKBnN0YXR1cxgHIAEoDjIiLmNsb3VkLmxpYW5taS5pbS5tc2cuTWVzc2FnZVN0YXR1c1IGc3RhdHVzEhIKBGZyb20YCCABKAlSBGZyb20SDgoCdG8YCSABKAlSAnRvEhIKBGJvZHkYCiABKAxSBGJvZHkSJgoOdXNlclVwZGF0ZVRpbWUYCyABKAZSDnVzZXJVcGRhdGVUaW1lEhIKBHRpbWUYDCABKAZSBHRpbWU=');
