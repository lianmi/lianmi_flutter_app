// export 'package:linkme_flutter_sdk/base_type.dart';

enum LoginType {
  LoginType_Undefined,
  LoginType_Username, //用户名登录
  LoginType_Mobile, //手机号登录
  LoginType_WeChat, //微信登录
}

/// @nodoc  定义性别
enum GenderEnum {
  /// @nodoc   未知
  GenderUnknow,

  /// @nodoc   男性
  GenderMale,

  /// @nodoc 女性
  GenderFemale,
}

/// @nodoc
enum AttachTypeEnum {
  /// @nodoc 未知 0
  ATE_Undefined,

  //   图片 （1）
  ATE_Image,

  //Audio(2) - 音频文件
  ATE_Audio,

  //Video(3) - 视频文件
  ATE_Video,

  //File(4) - 文件
  ATE_File,

  // 地理位置 (5)
  ATE_Geo,

  // 订单数据  (6)
  ATE_Order,

  //钱包相关的交易数据(提现，充值 ，转账，收款 ，退款等) (7)
  ATE_Transaction,

  //上链服务费(8)
  ATE_BlockServiceCharge,

  //Vip会员费 (9)
  ATE_VipPrice,

  //自定义带附件（json）的消息 (10)
  ATE_CustomAttach,
}

/// @nodoc 1-2 修改用户资料 的map的键值类型, 不能用此来修改商户的资料
enum UserFeildEnum {
  /// @nodoc 未定义
  UserFeildEnum_Undefined, //0

  /// @nodoc 昵称
  UserFeildEnum_Nick, //1

  /// @nodoc 性别
  UserFeildEnum_Gender, //2

  /// @nodoc  头像
  UserFeildEnum_Avatar, //3

  /// @nodoc 签名
  UserFeildEnum_Label, //4

  /// @nodoc 实名
  UserFeildEnum_TrueName, //5

  /// @nodoc  email
  UserFeildEnum_Email, //6

  /// @nodoc  扩展信息
  UserFeildEnum_Extend, //7

  /// @nodoc 添加好友验证方式
  UserFeildEnum_AllowType, //8

  /// @nodoc 省份
  UserFeildEnum_Province, //9

  /// @nodoc 城市
  UserFeildEnum_City, //10

  /// @nodoc  区
  UserFeildEnum_Area, //11

  /// @nodoc  地址
  UserFeildEnum_Address, //12

  /// @nodoc 身份证
  UserFeildEnum_IdentityCard, //13
}

/// @nodoc 1-2 修改商户资料的map的键值类型
enum StoreFeildEnum {
  /// @nodoc 未定义
  StoreFeildEnum_Undefined, //0

  /// @nodoc 商户名称
  StoreFeildEnum_BranchesName, //1

  /// @nodoc 形象图片
  StoreFeildEnum_ImageUrl, //2

  /// @nodoc 简介
  StoreFeildEnum_Introductory, //3

  /// @nodoc 省份
  StoreFeildEnum_Province, //4

  /// @nodoc 城市
  StoreFeildEnum_City, //5

  /// @nodoc  区
  StoreFeildEnum_Area, //6

  /// @nodoc  地址
  StoreFeildEnum_Address, //7

  /// @nodoc 关键字
  StoreFeildEnum_Keys, //8

  /// @nodoc 联系电话
  StoreFeildEnum_ContactMobile, //9

  /// @nodoc 微信
  StoreFeildEnum_Wechat, //10

  /// @nodoc 网点编码
  StoreFeildEnum_BusinessCode, //11

  /// @nodoc 经度
  StoreFeildEnum_Longitude, //12

  /// @nodoc 纬度
  StoreFeildEnum_Latitude, //13

  /// @nodoc 营业时间
  StoreFeildEnum_OpeningHours, //14
}

/// @nodoc
enum MarkTagTypeEnum {
  /// @nodoc 未定义
  MarkTag_Undefined,

  /// @nodoc 黑名单
  MarkTag_Blocked,

  /// @nodoc 免打扰
  MarkTag_Muted,

  /// @nodoc  置顶
  MarkTag_Sticky,
}

/// @nodoc
enum FriendFieldEnum {
  /// @nodoc 未定义
  FriendField_Undefined,

  /// @nodoc 好友昵称或备注名
  FriendField_Alias,

  /// @nodoc 扩展字段
  FriendField_Ex,
}

/// @nodoc 好友请求发起类型枚举
enum FriendChangeTypeEnum {
  /// @nodoc 未定义
  ChangeType_Undefined,

  /// @nodoc 发起好友验证
  ChangeType_ApplyFriend,

  /// @nodoc 对方同意加你为好友
  ChangeType_PassFriendApply,

  /// @nodoc  对方拒绝添加好友
  ChangeType_RejectFriendApply,

  /// @nodoc 被删除好友
  ChangeType_DeleteFriend,
}

/// @nodoc 好友申请状态枚举
enum FriendStatusTypeEnum {
  /// @nodoc 未定义
  StatusType_Undefined,

  /// @nodoc 添加好友成功
  StatusType_ApplySucceed,

  /// @nodoc 等待对方同意加你为好友
  StatusType_WaitConfirm,

  /// @nodoc 对方拒绝你的添加好友请求
  StatusType_RejectFriendApply,
}

/// @nodoc 系统通知处理
enum MessageNotificationTypeEnum {
  /// @nodoc 未定义
  MNT_Undefined,

  /// @nodoc 好友同意加好友
  MNT_ApplySucceed,

  /// @nodoc 等待对方确认
  MNT_WaitConfirm,

  /// @nodoc 对方拒绝加好友
  MNT_RejectFriendApply,

  /// @nodoc 申请加群请求
  MNT_ApplyJoinTeam,

  /// @nodoc 管理员同意加群申请
  MNT_PassTeamApply,

  /// @nodoc 管理员拒绝加群申请
  MNT_RejectTeamApply,

  /// @nodoc 邀请加群
  MNT_TeamInvite,

  /// @nodoc 用户同意群邀请
  MNT_PassTeamInvite,

  /// @nodoc 用户拒绝群邀请
  MNT_RejectTeamInvite,

  /// @nodoc 群被解散
  MNT_DismissTeam,

  /// @nodoc 被管理员踢出群
  MNT_KickOffTeam,

  /// @nodoc 退群
  MNT_QuitTeam,

  /// @nodoc 设置管理员
  MNT_GrantManager,

  /// @nodoc  取消管理员
  MNT_CancelManager,

  /// @nodoc  群已被回收
  MNT_RevokeTeam,

  /// @nodoc  转让群
  MNT_TransferTeam,

  /// @nodoc 更新群资料
  MNT_UpdateTeam,

  /// @nodoc 群成员禁言/解禁
  MNT_MuteTeamMember,

  /// @nodoc 设置群组禁言模式
  MNT_MuteTeam,

  /// @nodoc 管理员/群主修改群成员信息
  MNT_UpdateTeamMember,

  /// @nodoc 邀请入群前询问管理员是否同意
  MNT_CheckTeamInvite,

  /// @nodoc 群审核通过，成为正常状态，可以加群及拉人
  MNT_Approveteam,

  /// @nodoc 多端同步用户设置其在群里的资料
  MNT_MemberUpdateMyInfo,

  /// @nodoc 多端同步删除好友
  MNT_MultiDeleteFriend,

  /// @nodoc 管理员同意了邀请入群前的询问
  MNT_CheckTeamInvitePass,

  /// @nodoc 管理员拒绝了邀请入群前的询问
  MNT_CheckTeamInviteReject,

  /// @nodoc 有新用户加入群
  MNT_MemberJoined,

  /// @nodoc 商户的OPK存量少于10个告警
  MNT_OPKLimitAlert,

  /// @nodoc 自定义事件消息
  MNT_Customer,
}

//群状态
enum TeamStatusEnum {
  //初始状态,未审核= 0;
  Status_Init,

  //正常状态 = 1;
  Status_Normal,

  //封禁状态 = 2;
  Status_Blocked,

  //解散状态 = 3;
  Status_DisMissed,
}

/// @nodoc 群组类型
enum TeamTypeEnum {
  /// @nodoc 未定义
  TeamType_Undefined,

  /// @nodoc 普通群
  TeamType_Normal,

  /// @nodoc  Vip群
  TeamType_Advanced,
}

/// @nodoc  入群校验方式
enum TeamVerifyTypeEnum {
  /// @nodoc   未定义
  TeamVerifyType_Undefined,

  /// @nodoc   所有人可加入
  TeamVerifyType_Free,

  /// @nodoc  需要审核加入
  TeamVerifyType_Apply,

  /// @nodoc  仅限邀请加入
  TeamVerifyType_Private,
}

/// @nodoc   邀请模式
enum InviteModeEnum {
  /// @nodoc  未定义
  InviteMode_Undefined,

  /// @nodoc 所有人都可以邀请其他人入群
  InviteMode_All,

  /// @nodoc 只有管理员可以邀请其他人入群
  InviteMode_Manager,

  /// @nodoc 邀请用户入群时需要管理员审核
  InviteMode_Check,
}

/// @nodoc  群消息通知方式
enum TeamNotifyTypeEnum {
  /// @nodoc 未定义
  NotifyType_Undefined,

  /// @nodoc 群全部消息提醒
  NotifyType_All,

  /// @nodoc 管理员消息提醒
  NotifyType_Manager,

  /// @nodoc 联系人提醒
  NotifyType_Contact,

  /// @nodoc 全部不提醒
  NotifyType_Mute,
}

/// @nodoc 群成员类型
enum TeamMemberTypeEnum {
  /// @nodoc  未定义
  TeamMemberType_Undefined,

  /// @nodoc 待审核的申请加入用户
  TeamMemberType_Apply,

  /// @nodoc 管理员
  TeamMemberType_Manager,

  /// @nodoc 普通成员
  TeamMemberType_Normal,

  /// @nodoc 创建者
  TeamMemberType_Owner,
}

/// @nodoc
enum TeamFieldEnum {
  /// @nodoc 未定义
  TeamField_Undefined,

  /// @nodoc  Name(1) - 群组名
  TeamField_Nick,

  /// @nodoc  Icon(2) - 群头像
  TeamField_Icon,

  /// @nodoc Announcement(3) - 群公告
  TeamField_Announcement,

  /// @nodoc Introduce(4) - 群简介
  TeamField_Introduce,

  /// @nodoc VerifyType(5) - 入群校验方式
  TeamField_VerifyType,

  /// @nodoc InviteMode(6) - 邀请模式
  TeamField_InviteMode,

  /// @nodoc UpdateTeamMode(7) - 群资料更新方式
  TeamField_UpdateTeamMode,

  /// @nodoc Ex(8) - 群资料扩展信息
  TeamField_Ex,
}

/// @nodoc 禁言类型
enum MuteModeEnum {
  /// @nodoc 未定义
  MuteMode_Undefined,

  /// @nodoc 所有人可发言
  MuteMode_None,

  /// @nodoc 群主可发言,集体禁言
  MuteMode_MuteALL,

  /// @nodoc 群主/管理员可发言,普通成员禁言
  MuteMode_MuteNormal,
}

/// @nodoc
enum TeamMemberFieldEnum {
  /// @nodoc 未定义
  TeamMemberField_Undefined,

  /// @nodoc 昵称
  TeamMemberField_Nick,

  /// @nodoc 扩展字段
  TeamMemberField_Ex,
}

/// @nodoc 订单类型
enum ProductOrderType {
  /// @nodoc 未定义
  POT_UDEFINE,

  /// @nodoc 正常类型
  POT_Normal,

  /// @nodoc 任务抢单类型
  POT_Grabbing,

  /// @nodoc 竞猜类
  POT_Walking,

  /// @nodoc 服务端发起的收费订单
  POT_Server,
}

/// @nodoc
enum OrderStateEnum {
  /// @nodoc
  OS_Undefined, //0

  /// 预审核状态
  OS_Prepare, //1

  /// 订单发送成功
  OS_SendOK, //2

  /// 订单送达成功
  OS_RecvOK, //3

  /// 已接单, 当商家上传彩票金额的收款码后，将订单状态改为这个，服务端推送给用户
  OS_Taked, //4

  /// 完成订单
  OS_Done, //5

  /// 取消订单 撤单
  OS_Cancel, //6

  /// 订单处理中，一般用于商户，安抚下单的
  OS_Processing, //7

  /// 确认收货
  OS_Confirm, //8

  /// 申请撤单
  OS_ApplyCancel, //9

  /// 订单内容发生更改
  OS_AttachChange, //10

  /// 支付中
  OS_Paying, //11

  /// 逾期
  OS_Overdue, //12

  /// 拒单， 跟已接单是相反的操作
  OS_Refuse, //13

  /// 支付， 支付成功
  OS_IsPayed, //14

  /// 催单
  OS_Urge, //15

  /// 加急订单, 订单将会排在首位
  OS_Expedited, //16

  /// 订单上链成功
  OS_UpChained, //17

  /// 商家->用户 发起兑奖动作
  OS_Prizeed, //18

  /// 用户中奖之后，根据中奖金额生成收款码，发送给商家领奖， 商家端付款后，以此动作告知用户
  OS_AcceptPrizeed, //19
}

/// @nodoc 交易类型枚举(钱包资产的收支)：
enum TransactionTypeEnum {
  /// @nodoc proto3必须从0开始
  DT_Undefined,

  /// @nodoc  充值
  DT_Deposit,

  /// @nodoc 提现
  DT_WithDraw,

  /// @nodoc 支付
  DT_Transfer,
// DT_RollIn = 4,     /**< 收款*/
// DT_Refoud = 5,     /**< 退款*/
}

/// @nodoc
enum MessageSceneEnum {
  /// @nodoc
  MsgScene_Undefined,

  /// @nodoc 用户对用户
  MsgScene_C2C,

  /// @nodoc  用户到群
  MsgScene_C2G,

  /// @nodoc 服务端到 用户
  MsgScene_S2C,

  /// @nodoc 透传 点对点 5
  MsgScene_P2P,
}

/// @nodoc
enum MessageTypeEnum {
  /// @nodoc
  MsgType_Undefined,

  /// @nodoc 文本消息
  MsgType_Text,

  /// @nodoc 附件消息
  MsgType_Attach,

  /// @nodoc 系统通知
  MsgType_Notification,

  /// @nodoc 加密
  MsgType_Secret,

  /// @nodoc 二进制
  MsgType_Bin,

  /// @nodoc  普通订单
  MsgType_Order,

  /// @nodoc 系统通知
  MsgType_SysMsgUpdate,

  /// @nodoc 吸顶式群消息,只能是群主或管理员发送，此消息会吸附在群会话的最上面，适合一些倒计时、股价、币价、比分、赔率等
  MSgType_Roof,

  /// @nodoc  手续费
  MSgType_Service,

  // 9
  /// @nodoc 自定义消息
  MSgType_NULL_10,
  MSgType_NULL_11,
  MSgType_NULL_12,
  MSgType_NULL_13,
  MSgType_NULL_14,
  MSgType_NULL_15,
  MSgType_NULL_16,
  MSgType_NULL_17,
  MSgType_NULL_18,
  MSgType_NULL_19,

  MSgType_NULL_20,
  MSgType_NULL_21,
  MSgType_NULL_22,
  MSgType_NULL_23,
  MSgType_NULL_24,
  MSgType_NULL_25,
  MSgType_NULL_26,
  MSgType_NULL_27,
  MSgType_NULL_28,
  MSgType_NULL_29,

  MSgType_NULL_30,
  MSgType_NULL_31,
  MSgType_NULL_32,
  MSgType_NULL_33,
  MSgType_NULL_34,
  MSgType_NULL_35,
  MSgType_NULL_36,
  MSgType_NULL_37,
  MSgType_NULL_38,
  MSgType_NULL_39,

  MSgType_NULL_40,
  MSgType_NULL_41,
  MSgType_NULL_42,
  MSgType_NULL_43,
  MSgType_NULL_44,
  MSgType_NULL_45,
  MSgType_NULL_46,
  MSgType_NULL_47,
  MSgType_NULL_48,
  MSgType_NULL_49,

  MSgType_NULL_50,
  MSgType_NULL_51,
  MSgType_NULL_52,
  MSgType_NULL_53,
  MSgType_NULL_54,
  MSgType_NULL_55,
  MSgType_NULL_56,
  MSgType_NULL_57,
  MSgType_NULL_58,
  MSgType_NULL_59,

  MSgType_NULL_60,
  MSgType_NULL_61,
  MSgType_NULL_62,
  MSgType_NULL_63,
  MSgType_NULL_64,
  MSgType_NULL_65,
  MSgType_NULL_66,
  MSgType_NULL_67,
  MSgType_NULL_68,
  MSgType_NULL_69,

  MSgType_NULL_70,
  MSgType_NULL_71,
  MSgType_NULL_72,
  MSgType_NULL_73,
  MSgType_NULL_74,
  MSgType_NULL_75,
  MSgType_NULL_76,
  MSgType_NULL_77,
  MSgType_NULL_78,
  MSgType_NULL_79,

  MSgType_NULL_80,
  MSgType_NULL_81,
  MSgType_NULL_82,
  MSgType_NULL_83,
  MSgType_NULL_84,
  MSgType_NULL_85,
  MSgType_NULL_86,
  MSgType_NULL_87,
  MSgType_NULL_88,
  MSgType_NULL_89,

  MSgType_NULL_90,
  MSgType_NULL_91,
  MSgType_NULL_92,
  MSgType_NULL_93,
  MSgType_NULL_94,
  MSgType_NULL_95,
  MSgType_NULL_96,
  MSgType_NULL_97,
  MSgType_NULL_98,
  MSgType_NULL_99,
  MSgType_Customer,
}

/// @nodoc
enum MessageStatusEnum {
  /// @nodoc  未定义　, 消息的时候代表消息撤回 , 这个消息的状态
  MOS_UNDEFINE,

  /// @nodoc 未处理状态<默认>　消息的时候代表发送初始化
  MOS_Init,

  /// @nodoc 已拒绝 ,消息部分代表消息　发送失败
  MOS_Declined,

  /// @nodoc   已过期
  MOS_Expired,

  /// @nodoc   已忽略
  MOS_Ignored,

  /// @nodoc   已通过验证
  MOS_Passed,

  /// @nodoc  已接单, 消息的时候代表接受成功
  MOS_Taked,

  /// @nodoc 已完成订单　, 消息中代表发送完成
  MOS_Done,

  /// @nodoc 撤单 , 消息的话代表　撤回
  MOS_Cancel,

  /// @nodoc 处理中
  MOS_Processing,
}

/// @nodoc
enum ClientTypeEnum {
  /// @nodoc 未知
  ClientUnKnow,

  /// @nodoc Android
  ClientAndroid,

  /// @nodoc iOS
  ClientiOS,

  /// @nodoc REST Api
  ClientRESTApi,

  /// @nodoc Windows
  ClientWindows,

  /// @nodoc MacOS
  ClientMacOS,

  /// @nodoc Web
  ClientWeb,
}

/// @nodoc
enum ProductTypeEnum {
  /// @nodoc 0
  OT_Undefined,

  /// @nodoc 生鲜产品 1
  OT_FreshProduct,

  /// @nodoc 肉类  2
  OT_Meat,

  /// @nodoc 水果蔬菜类 3
  OT_Fruits,

  /// @nodoc 粮油类  4
  OT_GrainOil,

  /// @nodoc 熟食类 5
  OT_Delicatessen,

  /// @nodoc 面包糕饼类 6
  OT_Bakery,

  /// @nodoc 生活五金用品类  7
  OT_GroceryStore,

  /// @nodoc 家政 8
  OT_HouseKeeping,

  /// @nodoc 彩票 9
  OT_Lottery,

  /// @nodoc 搬运 10
  OT_Carry,

  /// @nodoc  维修 11
  OT_Maintenance,

  /// @nodoc 服务行业 12
  OT_Services,

  /// @nodoc 其它 13
  OT_Others,
}

/// @nodoc 日志等级
enum SDKLogLevel {
  verbose,
  debug,
  info,
  warning,
  error,
  wtf,
  nothing,
}

/// @nodoc 日志输出方式
enum LogOutputEnum {
  console,
  file,
  stream,
}

enum KeyPairTypeEnum {
  KPT_Undefined,
  KPT_OPK,
  KPT_Orderf,
}

///订单子类型，用于区分各种彩票品种，根据此枚举来弹出相应的选号UI
enum SubTypeEnum {
  STE_Normal, //通用的，不区分
  STE_Shuangseqiu, //双色球 1
  STE_FuCai3D, //福彩3D 2
  STE_Daletou, //体彩大乐透 3
}

///
enum OnSellStateEnum {
  OnSellinit, //未上架， 处于本地编辑状态
  OnSelling, //上架中
  OnSellOut, //已下架

}
