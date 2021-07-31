///
//  Generated code. Do not modify.
//  source: api/proto/auth/KickedEvent.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use clientTypeDescriptor instead')
const ClientType$json = const {
  '1': 'ClientType',
  '2': const [
    const {'1': 'Ct_UnKnow', '2': 0},
    const {'1': 'Ct_Android', '2': 1},
    const {'1': 'Ct_iOS', '2': 2},
    const {'1': 'Ct_RESTApi', '2': 3},
    const {'1': 'Ct_Windows', '2': 4},
    const {'1': 'Ct_MacOS', '2': 5},
    const {'1': 'Ct_Web', '2': 6},
  ],
};

/// Descriptor for `ClientType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List clientTypeDescriptor = $convert.base64Decode('CgpDbGllbnRUeXBlEg0KCUN0X1VuS25vdxAAEg4KCkN0X0FuZHJvaWQQARIKCgZDdF9pT1MQAhIOCgpDdF9SRVNUQXBpEAMSDgoKQ3RfV2luZG93cxAEEgwKCEN0X01hY09TEAUSCgoGQ3RfV2ViEAY=');
@$core.Deprecated('Use clientModeDescriptor instead')
const ClientMode$json = const {
  '1': 'ClientMode',
  '2': const [
    const {'1': 'Clm_UnKnow', '2': 0},
    const {'1': 'Clm_Im', '2': 1},
    const {'1': 'Clm_ImEncrypted', '2': 2},
  ],
};

/// Descriptor for `ClientMode`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List clientModeDescriptor = $convert.base64Decode('CgpDbGllbnRNb2RlEg4KCkNsbV9Vbktub3cQABIKCgZDbG1fSW0QARITCg9DbG1fSW1FbmNyeXB0ZWQQAg==');
@$core.Deprecated('Use kickReasonDescriptor instead')
const KickReason$json = const {
  '1': 'KickReason',
  '2': const [
    const {'1': 'KickReasonUndefined', '2': 0},
    const {'1': 'SamePlatformKick', '2': 1},
    const {'1': 'Blacked', '2': 2},
    const {'1': 'OtherPlatformKick', '2': 3},
  ],
};

/// Descriptor for `KickReason`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List kickReasonDescriptor = $convert.base64Decode('CgpLaWNrUmVhc29uEhcKE0tpY2tSZWFzb25VbmRlZmluZWQQABIUChBTYW1lUGxhdGZvcm1LaWNrEAESCwoHQmxhY2tlZBACEhUKEU90aGVyUGxhdGZvcm1LaWNrEAM=');
@$core.Deprecated('Use kickedEventRspDescriptor instead')
const KickedEventRsp$json = const {
  '1': 'KickedEventRsp',
  '2': const [
    const {'1': 'clientType', '3': 1, '4': 1, '5': 14, '6': '.cloud.lianmi.im.auth.ClientType', '10': 'clientType'},
    const {'1': 'reason', '3': 2, '4': 1, '5': 14, '6': '.cloud.lianmi.im.auth.KickReason', '10': 'reason'},
    const {'1': 'timeTag', '3': 3, '4': 1, '5': 6, '10': 'timeTag'},
  ],
};

/// Descriptor for `KickedEventRsp`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List kickedEventRspDescriptor = $convert.base64Decode('Cg5LaWNrZWRFdmVudFJzcBJACgpjbGllbnRUeXBlGAEgASgOMiAuY2xvdWQubGlhbm1pLmltLmF1dGguQ2xpZW50VHlwZVIKY2xpZW50VHlwZRI4CgZyZWFzb24YAiABKA4yIC5jbG91ZC5saWFubWkuaW0uYXV0aC5LaWNrUmVhc29uUgZyZWFzb24SGAoHdGltZVRhZxgDIAEoBlIHdGltZVRhZw==');
