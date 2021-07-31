///
/// @ProjectName:    linkme_flutter_sdk
/// @Package:
/// @ClassName:      base_enum
/// @Description:    基础枚举
/// @Author:         wujehy
/// @Time:     21-1-23 下午10:13
///

/// @nodoc
enum UserTypeEnum {
  /// @nodoc 未知 0
  UserTypeEnum_Undefined,

  /// @nodoc 一般用户 1
  UserTypeEnum_Normal,

  /// @nodoc 商户 2
  UserTypeEnum_Business,

  /// @nodoc 公证处 3
  UserTypeEnum_NotaryService,
}

enum NetworkStatusEnum {
  Network_SUCCESS,
  Network_Close,
  Network_Unknow,
}

enum BusinessTypeEnum {
  Undefined,
  BT_Users,
  BT_Auth,
  BT_Friends,
  BT_Teams,
  BT_Messages,
  BT_Sync,
  BT_Product,
  BT_Broadcast,
  BT_Order,
  BT_Wallet,
  BT_Log,
}

enum OpAuthSubType {
  Undefined,
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
}
enum OpUsersSubTypeEnum {
  Undefined,
  GetUsers,
  UpdateUserProfile,
  SyncUserProfileEvent,
  SyncUpdateProfileEvent,
  MarkTag,
  SyncMarkTagEvent,
  SyncTagsEvent,
  NotaryServiceUploadPublickey,
}

enum OpWalletSubType {
  WST_undefined,
  RegisterWallet,
  Deposit,
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
}

enum OpOrderSubType {
  Undefined,
  RegisterPreKeys,
  GetPreKeyOrderID,
  NULL_3,
  OrderStateEvent,
  ChangeOrderState,
  GetPreKeysCount,
  NULL_7,
  NULL_8,
  NULL_9,
  OPKLimitAlert,
  PayOrder,
  OrderPayDoneEvent, //取消
  UploadOrderBodyEvent, //买家将订单body加密发送给第三方公证
  GetNotaryServicePublickey, //买家获取商户对应的第三方公证的公钥
}

enum OpProductSubType {
  Undefined,
  QueryProducts,
  AddProduct,
  UpdateProduct,
  SoldoutProduct,
  AddProductEvent,
  UpdateProductEvent,
  SoldoutProductEvent,
  SyncProductEvent,
  SyncGeneralProductsEvent,
}

enum OpSyncSubType {
  Undefined,
  SyncEvent, //1. 同步请求
  SyncDoneEvent, //2. 同步结束事件
}
enum OpMsgSubType {
  Undefined,
  SendMsg, //1.  发送消息
  RecvMsgEvent, //2.  接收消息事件
  SyncOfflineSysMsgsEvent, //3.  同步系统离线消息
  MsgAck, //4.  <已 >删除会话
  SyncSendMsgEvent, //5.  发送消息多终端同步事件
  SendCancelMsg, // 6.  发送撤销消息
  RecvCancelMsgEvent, //7.  接收撤销消息事件
  SyncSendCancelMsgEvent, //8. 主从设备同步发送撤销消息的事
  SyncSystemMsgEvent, //9. 同步系统公告
  SyncUpdateConversationEvent, //10. 取消
  UpdateConversation, //11. 更新会话
  GetOssToken, //12.取消
}

enum OpFriendsSubType {
  Undefined,
  FriendRequest,
  FriendChangeEvent,
  SyncFriendsEvent,
  SyncFriendUsersEvent,
  DeleteFriend,
  UpdateFriend,
  SyncUpdateFriendEvent,
  GetFriends,
  Watching,
  CancelWatching,
  SyncWatchEvent,
}

//team

enum OpTeamsSubType {
  Undefined,
  CreateTeam, //1.  创建群组
  GetTeamMembers, //2.  获取群组成员
  GetTeam, //3.  查询群信息
  InviteTeamMembers, //4.  邀请好友加入群组
  RemoveTeamMembers, //5.  删除群组成员
  AcceptTeamInvite, //6.  接受群邀请
  RejectTeamInvite, //7.  拒绝群邀请
  ApplyTeam, //8.  申请加群
  PassTeamApply, //9.  通过群申请
  RejectTeamApply, //10. 拒绝群申请
  UpdateTeam, //11. 更新群组信息
  DismissTeam, //12. 解散群组
  LeaveTeam, //13. 离开群组
  AddTeamManagers, // 14. 设置群管理员
  RemoveTeamManagers, //15. 取消群管理员
  TransferTeam, //16. 转让群
  SyncMyTeamsEvent, //17. 同步群组事件
  MuteTeam, //18. 修改群禁言模式
  MuteTeamMember, //19. 设置群成员禁言
  SetNotifyType, //20. 修改群组消息通知方式
  UpdateMyInfo, //21. 修改个人群资料
  UpdateMemberInfo, //22. 设置群成员资料
  SyncCreateTeam, //23. 创建群组多终端同步事件
  PullTeamMembers, //24. 根据群成员ID获取群成员信息
  GetMyTeams, //25. 增量群组信息
  CheckTeamInvite, //26. 管理员审核邀请入群
  GetMembersPage, //27. 分页获取群成员信息
}

//日志模块子模块定义
enum OpLogSubType {
  Undefined,
  SendLog, //11-1 日志上报
}
