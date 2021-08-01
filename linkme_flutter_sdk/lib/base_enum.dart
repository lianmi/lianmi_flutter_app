/// @nodoc
enum UserTypeEnum {
  /// @nodoc 未知 0
  UserTypeEnum_Undefined,

  /// @nodoc 一般用户 1
  UserTypeEnum_Normal,

  /// @nodoc 商户 2
  UserTypeEnum_Business,
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
