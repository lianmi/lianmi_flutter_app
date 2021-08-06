class HttpApi {
  static const String baseUrl = 'https://api.lianmi.cloud';

  //****** 鉴权相关的接口 ******/
  /// Post方法,  登录
  static const String login = '/login';

  /// Get方法, 登出
  static const String signout = '/v1/signout';

  /// Get方法,发送验证码
  static const String smscode = '/smscode';

  /// Get方法, 用手机号获取注册账号, 后面要加手机号
  static const String getId = '/getusernamebymobile';

  ///GET方法, 获取服务条款
  static const String fuwutiaokuan = '/v1/fuwutiaokuan';

  ///GET方法, 获取系统公告
  static const String systemMsgs = '/system_msgs';

  ///GET方法, 检查更新
  static const String checkUpdate = '/v1/checkupdate';

  ///GET方法, 用户扫描二维码的下载url
  static const String qrcodeUrl = '/qrcodeurl';

  //****** 用户相关的接口 ******/

  /// @nodoc 获取阿里云oss的临时令牌 - 用户资料区
  static const String osstoken = '/v1/user/osstoken';

  /// @nodoc 获取阿里云oss的临时令牌 - 存证区
  static const String cunzheng_osstoken = '/v1/user/cunzheng_osstoken';

  /// Post方法, 微信登录之后绑定手机
  static const String bindmobile = '/v1/user/bindmobile';

  /// Post方法, 手机登录之后绑定微信
  static const String bindwechat = '/v1/user/bindwechat';

  /// Post修改 Get查询方法, 用户app的推送设置开关
  static const String pushsetting = '/v1/user/pushsetting';

  ///  Get方法, 查询用户是否绑定了微信
  static const String isbindwechat = '/v1/user/isbindwechat';

  ///  Get方法, 解除绑定微信的手机
  static const String unbindmobile = '/v1/user/unbindmobile';

  /// Post方法, 用户登录之后提交手机设备信息以便推送
  static const String userUploadDeviceInfo = '/v1/user/upload_deviceinfo';

  /// Get方法,  获取当前用户个人注册资料
  static const String myProfile = '/v1/user/getuser';

  /// Post方法, 修改用户资料
  static const String userprofile = '/v1/user/userprofile';

  /// POST方法, 发起同步请求
  static const String doSync = '/v1/user/dosync';

  ///  Get方法, 查询商户是否在线
  static const String online = '/v1/user/online';

  /// POST 方法, 用户提交建议和反馈
  static const String submitProposeFeedback =
      '/v1/user/submit_propose_feedback';

  /// POST 方法, 用户提交举报
  static const String submitReport = '/v1/user/submit_report';

  //****** 商户相关的接口 ******/

  /// Get方法, 根据商户注册id获取店铺资料, 后面要加商户注册id
  static const String storeInfo = '/v1/store/storeinfo';

  /// Post方法, 提交店铺资料， 申请成为商户
  static const String addStore = '/v1/store/addstore';

  /// Get方法, 提交店铺资料后的审核状态
  static const String auditState = '/v1/store/audit_state';

  /// Post方法, 修改店铺资料
  static const String updateStore = '/v1/store/updatestore';

  /// POST方法, 关注商户
  /// GET方法, 获取当前用户所关注的商户
  static const String storeWatching = '/v1/store/store_watching';

  /// POST方法, 取消关注商户
  static const String cancelWatching = '/v1/store/cancel_watching';

  /// Post方法, 多条件不定参数批量分页获取店铺 列表
  static const String storeList = '/v1/store/list';

  /// Get方法, 根据商品ID获取商品详情 , 后面要加商品id
  static const String productInfo = '/v1/product/info';

  /// Get方法, 查询商家的订单记录,指定某个月统计
  static const String storeOrders = '/v1/store/store_orders';

  /// Get方法, 查询商家的用户消费记录,按月统计, 可以用于分成核对 s
  static const String storeSpendings = '/v1/store/store_spendings';

  /// 获取所有通用商品
  static const String generalproducts = '/v1/product/generalproductslist';

  /// Post方法, 商户上传Rsa公钥
  // static const String uploadPublickey = '/v1/store/upload_publickey';

  /// Get方法, 买家获取全局的公钥
  static const String rsaPublickey = '/v1/store/rsa_publickey';

  /// Get方法, 商户获取全局的私钥
  static const String rsaPrivatekey = '/v1/store/rsa_privatekey';

  //****** 订单相关的接口 ******/

  /// Post方法, 商户将完成订单拍照图片上链
  static const String uploadorderimage = '/v1/order/uploadorderimage';

  /// Get方法, 买家在商户完成订单后获取拍照图片, 后面要加订单id
  static const String orderimage = '/v1/order/orderimage';

  /// GET方法,  查询订单列表
  static const String orderList = '/v1/order/lists';

  /// POST方法,  查询订单列表
  static const String orderSearch = '/v1/order/search';

  /// GET方法,  查询某个订单信息
  static const String orderInfo = '/v1/order/info';

  /// POST方法,  修改订单状态
  static const String updateStatus = '/v1/order/update_status';

  /// POST方法,  修改订单总价
  static const String changeOrderCost = '/v1/order/change_order_cost';

  // /// POST方法, 创建一个订单， 并返回订单id
  static const String preOrder = '/v1/order/pre_order';

  /// POST方法, 根据彩票总金额(元为单位)，返回手续费(以分为单位)
  static const String getOrderFee = '/v1/order/get_order_fee';

  /// POST方法, 商户接单，上传收款码
  static const String takeOrder = '/v1/order/take_order';

  ///根据订单id获取商家收款码
  static const String payUrl = '/v1/order/pay_url';

  ///根据订单id获取蚂蚁链存证二维码
  static const String transactionQrcode = '/v1/order/transaction_qrcode';

  /// POST方法, 根据阿里云url返回签名url
  static const String cunzheng_file = '/v1/order/cunzheng_file';

  /// POST方法, 商户兑奖，输入中奖金额
  static const String inputPrize = '/v1/order/push_prize';

  /// POST方法, 用户领奖，上传收款码
  static const String acceptPrize = '/v1/order/accept_prize';

  ///GET 商户根据订单id获取用户上传的兑奖收款码
  static const String acceptPrizeUrl = '/v1/order/accept_prize_url';

  /// POST方法, 当前用户删除自己的订单
  static const String deleteOrder = '/v1/order/delete';

  /// POST方法,  清空当前用户的所有订单
  static const String clearAllOrders = '/v1/order/clearall';

  /// POST方法,  提交合同类型的上链订单
  static const String submitHetongData = '/v1/order/submit_hetong';

  //****** 钱包相关的接口 ******/

  /// @nodoc 查询余额
  static const String getBalance = '/v1/wallet/balance';

  /// @nodoc 用微信发起充值
  static const String wxPrepay = '/v1/wallet/wx_prepay';

  /// @nodoc 用支付宝发起充值
  static const String aliPrepay = '/v1/wallet/ali_prepay';

  /// @nodoc 查询充值历史记录
  static const String getTransactions = '/v1/wallet/transactions';

  /// @nodoc 查询消费历史记录
  static const String getSpendings = '/v1/wallet/spendings';
}
