///
//  Generated code. Do not modify.
//  source: api/proto/msg/MsgTypeEnum.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class MessageScene extends $pb.ProtobufEnum {
  static const MessageScene MsgScene_Undefined = MessageScene._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MsgScene_Undefined');
  static const MessageScene MsgScene_C2C = MessageScene._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MsgScene_C2C');
  static const MessageScene MsgScene_C2G = MessageScene._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MsgScene_C2G');
  static const MessageScene MsgScene_S2C = MessageScene._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MsgScene_S2C');
  static const MessageScene MsgScene_ChatRoom = MessageScene._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MsgScene_ChatRoom');
  static const MessageScene MsgScene_P2P = MessageScene._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MsgScene_P2P');

  static const $core.List<MessageScene> values = <MessageScene> [
    MsgScene_Undefined,
    MsgScene_C2C,
    MsgScene_C2G,
    MsgScene_S2C,
    MsgScene_ChatRoom,
    MsgScene_P2P,
  ];

  static final $core.Map<$core.int, MessageScene> _byValue = $pb.ProtobufEnum.initByValue(values);
  static MessageScene? valueOf($core.int value) => _byValue[value];

  const MessageScene._($core.int v, $core.String n) : super(v, n);
}

class MessageType extends $pb.ProtobufEnum {
  static const MessageType MsgType_Undefined = MessageType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MsgType_Undefined');
  static const MessageType MsgType_Text = MessageType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MsgType_Text');
  static const MessageType MsgType_Attach = MessageType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MsgType_Attach');
  static const MessageType MsgType_Notification = MessageType._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MsgType_Notification');
  static const MessageType MsgType_Secret = MessageType._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MsgType_Secret');
  static const MessageType MsgType_Bin = MessageType._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MsgType_Bin');
  static const MessageType MsgType_Order = MessageType._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MsgType_Order');
  static const MessageType MsgType_SysMsgUpdate = MessageType._(7, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MsgType_SysMsgUpdate');
  static const MessageType MsgType_Roof = MessageType._(8, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MsgType_Roof');
  static const MessageType MSgType_Customer = MessageType._(100, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MSgType_Customer');

  static const $core.List<MessageType> values = <MessageType> [
    MsgType_Undefined,
    MsgType_Text,
    MsgType_Attach,
    MsgType_Notification,
    MsgType_Secret,
    MsgType_Bin,
    MsgType_Order,
    MsgType_SysMsgUpdate,
    MsgType_Roof,
    MSgType_Customer,
  ];

  static final $core.Map<$core.int, MessageType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static MessageType? valueOf($core.int value) => _byValue[value];

  const MessageType._($core.int v, $core.String n) : super(v, n);
}

class AttachType extends $pb.ProtobufEnum {
  static const AttachType AttachType_Undefined = AttachType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'AttachType_Undefined');
  static const AttachType AttachType_Image = AttachType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'AttachType_Image');
  static const AttachType AttachType_Audio = AttachType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'AttachType_Audio');
  static const AttachType AttachType_Video = AttachType._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'AttachType_Video');
  static const AttachType AttachType_File = AttachType._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'AttachType_File');
  static const AttachType AttachType_Geo = AttachType._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'AttachType_Geo');
  static const AttachType AttachType_Order = AttachType._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'AttachType_Order');
  static const AttachType AttachType_Transaction = AttachType._(7, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'AttachType_Transaction');
  static const AttachType AttachType_BlockServiceCharge = AttachType._(8, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'AttachType_BlockServiceCharge');
  static const AttachType AttachType_VipPrice = AttachType._(9, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'AttachType_VipPrice');
  static const AttachType AttachType_CustomAttach = AttachType._(10, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'AttachType_CustomAttach');

  static const $core.List<AttachType> values = <AttachType> [
    AttachType_Undefined,
    AttachType_Image,
    AttachType_Audio,
    AttachType_Video,
    AttachType_File,
    AttachType_Geo,
    AttachType_Order,
    AttachType_Transaction,
    AttachType_BlockServiceCharge,
    AttachType_VipPrice,
    AttachType_CustomAttach,
  ];

  static final $core.Map<$core.int, AttachType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static AttachType? valueOf($core.int value) => _byValue[value];

  const AttachType._($core.int v, $core.String n) : super(v, n);
}

class MessageOrderEventType extends $pb.ProtobufEnum {
  static const MessageOrderEventType MOET_UNDEFINE = MessageOrderEventType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MOET_UNDEFINE');
  static const MessageOrderEventType MOET_MakeOrder = MessageOrderEventType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MOET_MakeOrder');
  static const MessageOrderEventType MOET_ReceiveOrderr = MessageOrderEventType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MOET_ReceiveOrderr');
  static const MessageOrderEventType MOET_CancelOrder = MessageOrderEventType._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MOET_CancelOrder');
  static const MessageOrderEventType MOET_ReceiveCancelOrder = MessageOrderEventType._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MOET_ReceiveCancelOrder');
  static const MessageOrderEventType MOET_Deposit = MessageOrderEventType._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MOET_Deposit');
  static const MessageOrderEventType MOET_WithDraw = MessageOrderEventType._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MOET_WithDraw');
  static const MessageOrderEventType MOET_OTCBuy = MessageOrderEventType._(7, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MOET_OTCBuy');
  static const MessageOrderEventType MOET_OTCSell = MessageOrderEventType._(8, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MOET_OTCSell');
  static const MessageOrderEventType MOET_AddProduct = MessageOrderEventType._(9, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MOET_AddProduct');
  static const MessageOrderEventType MOET_DeleteProduct = MessageOrderEventType._(10, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MOET_DeleteProduct');

  static const $core.List<MessageOrderEventType> values = <MessageOrderEventType> [
    MOET_UNDEFINE,
    MOET_MakeOrder,
    MOET_ReceiveOrderr,
    MOET_CancelOrder,
    MOET_ReceiveCancelOrder,
    MOET_Deposit,
    MOET_WithDraw,
    MOET_OTCBuy,
    MOET_OTCSell,
    MOET_AddProduct,
    MOET_DeleteProduct,
  ];

  static final $core.Map<$core.int, MessageOrderEventType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static MessageOrderEventType? valueOf($core.int value) => _byValue[value];

  const MessageOrderEventType._($core.int v, $core.String n) : super(v, n);
}

class MessageStatus extends $pb.ProtobufEnum {
  static const MessageStatus MOS_UDEFINE = MessageStatus._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MOS_UDEFINE');
  static const MessageStatus MOS_Init = MessageStatus._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MOS_Init');
  static const MessageStatus MOS_Declined = MessageStatus._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MOS_Declined');
  static const MessageStatus MOS_Expired = MessageStatus._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MOS_Expired');
  static const MessageStatus MOS_Ignored = MessageStatus._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MOS_Ignored');
  static const MessageStatus MOS_Passed = MessageStatus._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MOS_Passed');
  static const MessageStatus MOS_Taked = MessageStatus._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MOS_Taked');
  static const MessageStatus MOS_Done = MessageStatus._(7, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MOS_Done');
  static const MessageStatus MOS_Cancel = MessageStatus._(8, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MOS_Cancel');
  static const MessageStatus MOS_Processing = MessageStatus._(9, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MOS_Processing');

  static const $core.List<MessageStatus> values = <MessageStatus> [
    MOS_UDEFINE,
    MOS_Init,
    MOS_Declined,
    MOS_Expired,
    MOS_Ignored,
    MOS_Passed,
    MOS_Taked,
    MOS_Done,
    MOS_Cancel,
    MOS_Processing,
  ];

  static final $core.Map<$core.int, MessageStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static MessageStatus? valueOf($core.int value) => _byValue[value];

  const MessageStatus._($core.int v, $core.String n) : super(v, n);
}

class MessageSecretType extends $pb.ProtobufEnum {
  static const MessageSecretType MST_UNDEFINE = MessageSecretType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MST_UNDEFINE');
  static const MessageSecretType MST_PRE_KRY = MessageSecretType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MST_PRE_KRY');
  static const MessageSecretType MST_MESSAGE = MessageSecretType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MST_MESSAGE');

  static const $core.List<MessageSecretType> values = <MessageSecretType> [
    MST_UNDEFINE,
    MST_PRE_KRY,
    MST_MESSAGE,
  ];

  static final $core.Map<$core.int, MessageSecretType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static MessageSecretType? valueOf($core.int value) => _byValue[value];

  const MessageSecretType._($core.int v, $core.String n) : super(v, n);
}

