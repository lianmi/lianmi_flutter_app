///
//  Generated code. Do not modify.
//  source: api/proto/global/Global.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use businessTypeDescriptor instead')
const BusinessType$json = const {
  '1': 'BusinessType',
  '2': const [
    const {'1': 'Bt_undefined', '2': 0},
    const {'1': 'User', '2': 1},
    const {'1': 'Auth', '2': 2},
    const {'1': 'Friends', '2': 3},
    const {'1': 'Team', '2': 4},
    const {'1': 'Msg', '2': 5},
  ],
};

/// Descriptor for `BusinessType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List businessTypeDescriptor = $convert.base64Decode('CgxCdXNpbmVzc1R5cGUSEAoMQnRfdW5kZWZpbmVkEAASCAoEVXNlchABEggKBEF1dGgQAhILCgdGcmllbmRzEAMSCAoEVGVhbRAEEgcKA01zZxAF');
@$core.Deprecated('Use msgSubTypeDescriptor instead')
const MsgSubType$json = const {
  '1': 'MsgSubType',
  '2': const [
    const {'1': 'Cst_undefined', '2': 0},
    const {'1': 'SendMsg', '2': 1},
    const {'1': 'RecvMsgEvent', '2': 2},
    const {'1': 'SyncOfflineSysMsgsEvent', '2': 3},
    const {'1': 'SyncSendMsgEvent', '2': 5},
    const {'1': 'SendCancelMsg', '2': 6},
    const {'1': 'RecvCancelMsgEvent', '2': 7},
    const {'1': 'SyncSendCancelMsgEvent', '2': 8},
    const {'1': 'SyncSystemMsgEvent', '2': 9},
    const {'1': 'MsgAck', '2': 10},
    const {'1': 'UpdateConversation', '2': 11},
  ],
};

/// Descriptor for `MsgSubType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List msgSubTypeDescriptor = $convert.base64Decode('CgpNc2dTdWJUeXBlEhEKDUNzdF91bmRlZmluZWQQABILCgdTZW5kTXNnEAESEAoMUmVjdk1zZ0V2ZW50EAISGwoXU3luY09mZmxpbmVTeXNNc2dzRXZlbnQQAxIUChBTeW5jU2VuZE1zZ0V2ZW50EAUSEQoNU2VuZENhbmNlbE1zZxAGEhYKElJlY3ZDYW5jZWxNc2dFdmVudBAHEhoKFlN5bmNTZW5kQ2FuY2VsTXNnRXZlbnQQCBIWChJTeW5jU3lzdGVtTXNnRXZlbnQQCRIKCgZNc2dBY2sQChIWChJVcGRhdGVDb252ZXJzYXRpb24QCw==');
@$core.Deprecated('Use orderStateDescriptor instead')
const OrderState$json = const {
  '1': 'OrderState',
  '2': const [
    const {'1': 'OS_Undefined', '2': 0},
    const {'1': 'OS_Prepare', '2': 1},
    const {'1': 'OS_SendOK', '2': 2},
    const {'1': 'OS_RecvOK', '2': 3},
    const {'1': 'OS_Taked', '2': 4},
    const {'1': 'OS_Done', '2': 5},
    const {'1': 'OS_Cancel', '2': 6},
    const {'1': 'OS_Processing', '2': 7},
    const {'1': 'OS_Confirm', '2': 8},
    const {'1': 'OS_ApplyCancel', '2': 9},
    const {'1': 'OS_AttachChange', '2': 10},
    const {'1': 'OS_Paying', '2': 11},
    const {'1': 'OS_Overdue', '2': 12},
    const {'1': 'OS_Refuse', '2': 13},
    const {'1': 'OS_IsPayed', '2': 14},
    const {'1': 'OS_Urge', '2': 15},
    const {'1': 'OS_Expedited', '2': 16},
    const {'1': 'OS_UpChained', '2': 17},
    const {'1': 'OS_Prizeed', '2': 18},
    const {'1': 'OS_AcceptPrizeed', '2': 19},
  ],
};

/// Descriptor for `OrderState`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List orderStateDescriptor = $convert.base64Decode('CgpPcmRlclN0YXRlEhAKDE9TX1VuZGVmaW5lZBAAEg4KCk9TX1ByZXBhcmUQARINCglPU19TZW5kT0sQAhINCglPU19SZWN2T0sQAxIMCghPU19UYWtlZBAEEgsKB09TX0RvbmUQBRINCglPU19DYW5jZWwQBhIRCg1PU19Qcm9jZXNzaW5nEAcSDgoKT1NfQ29uZmlybRAIEhIKDk9TX0FwcGx5Q2FuY2VsEAkSEwoPT1NfQXR0YWNoQ2hhbmdlEAoSDQoJT1NfUGF5aW5nEAsSDgoKT1NfT3ZlcmR1ZRAMEg0KCU9TX1JlZnVzZRANEg4KCk9TX0lzUGF5ZWQQDhILCgdPU19VcmdlEA8SEAoMT1NfRXhwZWRpdGVkEBASEAoMT1NfVXBDaGFpbmVkEBESDgoKT1NfUHJpemVlZBASEhQKEE9TX0FjY2VwdFByaXplZWQQEw==');
@$core.Deprecated('Use storeTypeDescriptor instead')
const StoreType$json = const {
  '1': 'StoreType',
  '2': const [
    const {'1': 'ST_Undefined', '2': 0},
    const {'1': 'ST_Fuli', '2': 1},
    const {'1': 'ST_Tiyu', '2': 2},
  ],
};

/// Descriptor for `StoreType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List storeTypeDescriptor = $convert.base64Decode('CglTdG9yZVR5cGUSEAoMU1RfVW5kZWZpbmVkEAASCwoHU1RfRnVsaRABEgsKB1NUX1RpeXUQAg==');
@$core.Deprecated('Use productTypeDescriptor instead')
const ProductType$json = const {
  '1': 'ProductType',
  '2': const [
    const {'1': 'OT_Undefined', '2': 0},
    const {'1': 'OT_FuliLottery', '2': 1},
    const {'1': 'OT_TiyuLottery', '2': 2},
  ],
};

/// Descriptor for `ProductType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List productTypeDescriptor = $convert.base64Decode('CgtQcm9kdWN0VHlwZRIQCgxPVF9VbmRlZmluZWQQABISCg5PVF9GdWxpTG90dGVyeRABEhIKDk9UX1RpeXVMb3R0ZXJ5EAI=');
@$core.Deprecated('Use genderDescriptor instead')
const Gender$json = const {
  '1': 'Gender',
  '2': const [
    const {'1': 'Sex_Unknown', '2': 0},
    const {'1': 'Sex_Male', '2': 1},
    const {'1': 'Sex_Female', '2': 2},
  ],
};

/// Descriptor for `Gender`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List genderDescriptor = $convert.base64Decode('CgZHZW5kZXISDwoLU2V4X1Vua25vd24QABIMCghTZXhfTWFsZRABEg4KClNleF9GZW1hbGUQAg==');
@$core.Deprecated('Use userTypeDescriptor instead')
const UserType$json = const {
  '1': 'UserType',
  '2': const [
    const {'1': 'Ut_Undefined', '2': 0},
    const {'1': 'Ut_Normal', '2': 1},
    const {'1': 'Ut_Business', '2': 2},
    const {'1': 'Ut_Operator', '2': 10086},
  ],
};

/// Descriptor for `UserType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List userTypeDescriptor = $convert.base64Decode('CghVc2VyVHlwZRIQCgxVdF9VbmRlZmluZWQQABINCglVdF9Ob3JtYWwQARIPCgtVdF9CdXNpbmVzcxACEhAKC1V0X09wZXJhdG9yEOZO');
@$core.Deprecated('Use userStateDescriptor instead')
const UserState$json = const {
  '1': 'UserState',
  '2': const [
    const {'1': 'Ss_Normal', '2': 0},
    const {'1': 'Ss_Vip', '2': 1},
    const {'1': 'Ss_Blocked', '2': 2},
  ],
};

/// Descriptor for `UserState`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List userStateDescriptor = $convert.base64Decode('CglVc2VyU3RhdGUSDQoJU3NfTm9ybWFsEAASCgoGU3NfVmlwEAESDgoKU3NfQmxvY2tlZBAC');
@$core.Deprecated('Use userFeildDescriptor instead')
const UserFeild$json = const {
  '1': 'UserFeild',
  '2': const [
    const {'1': 'UserFeild_Undefined', '2': 0},
    const {'1': 'UserFeild_Nick', '2': 1},
    const {'1': 'UserFeild_Gender', '2': 2},
    const {'1': 'UserFeild_Avatar', '2': 3},
    const {'1': 'UserFeild_Label', '2': 4},
    const {'1': 'UserFeild_TrueName', '2': 5},
    const {'1': 'UserFeild_Email', '2': 6},
    const {'1': 'UserFeild_Extend', '2': 7},
    const {'1': 'UserFeild_AllowType', '2': 8},
    const {'1': 'UserFeild_Province', '2': 9},
    const {'1': 'UserFeild_City', '2': 10},
    const {'1': 'UserFeild_Area', '2': 11},
    const {'1': 'UserFeild_Address', '2': 12},
    const {'1': 'UserFeild_IdentityCard', '2': 13},
  ],
};

/// Descriptor for `UserFeild`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List userFeildDescriptor = $convert.base64Decode('CglVc2VyRmVpbGQSFwoTVXNlckZlaWxkX1VuZGVmaW5lZBAAEhIKDlVzZXJGZWlsZF9OaWNrEAESFAoQVXNlckZlaWxkX0dlbmRlchACEhQKEFVzZXJGZWlsZF9BdmF0YXIQAxITCg9Vc2VyRmVpbGRfTGFiZWwQBBIWChJVc2VyRmVpbGRfVHJ1ZU5hbWUQBRITCg9Vc2VyRmVpbGRfRW1haWwQBhIUChBVc2VyRmVpbGRfRXh0ZW5kEAcSFwoTVXNlckZlaWxkX0FsbG93VHlwZRAIEhYKElVzZXJGZWlsZF9Qcm92aW5jZRAJEhIKDlVzZXJGZWlsZF9DaXR5EAoSEgoOVXNlckZlaWxkX0FyZWEQCxIVChFVc2VyRmVpbGRfQWRkcmVzcxAMEhoKFlVzZXJGZWlsZF9JZGVudGl0eUNhcmQQDQ==');
