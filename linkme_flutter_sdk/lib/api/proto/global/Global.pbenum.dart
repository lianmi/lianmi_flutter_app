///
//  Generated code. Do not modify.
//  source: api/proto/global/Global.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class BusinessType extends $pb.ProtobufEnum {
  static const BusinessType Bt_undefined = BusinessType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Bt_undefined');
  static const BusinessType User = BusinessType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'User');
  static const BusinessType Auth = BusinessType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Auth');
  static const BusinessType Friends = BusinessType._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Friends');
  static const BusinessType Team = BusinessType._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Team');
  static const BusinessType Msg = BusinessType._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Msg');

  static const $core.List<BusinessType> values = <BusinessType> [
    Bt_undefined,
    User,
    Auth,
    Friends,
    Team,
    Msg,
  ];

  static final $core.Map<$core.int, BusinessType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static BusinessType? valueOf($core.int value) => _byValue[value];

  const BusinessType._($core.int v, $core.String n) : super(v, n);
}

class MsgSubType extends $pb.ProtobufEnum {
  static const MsgSubType Cst_undefined = MsgSubType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Cst_undefined');
  static const MsgSubType SendMsg = MsgSubType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SendMsg');
  static const MsgSubType RecvMsgEvent = MsgSubType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RecvMsgEvent');
  static const MsgSubType SyncOfflineSysMsgsEvent = MsgSubType._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SyncOfflineSysMsgsEvent');
  static const MsgSubType SyncSendMsgEvent = MsgSubType._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SyncSendMsgEvent');
  static const MsgSubType SendCancelMsg = MsgSubType._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SendCancelMsg');
  static const MsgSubType RecvCancelMsgEvent = MsgSubType._(7, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RecvCancelMsgEvent');
  static const MsgSubType SyncSendCancelMsgEvent = MsgSubType._(8, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SyncSendCancelMsgEvent');
  static const MsgSubType SyncSystemMsgEvent = MsgSubType._(9, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SyncSystemMsgEvent');
  static const MsgSubType MsgAck = MsgSubType._(10, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MsgAck');
  static const MsgSubType UpdateConversation = MsgSubType._(11, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'UpdateConversation');

  static const $core.List<MsgSubType> values = <MsgSubType> [
    Cst_undefined,
    SendMsg,
    RecvMsgEvent,
    SyncOfflineSysMsgsEvent,
    SyncSendMsgEvent,
    SendCancelMsg,
    RecvCancelMsgEvent,
    SyncSendCancelMsgEvent,
    SyncSystemMsgEvent,
    MsgAck,
    UpdateConversation,
  ];

  static final $core.Map<$core.int, MsgSubType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static MsgSubType? valueOf($core.int value) => _byValue[value];

  const MsgSubType._($core.int v, $core.String n) : super(v, n);
}

class OrderState extends $pb.ProtobufEnum {
  static const OrderState OS_Undefined = OrderState._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OS_Undefined');
  static const OrderState OS_Prepare = OrderState._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OS_Prepare');
  static const OrderState OS_SendOK = OrderState._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OS_SendOK');
  static const OrderState OS_RecvOK = OrderState._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OS_RecvOK');
  static const OrderState OS_Taked = OrderState._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OS_Taked');
  static const OrderState OS_Done = OrderState._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OS_Done');
  static const OrderState OS_Cancel = OrderState._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OS_Cancel');
  static const OrderState OS_Processing = OrderState._(7, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OS_Processing');
  static const OrderState OS_Confirm = OrderState._(8, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OS_Confirm');
  static const OrderState OS_ApplyCancel = OrderState._(9, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OS_ApplyCancel');
  static const OrderState OS_AttachChange = OrderState._(10, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OS_AttachChange');
  static const OrderState OS_Paying = OrderState._(11, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OS_Paying');
  static const OrderState OS_Overdue = OrderState._(12, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OS_Overdue');
  static const OrderState OS_Refuse = OrderState._(13, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OS_Refuse');
  static const OrderState OS_IsPayed = OrderState._(14, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OS_IsPayed');
  static const OrderState OS_Urge = OrderState._(15, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OS_Urge');
  static const OrderState OS_Expedited = OrderState._(16, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OS_Expedited');
  static const OrderState OS_UpChained = OrderState._(17, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OS_UpChained');
  static const OrderState OS_Prizeed = OrderState._(18, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OS_Prizeed');
  static const OrderState OS_AcceptPrizeed = OrderState._(19, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OS_AcceptPrizeed');

  static const $core.List<OrderState> values = <OrderState> [
    OS_Undefined,
    OS_Prepare,
    OS_SendOK,
    OS_RecvOK,
    OS_Taked,
    OS_Done,
    OS_Cancel,
    OS_Processing,
    OS_Confirm,
    OS_ApplyCancel,
    OS_AttachChange,
    OS_Paying,
    OS_Overdue,
    OS_Refuse,
    OS_IsPayed,
    OS_Urge,
    OS_Expedited,
    OS_UpChained,
    OS_Prizeed,
    OS_AcceptPrizeed,
  ];

  static final $core.Map<$core.int, OrderState> _byValue = $pb.ProtobufEnum.initByValue(values);
  static OrderState? valueOf($core.int value) => _byValue[value];

  const OrderState._($core.int v, $core.String n) : super(v, n);
}

class StoreType extends $pb.ProtobufEnum {
  static const StoreType ST_Undefined = StoreType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ST_Undefined');
  static const StoreType ST_Fuli = StoreType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ST_Fuli');
  static const StoreType ST_Tiyu = StoreType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ST_Tiyu');

  static const $core.List<StoreType> values = <StoreType> [
    ST_Undefined,
    ST_Fuli,
    ST_Tiyu,
  ];

  static final $core.Map<$core.int, StoreType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static StoreType? valueOf($core.int value) => _byValue[value];

  const StoreType._($core.int v, $core.String n) : super(v, n);
}

class ProductType extends $pb.ProtobufEnum {
  static const ProductType OT_Undefined = ProductType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OT_Undefined');
  static const ProductType OT_FuliLottery = ProductType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OT_FuliLottery');
  static const ProductType OT_TiyuLottery = ProductType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OT_TiyuLottery');

  static const $core.List<ProductType> values = <ProductType> [
    OT_Undefined,
    OT_FuliLottery,
    OT_TiyuLottery,
  ];

  static final $core.Map<$core.int, ProductType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ProductType? valueOf($core.int value) => _byValue[value];

  const ProductType._($core.int v, $core.String n) : super(v, n);
}

class Gender extends $pb.ProtobufEnum {
  static const Gender Sex_Unknown = Gender._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Sex_Unknown');
  static const Gender Sex_Male = Gender._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Sex_Male');
  static const Gender Sex_Female = Gender._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Sex_Female');

  static const $core.List<Gender> values = <Gender> [
    Sex_Unknown,
    Sex_Male,
    Sex_Female,
  ];

  static final $core.Map<$core.int, Gender> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Gender? valueOf($core.int value) => _byValue[value];

  const Gender._($core.int v, $core.String n) : super(v, n);
}

class UserType extends $pb.ProtobufEnum {
  static const UserType Ut_Undefined = UserType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Ut_Undefined');
  static const UserType Ut_Normal = UserType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Ut_Normal');
  static const UserType Ut_Business = UserType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Ut_Business');
  static const UserType Ut_Operator = UserType._(10086, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Ut_Operator');

  static const $core.List<UserType> values = <UserType> [
    Ut_Undefined,
    Ut_Normal,
    Ut_Business,
    Ut_Operator,
  ];

  static final $core.Map<$core.int, UserType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static UserType? valueOf($core.int value) => _byValue[value];

  const UserType._($core.int v, $core.String n) : super(v, n);
}

class UserState extends $pb.ProtobufEnum {
  static const UserState Ss_Normal = UserState._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Ss_Normal');
  static const UserState Ss_Vip = UserState._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Ss_Vip');
  static const UserState Ss_Blocked = UserState._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Ss_Blocked');

  static const $core.List<UserState> values = <UserState> [
    Ss_Normal,
    Ss_Vip,
    Ss_Blocked,
  ];

  static final $core.Map<$core.int, UserState> _byValue = $pb.ProtobufEnum.initByValue(values);
  static UserState? valueOf($core.int value) => _byValue[value];

  const UserState._($core.int v, $core.String n) : super(v, n);
}

class UserFeild extends $pb.ProtobufEnum {
  static const UserFeild UserFeild_Undefined = UserFeild._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'UserFeild_Undefined');
  static const UserFeild UserFeild_Nick = UserFeild._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'UserFeild_Nick');
  static const UserFeild UserFeild_Gender = UserFeild._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'UserFeild_Gender');
  static const UserFeild UserFeild_Avatar = UserFeild._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'UserFeild_Avatar');
  static const UserFeild UserFeild_Label = UserFeild._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'UserFeild_Label');
  static const UserFeild UserFeild_TrueName = UserFeild._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'UserFeild_TrueName');
  static const UserFeild UserFeild_Email = UserFeild._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'UserFeild_Email');
  static const UserFeild UserFeild_Extend = UserFeild._(7, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'UserFeild_Extend');
  static const UserFeild UserFeild_AllowType = UserFeild._(8, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'UserFeild_AllowType');
  static const UserFeild UserFeild_Province = UserFeild._(9, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'UserFeild_Province');
  static const UserFeild UserFeild_City = UserFeild._(10, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'UserFeild_City');
  static const UserFeild UserFeild_Area = UserFeild._(11, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'UserFeild_Area');
  static const UserFeild UserFeild_Address = UserFeild._(12, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'UserFeild_Address');
  static const UserFeild UserFeild_IdentityCard = UserFeild._(13, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'UserFeild_IdentityCard');

  static const $core.List<UserFeild> values = <UserFeild> [
    UserFeild_Undefined,
    UserFeild_Nick,
    UserFeild_Gender,
    UserFeild_Avatar,
    UserFeild_Label,
    UserFeild_TrueName,
    UserFeild_Email,
    UserFeild_Extend,
    UserFeild_AllowType,
    UserFeild_Province,
    UserFeild_City,
    UserFeild_Area,
    UserFeild_Address,
    UserFeild_IdentityCard,
  ];

  static final $core.Map<$core.int, UserFeild> _byValue = $pb.ProtobufEnum.initByValue(values);
  static UserFeild? valueOf($core.int value) => _byValue[value];

  const UserFeild._($core.int v, $core.String n) : super(v, n);
}

