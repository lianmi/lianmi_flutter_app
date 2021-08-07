class HttpApi {
  static const String baseUrl = 'https://api.lianmi.cloud/';

  // static const String users = 'users/simplezhli';
  // static const String search = 'search/repositories';
  // static const String subscriptions = 'users/simplezhli/subscriptions';
  // static const String upload = 'uuc/upload-inco';
  // static const String login = 'login';

  ///登录
  // static const String register = 'register';

  ///注册
  static const String sms = 'smscode/';

  ///发生验证码
  // static const String validatecode = 'validatecode';

  ///严重短信验证码
  // static const String getId = 'getusernamebymobile/';

  ///根据手机号码获取id
  // static const String membershipPricelist = 'v1/membership/pricelist';

  ///查询店铺列表
  static const String storeList = 'v1/store/list';

  ///多条件不定参数批量分页获取商户 列表
  static const String storeTypes = 'v1/store/types';

  ///获取商品种类编号及名称
  // static const String storeInfo = 'v1/store/storeinfo';

  ///获取商铺信息
  // static const String productList = 'v1/product/productslist';

  ///获取商品资料
  // static const String productInfo = 'v1/product/info';

  ///发起支付接口
  static const String pay = 'v1/order/pay';

  ///测试解绑手机号
  static const String unBindMobile = 'v1/user/unbindmobile';
}
