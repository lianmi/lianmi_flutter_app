class HttpApi {
  static const String baseUrl = 'https://api.lianmi.cloud/';

  static const String users = 'users/simplezhli';
  static const String search = 'search/repositories';
  static const String subscriptions = 'users/simplezhli/subscriptions';
  static const String upload = 'uuc/upload-inco';
  static const String login = 'login';

  ///登录
  static const String register = 'register';

  ///注册
  static const String sms = 'smscode/';

  ///发生验证码
  static const String validatecode = 'validatecode';

  ///严重短信验证码
  static const String getId = 'getusernamebymobile/';

  ///根据手机号码获取id
  static const String membershipPricelist = 'v1/membership/pricelist';

  ///查询店铺列表
  static const String storeList = 'v1/store/list';

  ///多条件不定参数批量分页获取商户 列表
  static const String storeTypes = 'v1/store/types';

  ///获取商品种类编号及名称
  static const String storeInfo = 'v1/store/storeinfo';

  ///获取商铺信息
  static const String productList = 'v1/product/productslist';

  ///获取商品资料s
  static const String productInfo = 'v1/product/info';

  ///根据商品ID获取商品详情
  static const String uploadorderimage = 'v1/order/uploadorderimage'; //订单图片上链
  static const String orderimage = 'v1/order/orderimage/'; //买家在商户完成订单后获取拍照图片
  static const String generalproducts = 'v1/product/generalproductslist';

  // ///计算金额接口
  // static const String calculateOrderFee = 'v1/order/get_order_fee';

  ///发起支付接口
  static const String pay = 'v1/order/pay';

  ///模拟支付成功接口
  static const String wxCallback = 'v1/order/callback/wechat_test';

  ///测试解绑手机号
  static const String unBindMobile = 'v1/user/unbindmobile';
}
