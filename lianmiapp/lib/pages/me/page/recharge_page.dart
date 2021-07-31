import 'dart:convert';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:lianmiapp/res/styles.dart';
import 'package:tobias/tobias.dart' as tobias;
import 'package:lianmiapp/component/type_choose.dart';
import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/models/wx_pay_model.dart';
import 'package:lianmiapp/provider/me/userInfo_view_model.dart';
import 'package:lianmiapp/res/view_standard.dart';
import 'package:linkme_flutter_sdk/manager/LogManager.dart';
import 'package:linkme_flutter_sdk/sdk/WalletMod.dart';

const kRechargeList = [1, 10, 20, 50, 100];

class RechargePage extends StatefulWidget {
  const RechargePage({Key? key}) : super(key: key);

  @override
  _RechargePageState createState() => _RechargePageState();
}

class _RechargePageState extends State<RechargePage> {
  @override
  void initState() {
    super.initState();
    fluwx.weChatResponseEventHandler.listen((res) {
      if (res is fluwx.WeChatPaymentResponse) {
        bool result = res.isSuccessful;
        if (result) {
          HubView.showToastAfterLoadingHubDismiss('支付成功');
          GetProvider<UserInfoViewModel>().updateBalance();
        } else {
          HubView.showToastAfterLoadingHubDismiss('支付失败');
        }
      }
    });
  }


  void _showPayTypeAlert(int money) {
    TypeChoose.show(
        title: '选择支付类型',
        list: ['微信', '支付宝'],
        onTap: (int index) {
          _requestPayInfo(money, index + 1);
        });
  }

  void _requestPayInfo(int money, int type) {
    if (type == 1) {
      HubView.showLoading();
      WalletMod.wxPrepay(money * 1.0).then((value) {
        if (value is bool) {
          if (money == 1) {
            HubView.showToastAfterLoadingHubDismiss('1元充值仅限一次');
          }
        } else {
          HubView.dismiss();
          _wxPay(value['pay_code']);
          logI(value);
        }
      }).catchError((err) {
        HubView.dismiss();
      });
    } else {
      HubView.showLoading();
      WalletMod.aliPrepay(money * 1.0).then((value) {
        if (value is bool) {
          if (money == 1) {
            HubView.showToastAfterLoadingHubDismiss('1元充值仅限一次');
          }
        } else {
          logI('call WalletMod.aliPrepay: $value');
          HubView.dismiss();
          tobias.aliPay(value).then((value) {
            if (value['memo'] != '') {
              HubView.showToastAfterLoadingHubDismiss(value['memo']);
            } else {
              HubView.showToastAfterLoadingHubDismiss('支付成功');
            }
            GetProvider<UserInfoViewModel>().updateBalance();
          }).catchError((err) {
            HubView.showToastAfterLoadingHubDismiss('支付失败, 原因:$err');
          });
        }
      }).catchError((err) {
        HubView.dismiss();
      });
    }
  }

  void _wxPay(String paycodeStr) {
    var jsonobj = json.decode(paycodeStr);
    var payinfo = WXPayModel.fromJsonMap(jsonobj);
    fluwx.payWithWeChat(
      appId: payinfo.appid!,
      partnerId: payinfo.partnerid!,
      prepayId: payinfo.prepayid!,
      packageValue: payinfo.package!,
      nonceStr: payinfo.noncestr!,
      timeStamp: payinfo.timestamp!,
      sign: payinfo.sign!,
    );
  }

  @override
  Widget build(BuildContext context) {
    var menuWidgets = <Widget>[
      menuButton(context, 'assets/images/recharge/10yuan.png', "充值10元", "10"),
      menuButton(context, 'assets/images/recharge/20yuan.png', "充值20元", "20"),
      menuButton(context, 'assets/images/recharge/50yuan.png', "充值50元", "50"),
      menuButton(
          context, 'assets/images/recharge/100yuan.png', "充值100元", "100"),
      menuButton(
          context, 'assets/images/recharge/200yuan.png', "充值200元", "200"),
      menuButton(context, 'assets/images/recharge/1yuan.png', "充值1元-限充一次", "1"),
    ];

    final size = MediaQuery.of(context).size;
    final childRatio = (size.width / size.height) * 2.5;

    // 分为上下两个区，上半区显示logo，下半区显示网格
    return Scaffold(
      appBar: MyCustomAppBar(
        centerTitle: '充值中心',
      ),
      body: SafeArea(
        top: true,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(30),
              child: Center(
                  child: Text('目前只支持微信及支付宝在线支付', style: TextStyles.font20())),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: GridView.count(
                  childAspectRatio: childRatio,
                  crossAxisCount: 2,
                  mainAxisSpacing: 5,
                  children: menuWidgets,
                ),
              ),
            ),
            // Gaps.vGap16,
            // Text('目前只支持微信及支付宝在线支付', style: TextStyles.font15()),
          ],
        ),
      ),
    );
  }

  // helpers
  Widget menuButton(
      BuildContext context, String assetSrc, String title, String key) {
    return Padding(
      padding: EdgeInsets.all(4.0),
      child: Container(
        height: 42.0,
        child: TextButton(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  height: 36,
                  child: Image.asset(
                    assetSrc,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xAA001133),
                ),
              )
            ],
          ),
          onPressed: () {
            tappedMenuButton(context, key);
          },
        ),
      ),
    );
  }

  // actions
  void tappedMenuButton(BuildContext context, String key) {
    String message = "";
    String hexCode = "#FFFFFF";
    String result;
    // TransitionType transitionType = TransitionType.native;
    // if (key != "custom" && key != "function-call" && key != "fixed-trans") {
    //   if (key == "native") {
    //     hexCode = "#F76F00";
    //     message =
    //         "This screen should have appeared using the default flutter animation for the current OS";
    //   } else if (key == "preset-from-left") {
    //     hexCode = "#5BF700";
    //     message =
    //         "This screen should have appeared with a slide in from left transition";
    //     transitionType = TransitionType.inFromLeft;
    //   } else if (key == "preset-fade") {
    //     hexCode = "#F700D2";
    //     message = "This screen should have appeared with a fade in transition";
    //     transitionType = TransitionType.fadeIn;
    //   } else if (key == "pop-result") {
    //     transitionType = TransitionType.native;
    //     hexCode = "#7d41f4";
    //     message =
    //         "When you close this screen you should see the current day of the week";
    //     result = "Today is ${_daysOfWeek[DateTime.now().weekday - 1]}!";
    //   }

    //   String route = "/demo?message=$message&color_hex=$hexCode";

    //   if (result != null) {
    //     route = "$route&result=$result";
    //   }

    //   Application.router
    //       .navigateTo(context, route, transition: transitionType)
    //       .then((result) {
    //     if (key == "pop-result") {
    //       Application.router.navigateTo(context, "/demo/func?message=$result");
    //     }
    //   });
    // } else if (key == "custom") {
    //   hexCode = "#DFF700";
    //   message =
    //       "This screen should have appeared with a crazy custom transition";
    //   var transition = (BuildContext context, Animation<double> animation,
    //       Animation<double> secondaryAnimation, Widget child) {
    //     return ScaleTransition(
    //       scale: animation,
    //       child: RotationTransition(
    //         turns: animation,
    //         child: child,
    //       ),
    //     );
    //   };
    //   Application.router.navigateTo(
    //     context,
    //     "/demo?message=$message&color_hex=$hexCode",
    //     transition: TransitionType.custom,
    //     transitionBuilder: transition,
    //     transitionDuration: const Duration(milliseconds: 600),
    //   );
    // } else if (key == "fixed-trans") {
    //   Application.router.navigateTo(
    //       context, "/demo/fixedtrans?message=Hello!&color_hex=#f4424b");
    // } else {
    //   message = "You tapped the function button!";
    //   Application.router.navigateTo(context, "/demo/func?message=$message");
    // }

    if (key == "1") {}
    _showPayTypeAlert(int.parse(key));
  }
}
