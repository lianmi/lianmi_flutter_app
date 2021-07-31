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
  static const BusinessType Sync = BusinessType._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Sync');
  static const BusinessType Product = BusinessType._(7, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Product');
  static const BusinessType Broadcast = BusinessType._(8, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Broadcast');
  static const BusinessType Order = BusinessType._(9, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Order');
  static const BusinessType Wallet = BusinessType._(10, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Wallet');
  static const BusinessType Log = BusinessType._(11, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Log');
  static const BusinessType Witness = BusinessType._(12, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Witness');
  static const BusinessType Custom = BusinessType._(99, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Custom');

  static const $core.List<BusinessType> values = <BusinessType> [
    Bt_undefined,
    User,
    Auth,
    Friends,
    Team,
    Msg,
    Sync,
    Product,
    Broadcast,
    Order,
    Wallet,
    Log,
    Witness,
    Custom,
  ];

  static final $core.Map<$core.int, BusinessType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static BusinessType? valueOf($core.int value) => _byValue[value];

  const BusinessType._($core.int v, $core.String n) : super(v, n);
}

class AuthSubType extends $pb.ProtobufEnum {
  static const AuthSubType Ast_undefined = AuthSubType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Ast_undefined');
  static const AuthSubType SignIn = AuthSubType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SignIn');
  static const AuthSubType SignOut = AuthSubType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SignOut');
  static const AuthSubType MultiLoginEvent = AuthSubType._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MultiLoginEvent');
  static const AuthSubType Kick = AuthSubType._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Kick');
  static const AuthSubType KickedEvent = AuthSubType._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'KickedEvent');
  static const AuthSubType AddSlaveDevice = AuthSubType._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'AddSlaveDevice');
  static const AuthSubType AuthorizeCode = AuthSubType._(7, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'AuthorizeCode');
  static const AuthSubType RemoveSlaveDevice = AuthSubType._(8, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RemoveSlaveDevice');
  static const AuthSubType SlaveDeviceAuthEvent = AuthSubType._(9, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SlaveDeviceAuthEvent');
  static const AuthSubType GetAllDevices = AuthSubType._(10, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GetAllDevices');

  static const $core.List<AuthSubType> values = <AuthSubType> [
    Ast_undefined,
    SignIn,
    SignOut,
    MultiLoginEvent,
    Kick,
    KickedEvent,
    AddSlaveDevice,
    AuthorizeCode,
    RemoveSlaveDevice,
    SlaveDeviceAuthEvent,
    GetAllDevices,
  ];

  static final $core.Map<$core.int, AuthSubType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static AuthSubType? valueOf($core.int value) => _byValue[value];

  const AuthSubType._($core.int v, $core.String n) : super(v, n);
}

class UserSubType extends $pb.ProtobufEnum {
  static const UserSubType Ust_undefined = UserSubType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Ust_undefined');
  static const UserSubType GetUsers = UserSubType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GetUsers');
  static const UserSubType UpdateUserProfile = UserSubType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'UpdateUserProfile');
  static const UserSubType SyncUserProfileEvent = UserSubType._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SyncUserProfileEvent');
  static const UserSubType SyncUpdateProfileEvent = UserSubType._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SyncUpdateProfileEvent');
  static const UserSubType MarkTag = UserSubType._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MarkTag');
  static const UserSubType SyncMarkTagEvent = UserSubType._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SyncMarkTagEvent');
  static const UserSubType SyncTagsEvent = UserSubType._(7, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SyncTagsEvent');
  static const UserSubType NotaryServiceUploadPublickey = UserSubType._(8, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'NotaryServiceUploadPublickey');

  static const $core.List<UserSubType> values = <UserSubType> [
    Ust_undefined,
    GetUsers,
    UpdateUserProfile,
    SyncUserProfileEvent,
    SyncUpdateProfileEvent,
    MarkTag,
    SyncMarkTagEvent,
    SyncTagsEvent,
    NotaryServiceUploadPublickey,
  ];

  static final $core.Map<$core.int, UserSubType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static UserSubType? valueOf($core.int value) => _byValue[value];

  const UserSubType._($core.int v, $core.String n) : super(v, n);
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

class SyncSubType extends $pb.ProtobufEnum {
  static const SyncSubType Syn_undefined = SyncSubType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Syn_undefined');
  static const SyncSubType SyncEvent = SyncSubType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SyncEvent');
  static const SyncSubType SyncDoneEvent = SyncSubType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SyncDoneEvent');

  static const $core.List<SyncSubType> values = <SyncSubType> [
    Syn_undefined,
    SyncEvent,
    SyncDoneEvent,
  ];

  static final $core.Map<$core.int, SyncSubType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static SyncSubType? valueOf($core.int value) => _byValue[value];

  const SyncSubType._($core.int v, $core.String n) : super(v, n);
}

class ProductSubType extends $pb.ProtobufEnum {
  static const ProductSubType PST_undefined = ProductSubType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PST_undefined');
  static const ProductSubType QueryProducts = ProductSubType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'QueryProducts');
  static const ProductSubType AddProduct = ProductSubType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'AddProduct');
  static const ProductSubType UpdateProduct = ProductSubType._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'UpdateProduct');
  static const ProductSubType SoldoutProduct = ProductSubType._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SoldoutProduct');
  static const ProductSubType AddProductEvent = ProductSubType._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'AddProductEvent');
  static const ProductSubType UpdateProductEvent = ProductSubType._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'UpdateProductEvent');
  static const ProductSubType SoldoutProductEvent = ProductSubType._(7, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SoldoutProductEvent');
  static const ProductSubType SyncProductEvent = ProductSubType._(8, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SyncProductEvent');
  static const ProductSubType SyncGeneralProductsEvent = ProductSubType._(9, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SyncGeneralProductsEvent');

  static const $core.List<ProductSubType> values = <ProductSubType> [
    PST_undefined,
    QueryProducts,
    AddProduct,
    UpdateProduct,
    SoldoutProduct,
    AddProductEvent,
    UpdateProductEvent,
    SoldoutProductEvent,
    SyncProductEvent,
    SyncGeneralProductsEvent,
  ];

  static final $core.Map<$core.int, ProductSubType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ProductSubType? valueOf($core.int value) => _byValue[value];

  const ProductSubType._($core.int v, $core.String n) : super(v, n);
}

class OrderSubType extends $pb.ProtobufEnum {
  static const OrderSubType OST_undefined = OrderSubType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OST_undefined');
  static const OrderSubType RegisterPreKeys = OrderSubType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RegisterPreKeys');
  static const OrderSubType GetPreKeyOrderID = OrderSubType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GetPreKeyOrderID');
  static const OrderSubType OrderStateEvent = OrderSubType._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OrderStateEvent');
  static const OrderSubType ChangeOrderState = OrderSubType._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ChangeOrderState');
  static const OrderSubType GetPreKeysCount = OrderSubType._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GetPreKeysCount');
  static const OrderSubType OPKLimitAlert = OrderSubType._(10, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OPKLimitAlert');
  static const OrderSubType PayOrder = OrderSubType._(11, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PayOrder');
  static const OrderSubType UploadOrderBodyEvent = OrderSubType._(13, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'UploadOrderBodyEvent');
  static const OrderSubType GetNotaryServicePublickey = OrderSubType._(14, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GetNotaryServicePublickey');

  static const $core.List<OrderSubType> values = <OrderSubType> [
    OST_undefined,
    RegisterPreKeys,
    GetPreKeyOrderID,
    OrderStateEvent,
    ChangeOrderState,
    GetPreKeysCount,
    OPKLimitAlert,
    PayOrder,
    UploadOrderBodyEvent,
    GetNotaryServicePublickey,
  ];

  static final $core.Map<$core.int, OrderSubType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static OrderSubType? valueOf($core.int value) => _byValue[value];

  const OrderSubType._($core.int v, $core.String n) : super(v, n);
}

class WalletSubType extends $pb.ProtobufEnum {
  static const WalletSubType WST_undefined = WalletSubType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'WST_undefined');
  static const WalletSubType RegisterWallet = WalletSubType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RegisterWallet');
  static const WalletSubType PreTransfer = WalletSubType._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PreTransfer');
  static const WalletSubType ConfirmTransfer = WalletSubType._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ConfirmTransfer');
  static const WalletSubType Balance = WalletSubType._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Balance');
  static const WalletSubType PreWithDraw = WalletSubType._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PreWithDraw');
  static const WalletSubType WithDraw = WalletSubType._(7, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'WithDraw');
  static const WalletSubType WithDrawBankCompleteEvent = WalletSubType._(8, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'WithDrawBankCompleteEvent');
  static const WalletSubType SyncCollectionHistory = WalletSubType._(9, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SyncCollectionHistory');
  static const WalletSubType SyncDepositHistory = WalletSubType._(10, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SyncDepositHistory');
  static const WalletSubType SyncWithdrawHistory = WalletSubType._(11, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SyncWithdrawHistory');
  static const WalletSubType SyncTransferHistory = WalletSubType._(12, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SyncTransferHistory');
  static const WalletSubType UserSignIn = WalletSubType._(13, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'UserSignIn');
  static const WalletSubType TxHashInfo = WalletSubType._(14, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TxHashInfo');
  static const WalletSubType EthReceivedEvent = WalletSubType._(15, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'EthReceivedEvent');
  static const WalletSubType LNMCReceivedEvent = WalletSubType._(16, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'LNMCReceivedEvent');

  static const $core.List<WalletSubType> values = <WalletSubType> [
    WST_undefined,
    RegisterWallet,
    PreTransfer,
    ConfirmTransfer,
    Balance,
    PreWithDraw,
    WithDraw,
    WithDrawBankCompleteEvent,
    SyncCollectionHistory,
    SyncDepositHistory,
    SyncWithdrawHistory,
    SyncTransferHistory,
    UserSignIn,
    TxHashInfo,
    EthReceivedEvent,
    LNMCReceivedEvent,
  ];

  static final $core.Map<$core.int, WalletSubType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static WalletSubType? valueOf($core.int value) => _byValue[value];

  const WalletSubType._($core.int v, $core.String n) : super(v, n);
}

class WitnessSubType extends $pb.ProtobufEnum {
  static const WitnessSubType WIT_undefined = WitnessSubType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'WIT_undefined');
  static const WitnessSubType UpChain = WitnessSubType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'UpChain');
  static const WitnessSubType UpChainDone = WitnessSubType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'UpChainDone');
  static const WitnessSubType ClaimPrize = WitnessSubType._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ClaimPrize');
  static const WitnessSubType ClaimPrizeDone = WitnessSubType._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ClaimPrizeDone');

  static const $core.List<WitnessSubType> values = <WitnessSubType> [
    WIT_undefined,
    UpChain,
    UpChainDone,
    ClaimPrize,
    ClaimPrizeDone,
  ];

  static final $core.Map<$core.int, WitnessSubType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static WitnessSubType? valueOf($core.int value) => _byValue[value];

  const WitnessSubType._($core.int v, $core.String n) : super(v, n);
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

class LotteryType extends $pb.ProtobufEnum {
  static const LotteryType LT_Undefined = LotteryType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'LT_Undefined');
  static const LotteryType LT_Shuangseqiu = LotteryType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'LT_Shuangseqiu');
  static const LotteryType LT_Daletou = LotteryType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'LT_Daletou');
  static const LotteryType LT_Fucai3d = LotteryType._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'LT_Fucai3d');

  static const $core.List<LotteryType> values = <LotteryType> [
    LT_Undefined,
    LT_Shuangseqiu,
    LT_Daletou,
    LT_Fucai3d,
  ];

  static final $core.Map<$core.int, LotteryType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static LotteryType? valueOf($core.int value) => _byValue[value];

  const LotteryType._($core.int v, $core.String n) : super(v, n);
}

class ThirdPartyPaymentType extends $pb.ProtobufEnum {
  static const ThirdPartyPaymentType TPPT_Undefined = ThirdPartyPaymentType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TPPT_Undefined');
  static const ThirdPartyPaymentType TPPT_AliPay = ThirdPartyPaymentType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TPPT_AliPay');
  static const ThirdPartyPaymentType TPPT_WeChatPay = ThirdPartyPaymentType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TPPT_WeChatPay');

  static const $core.List<ThirdPartyPaymentType> values = <ThirdPartyPaymentType> [
    TPPT_Undefined,
    TPPT_AliPay,
    TPPT_WeChatPay,
  ];

  static final $core.Map<$core.int, ThirdPartyPaymentType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ThirdPartyPaymentType? valueOf($core.int value) => _byValue[value];

  const ThirdPartyPaymentType._($core.int v, $core.String n) : super(v, n);
}

class DepositRecharge extends $pb.ProtobufEnum {
  static const DepositRecharge DR_Undefined = DepositRecharge._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DR_Undefined');
  static const DepositRecharge DR_10 = DepositRecharge._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DR_10');
  static const DepositRecharge DR_100 = DepositRecharge._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DR_100');

  static const $core.List<DepositRecharge> values = <DepositRecharge> [
    DR_Undefined,
    DR_10,
    DR_100,
  ];

  static final $core.Map<$core.int, DepositRecharge> _byValue = $pb.ProtobufEnum.initByValue(values);
  static DepositRecharge? valueOf($core.int value) => _byValue[value];

  const DepositRecharge._($core.int v, $core.String n) : super(v, n);
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

class AllowType extends $pb.ProtobufEnum {
  static const AllowType UAT_Unknow = AllowType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'UAT_Unknow');
  static const AllowType UAT_AllowAny = AllowType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'UAT_AllowAny');
  static const AllowType UAT_DenyAny = AllowType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'UAT_DenyAny');
  static const AllowType UAT_NeedConfirm = AllowType._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'UAT_NeedConfirm');

  static const $core.List<AllowType> values = <AllowType> [
    UAT_Unknow,
    UAT_AllowAny,
    UAT_DenyAny,
    UAT_NeedConfirm,
  ];

  static final $core.Map<$core.int, AllowType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static AllowType? valueOf($core.int value) => _byValue[value];

  const AllowType._($core.int v, $core.String n) : super(v, n);
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

