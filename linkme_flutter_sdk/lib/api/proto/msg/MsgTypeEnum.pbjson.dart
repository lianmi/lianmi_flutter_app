///
//  Generated code. Do not modify.
//  source: api/proto/msg/MsgTypeEnum.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use messageSceneDescriptor instead')
const MessageScene$json = const {
  '1': 'MessageScene',
  '2': const [
    const {'1': 'MsgScene_Undefined', '2': 0},
    const {'1': 'MsgScene_C2C', '2': 1},
    const {'1': 'MsgScene_C2G', '2': 2},
    const {'1': 'MsgScene_S2C', '2': 3},
    const {'1': 'MsgScene_ChatRoom', '2': 4},
    const {'1': 'MsgScene_P2P', '2': 5},
  ],
};

/// Descriptor for `MessageScene`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List messageSceneDescriptor = $convert.base64Decode('CgxNZXNzYWdlU2NlbmUSFgoSTXNnU2NlbmVfVW5kZWZpbmVkEAASEAoMTXNnU2NlbmVfQzJDEAESEAoMTXNnU2NlbmVfQzJHEAISEAoMTXNnU2NlbmVfUzJDEAMSFQoRTXNnU2NlbmVfQ2hhdFJvb20QBBIQCgxNc2dTY2VuZV9QMlAQBQ==');
@$core.Deprecated('Use messageTypeDescriptor instead')
const MessageType$json = const {
  '1': 'MessageType',
  '2': const [
    const {'1': 'MsgType_Undefined', '2': 0},
    const {'1': 'MsgType_Text', '2': 1},
    const {'1': 'MsgType_Attach', '2': 2},
    const {'1': 'MsgType_Notification', '2': 3},
    const {'1': 'MsgType_Secret', '2': 4},
    const {'1': 'MsgType_Bin', '2': 5},
    const {'1': 'MsgType_Order', '2': 6},
    const {'1': 'MsgType_SysMsgUpdate', '2': 7},
    const {'1': 'MsgType_Roof', '2': 8},
    const {'1': 'MSgType_Customer', '2': 100},
  ],
};

/// Descriptor for `MessageType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List messageTypeDescriptor = $convert.base64Decode('CgtNZXNzYWdlVHlwZRIVChFNc2dUeXBlX1VuZGVmaW5lZBAAEhAKDE1zZ1R5cGVfVGV4dBABEhIKDk1zZ1R5cGVfQXR0YWNoEAISGAoUTXNnVHlwZV9Ob3RpZmljYXRpb24QAxISCg5Nc2dUeXBlX1NlY3JldBAEEg8KC01zZ1R5cGVfQmluEAUSEQoNTXNnVHlwZV9PcmRlchAGEhgKFE1zZ1R5cGVfU3lzTXNnVXBkYXRlEAcSEAoMTXNnVHlwZV9Sb29mEAgSFAoQTVNnVHlwZV9DdXN0b21lchBk');
@$core.Deprecated('Use attachTypeDescriptor instead')
const AttachType$json = const {
  '1': 'AttachType',
  '2': const [
    const {'1': 'AttachType_Undefined', '2': 0},
    const {'1': 'AttachType_Image', '2': 1},
    const {'1': 'AttachType_Audio', '2': 2},
    const {'1': 'AttachType_Video', '2': 3},
    const {'1': 'AttachType_File', '2': 4},
    const {'1': 'AttachType_Geo', '2': 5},
    const {'1': 'AttachType_Order', '2': 6},
    const {'1': 'AttachType_Transaction', '2': 7},
    const {'1': 'AttachType_BlockServiceCharge', '2': 8},
    const {'1': 'AttachType_VipPrice', '2': 9},
    const {'1': 'AttachType_CustomAttach', '2': 10},
  ],
};

/// Descriptor for `AttachType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List attachTypeDescriptor = $convert.base64Decode('CgpBdHRhY2hUeXBlEhgKFEF0dGFjaFR5cGVfVW5kZWZpbmVkEAASFAoQQXR0YWNoVHlwZV9JbWFnZRABEhQKEEF0dGFjaFR5cGVfQXVkaW8QAhIUChBBdHRhY2hUeXBlX1ZpZGVvEAMSEwoPQXR0YWNoVHlwZV9GaWxlEAQSEgoOQXR0YWNoVHlwZV9HZW8QBRIUChBBdHRhY2hUeXBlX09yZGVyEAYSGgoWQXR0YWNoVHlwZV9UcmFuc2FjdGlvbhAHEiEKHUF0dGFjaFR5cGVfQmxvY2tTZXJ2aWNlQ2hhcmdlEAgSFwoTQXR0YWNoVHlwZV9WaXBQcmljZRAJEhsKF0F0dGFjaFR5cGVfQ3VzdG9tQXR0YWNoEAo=');
@$core.Deprecated('Use messageOrderEventTypeDescriptor instead')
const MessageOrderEventType$json = const {
  '1': 'MessageOrderEventType',
  '2': const [
    const {'1': 'MOET_UNDEFINE', '2': 0},
    const {'1': 'MOET_MakeOrder', '2': 1},
    const {'1': 'MOET_ReceiveOrderr', '2': 2},
    const {'1': 'MOET_CancelOrder', '2': 3},
    const {'1': 'MOET_ReceiveCancelOrder', '2': 4},
    const {'1': 'MOET_Deposit', '2': 5},
    const {'1': 'MOET_WithDraw', '2': 6},
    const {'1': 'MOET_OTCBuy', '2': 7},
    const {'1': 'MOET_OTCSell', '2': 8},
    const {'1': 'MOET_AddProduct', '2': 9},
    const {'1': 'MOET_DeleteProduct', '2': 10},
  ],
};

/// Descriptor for `MessageOrderEventType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List messageOrderEventTypeDescriptor = $convert.base64Decode('ChVNZXNzYWdlT3JkZXJFdmVudFR5cGUSEQoNTU9FVF9VTkRFRklORRAAEhIKDk1PRVRfTWFrZU9yZGVyEAESFgoSTU9FVF9SZWNlaXZlT3JkZXJyEAISFAoQTU9FVF9DYW5jZWxPcmRlchADEhsKF01PRVRfUmVjZWl2ZUNhbmNlbE9yZGVyEAQSEAoMTU9FVF9EZXBvc2l0EAUSEQoNTU9FVF9XaXRoRHJhdxAGEg8KC01PRVRfT1RDQnV5EAcSEAoMTU9FVF9PVENTZWxsEAgSEwoPTU9FVF9BZGRQcm9kdWN0EAkSFgoSTU9FVF9EZWxldGVQcm9kdWN0EAo=');
@$core.Deprecated('Use messageStatusDescriptor instead')
const MessageStatus$json = const {
  '1': 'MessageStatus',
  '2': const [
    const {'1': 'MOS_UDEFINE', '2': 0},
    const {'1': 'MOS_Init', '2': 1},
    const {'1': 'MOS_Declined', '2': 2},
    const {'1': 'MOS_Expired', '2': 3},
    const {'1': 'MOS_Ignored', '2': 4},
    const {'1': 'MOS_Passed', '2': 5},
    const {'1': 'MOS_Taked', '2': 6},
    const {'1': 'MOS_Done', '2': 7},
    const {'1': 'MOS_Cancel', '2': 8},
    const {'1': 'MOS_Processing', '2': 9},
  ],
};

/// Descriptor for `MessageStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List messageStatusDescriptor = $convert.base64Decode('Cg1NZXNzYWdlU3RhdHVzEg8KC01PU19VREVGSU5FEAASDAoITU9TX0luaXQQARIQCgxNT1NfRGVjbGluZWQQAhIPCgtNT1NfRXhwaXJlZBADEg8KC01PU19JZ25vcmVkEAQSDgoKTU9TX1Bhc3NlZBAFEg0KCU1PU19UYWtlZBAGEgwKCE1PU19Eb25lEAcSDgoKTU9TX0NhbmNlbBAIEhIKDk1PU19Qcm9jZXNzaW5nEAk=');
@$core.Deprecated('Use messageSecretTypeDescriptor instead')
const MessageSecretType$json = const {
  '1': 'MessageSecretType',
  '2': const [
    const {'1': 'MST_UNDEFINE', '2': 0},
    const {'1': 'MST_PRE_KRY', '2': 1},
    const {'1': 'MST_MESSAGE', '2': 2},
  ],
};

/// Descriptor for `MessageSecretType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List messageSecretTypeDescriptor = $convert.base64Decode('ChFNZXNzYWdlU2VjcmV0VHlwZRIQCgxNU1RfVU5ERUZJTkUQABIPCgtNU1RfUFJFX0tSWRABEg8KC01TVF9NRVNTQUdFEAI=');
