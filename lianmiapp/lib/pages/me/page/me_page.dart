import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';
import 'package:lianmiapp/linkme/linkme_manager.dart';
import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/pages/login/login_router.dart';
import 'package:lianmiapp/pages/me/page/me_test_page.dart';
import 'package:lianmiapp/provider/linkme_provider.dart';
import 'package:lianmiapp/res/resources.dart';
import 'package:lianmiapp/routers/fluro_navigator.dart';
import 'package:lianmiapp/util/app_navigator.dart';

class MePage extends StatefulWidget {
  @override
  _MePageState createState() => _MePageState();
}

class _MePageState extends State<MePage>
    with AutomaticKeepAliveClientMixin<MePage>, SingleTickerProviderStateMixin
    implements LinkMeManagerOrderStatusListerner {
  @override
  bool get wantKeepAlive => true;

  late TabController _tabController;
  // MePageProvider provider = MePageProvider();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 5);
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      /// 预先缓存剩余切换图片
      // _preCacheImage();
    });
    LinkMeManager.instance.addOrderListener(this);
    requestMembership();
  }

  // void _preCacheImage() {
  //   precacheImage(ImageUtils.getAssetImage('order/xdd_n'), context);
  //   precacheImage(ImageUtils.getAssetImage('order/dps_s'), context);
  //   precacheImage(ImageUtils.getAssetImage('order/dwc_s'), context);
  //   precacheImage(ImageUtils.getAssetImage('order/ywc_s'), context);
  //   precacheImage(ImageUtils.getAssetImage('order/yqx_s'), context);
  // }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
    LinkMeManager.instance.removeOrderListener(this);
  }

  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // isDark = context.isDark;

    String loginText = '登陆';

    if (AuthMod.getLastLoginName() != null &&
        AuthMod.getLastLoginName()!.length > 0)
      loginText += '（已登录 ${AuthMod.getLastLoginName()}）';

    return Scaffold(
      appBar: AppBar(
        title: Text('我的'),
      ),
      body: Container(
        child: ListView(
          children: [
            MaterialButton(
              child: Text(
                loginText,
                style: TextStyles.textBold14,
              ),
              onPressed: () {
                NavigatorUtils.push(
                  context,
                  LoginRouter.loginPage,
                );
              },
            ),
            // MaterialButton(
            //   child: Text('商户注册', style: TextStyles.textBold14,),
            //   onPressed: (){
            //     NavigatorUtils.push(context,
            //       LoginRouter.registerBusinessPage,
            //     );
            //   },
            // ),
            // MaterialButton(
            //   child: Text('上传营业执照', style: TextStyles.textBold14,),
            //   onPressed: (){
            //     NavigatorUtils.push(context,
            //       LoginRouter.businessSelectCertificate,
            //     );
            //   },
            // ),
            // MaterialButton(
            //   child: Text('商户主页', style: TextStyles.textBold14,),
            //   onPressed: (){
            //     NavigatorUtils.push(context,
            //       Routes.homeShopPage
            //     );
            //   },
            // ),
            // MaterialButton(
            //   child: Text('用户主页', style: TextStyles.textBold14,),
            //   onPressed: (){
            //     Navigator.of(context).push(
            //       CupertinoPageRoute(
            //         builder: (_) => UserPage()
            //       )
            //     );
            //   },
            // ),
            // MaterialButton(
            //   child: Text('修改密码', style: TextStyles.textBold14,),
            //   onPressed: (){
            //     NavigatorUtils.push(context,
            //         LoginRouter.resetPasswordPage
            //     );
            //   },
            // ),

            MaterialButton(
              child: Text(
                '包年',
                style: TextStyles.textBold14,
              ),
              onPressed: () {},
            ),
            MaterialButton(
              child: Text(
                '包季',
                style: TextStyles.textBold14,
              ),
              onPressed: () {},
            ),
            MaterialButton(
              child: Text(
                '包月',
                style: TextStyles.textBold14,
              ),
              onPressed: () {},
            ),

            // MaterialButton(
            //   child: Text(
            //     'GetOrder测试',
            //     style: TextStyles.textBold14,
            //   ),
            //   onPressed: () {
            //     testGetOrders();
            //   },
            // ),
            MaterialButton(
              child: Text(
                '测试',
                style: TextStyles.textBold14,
              ),
              onPressed: () {
                showTest();
              },
            ),

            MaterialButton(
              child: Text(
                '退出当前用户',
                style: TextStyles.textBold14,
              ),
              onPressed: () {
                logout();
              },
            ),
          ],
        ),
      ),
    );
  }

  final PageController _pageController = PageController(initialPage: 0);
  Future<void> _onPageChange(int index) async {
    // provider.setIndex(index);

    /// 这里没有指示器，所以缩短过渡动画时间，减少不必要的刷新
    _tabController.animateTo(index, duration: const Duration(milliseconds: 0));
  }

  void requestMembership() {
    // HubView.showLoading();
    // HttpUtils.get(HttpApi.membershipPricelist).then((value) {
    //   HubView.dismiss();
    //   List<dynamic> pricelist = value['pricelist'];
    //   memberships = MembershipModel.modelListFromJson(pricelist);
    //   print(memberships);
    // }).catchError((err) {
    //   HubView.dismiss();
    // });
  }

  void register() async {}

  //增加100次订单发送，暂时用来测试
  void shopAdd100() async {
    var _mobile = "13577912348";
    await _sendSms(_mobile);
    AuthMod.login(LoginType.LoginType_Mobile, _mobile,
            "C33367701511B4F6020EC61DED352059", "123456", true, 1)
        .then((value) async {
      // OrderMod.registerPreKeys().then((value) {
      //   print('add 100');
      //   print(value);
      // });
    });
  }

  _sendSms(var lastMobile) async {
    return AuthMod.getSmscode(lastMobile);
    // f1.then((value) {
    //   print("AuthMod.sendSms code = ${value.code} , msg = ${value.errmsg}");
    // });
  }

  void testGetOrders() {
    OrderMod.getOrders(0).then((value) {
      logD(value);
    }).catchError((error) {
      logE(error);
    });
    // var getAllKey = OrderMod.getOrders();
    // getAllKey.then((value){
    //   print("getAllKey ${value.code}");
    //   print("datas , ${value.orderInfoDatas.toString()}" );
    // });
    // OrderMod.getOrder('b8111060-9cec-4478-90e0-831cf9c3a67c').then((value) {
    //   print(value);
    // }).catchError((err) {
    //   print(err);
    // });
  }

  void showTest() {
    AppNavigator.pushResult(context, MeTestPage(), (result) {});
  }

  void updateAddress() {
    // UserMod.updateUserProfile({
    //   UserFeildEnum.UserFeildEnum_Province: '广东',
    //   UserFeildEnum.UserFeildEnum_City: '广州',
    //   UserFeildEnum.UserFeildEnum_County: '天河区',
    //   UserFeildEnum.UserFeildEnum_Street: '体育西路',
    //   UserFeildEnum.UserFeildEnum_Address: '建和中心全家便利店'
    // }).then((value) {
    //   print(value);
    // });
  }

  void logout() async {
    await AuthMod.signout();
    HubView.showToast('已退出');
    String id = AuthMod.getLastLoginName() ?? '';
    // logW(id);
    Future.delayed(Duration(seconds: 1), () {
      Provider.of<LinkMeProvider>(App.context!, listen: false).logoutSuccess();
    });
  }

  void payWithMembership(dynamic model) async {
    // try {
    //   MemberFreeOrderModel order =
    //       MemberFreeOrderModel(payType: model.payType, price: model.price);
    //   OrderInfoData orderinfo = new OrderInfoData();
    //   orderinfo.orderType = ProductOrderType.POT_Normal; //普通订单
    //   orderinfo.businessUser = model.businessUsername; //商户
    //   orderinfo.productID = model.productID; // 商品ID
    //   orderinfo.attachType = AttachTypeEnum.ATE_Order; //附件类型为订单
    //   orderinfo.attach = order.toAttach(); //附件内容
    //   orderinfo.orderTotalAmount = model.price; //金额，以元为单位, 可带小数点
    //   await OrderMod.sendQuickOrder(orderinfo);
    // } catch (e) {
    //   HubView.showToastAfterLoadingHubDismiss('会员费支付失败:${e}');
    // }
  }

  void pay(String orderId, double cost) async {
    // try {
    //   HubView.showLoadingWithText('正在支付会员费');
    //   var preTransferValue = await WalletMod.preTransfer(orderId, '', cost);
    //   String nonceStr = '${preTransferValue.tx.nonce}';
    //   String destinationAddressStr = "${preTransferValue.tx.toWalletAddress}";
    //   String transferAmountTokenStr = '${preTransferValue.tx.value}'; // "100";
    //   String gasLimitStr = '${preTransferValue.tx.gasLimitStr}';
    //   String contractAddress = '${preTransferValue.tx.contractAddress}';
    //   String inputStr = '${preTransferValue.tx.txdata}';
    //   String uuid = preTransferValue.uuid;
    //   print('准备签名,签名数据:');
    //   print('nonceStr---$nonceStr');
    //   print('destinationAddressStr---$destinationAddressStr');
    //   print('transferAmountTokenStr---$transferAmountTokenStr');
    //   print('gasLimitStr---$gasLimitStr');
    //   print('contractAddress---$contractAddress');
    //   print('inputStr---$inputStr');
    //   print('uuid---$uuid');
    //   ATransactionCallBackData signValue =
    //       await WalletMod.getTransactionSerializeA(
    //           nonceStr,
    //           destinationAddressStr,
    //           transferAmountTokenStr,
    //           gasLimitStr,
    //           contractAddress,
    //           inputStr);
    //   if (signValue.code == 200) {
    //     WalletMod.confirmTransfer(uuid, signValue.signA).then((value) {
    //       HubView.dismiss();
    //       HubView.showToastAfterLoadingHubDismiss('会员费支付成功');
    //     }).catchError((error) {
    //       HubView.dismiss();
    //       HubView.showToastAfterLoadingHubDismiss('会员费支付失败:${error}');
    //     });
    //   } else {
    //     HubView.dismiss();
    //     HubView.showToastAfterLoadingHubDismiss('签名错误:${signValue.errmsg}');
    //   }
    // } catch (e) {
    //   HubView.dismiss();
    //   HubView.showToastAfterLoadingHubDismiss('会员费支付失败:${e}');
    // }
  }

  @override
  void onLinkMeOrderStatusChange(OrderInfoData orderInfo) {
    print('监听到orderid变化---${orderInfo.orderId},状态${orderInfo.state}');
  }
}
