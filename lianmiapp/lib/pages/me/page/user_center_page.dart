import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lianmiapp/linkme/linkme_manager.dart';
import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/pages/discovery/page/store_focus_page.dart';
import 'package:lianmiapp/pages/me/page/recharge_page.dart';
import 'package:lianmiapp/pages/me/page/report/report_page.dart';
import 'package:lianmiapp/pages/me/page/settings/setting_home_page.dart';
import 'package:lianmiapp/pages/me/page/store/storeRouter.dart';
import 'package:lianmiapp/pages/me/page/userInfo/user_info_page.dart';
import 'package:lianmiapp/pages/me/page/user_qr_page.dart';
import 'package:lianmiapp/provider/me/userInfo_view_model.dart';
import 'package:lianmiapp/res/resources.dart';
import 'package:lianmiapp/res/view_standard.dart';
import 'package:lianmiapp/util/app.dart';
import 'package:lianmiapp/util/app_navigator.dart';
import 'package:lianmiapp/util/image_utils.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart' as sdk;
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';
import 'history_fee_page.dart';
import 'history_notice_page.dart';
import 'history_recharge_page.dart';
import 'me_qrcode.dart';
import 'order_sum_page.dart';
import 'propose/propose_feedback_page.dart';
// import 'storeinfo/store_ca_page.dart';
import 'storeinfo/store_info_page.dart';

class UserCenterPage extends StatefulWidget {
  UserCenterPage();
  @override
  _UserCenterPageState createState() => _UserCenterPageState();
}

class _UserCenterPageState extends State<UserCenterPage>
    with
        AutomaticKeepAliveClientMixin<UserCenterPage>,
        SingleTickerProviderStateMixin
    implements LinkMeManagerOrderStatusListerner {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    LinkMeManager.instance.addOrderListener(this);
  }

  @override
  void dispose() {
    super.dispose();
    LinkMeManager.instance.removeOrderListener(this);
  }

  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
          backgroundColor: Colours.bg_color,
        ),
        child: Scaffold(
          backgroundColor: Color(0xffF3F6F9),
          body: _body(),
        ));
  }

  Widget _body() {
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Container(
              width: double.infinity,
              height: 74.px,
              color: App.isShop ? Color(0xFF333333) : Colours.app_main,
              child: Column(
                children: [
                  SizedBox(
                    height: 30.px,
                  ),
                  Container(
                    padding: ViewStandard.padding,
                    width: double.infinity,
                    height: 44.px,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('??????',
                            style:
                                TextStyle(fontSize: 20, color: Colors.white)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[_top(), _bottom()],
            ),
          ),
        ],
      ),
    );
  }

  Widget _top() {
    return Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 0), //64 is height of the bar
        child: Stack(
          //???????????????????????????
          children: [_top_1()],
          // children: [_top_1(), _top_2()],
        ));
  }

  Widget _top_1() {
    return Consumer<UserInfoViewModel>(builder: (context, userInfo, child) {
      if (userInfo.user == null) return SizedBox();
      return Column(
        children: [
          Container(
            height: 115.px,
            padding: EdgeInsets.only(top: 0),
            decoration: new BoxDecoration(
              color: App.isShop ? Color(0xFF333333) : Colours.app_main,
            ),
            child: Align(
              alignment: Alignment(0, 0),
              child: Container(
                  // height: 64,
                  margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () =>
                            {AppNavigator.push(context, UserInfoPage())},
                        child: Row(
                          children: [
                            Container(
                              width: 64.0,
                              height: 64.0,
                              margin: EdgeInsets.only(right: 16),
                              decoration: new BoxDecoration(
                                color: Colors.white,
                                image: new DecorationImage(
                                    image: ImageUtils.getImageProvider(
                                        userInfo.user!.avatar!),
                                    fit: BoxFit.cover),
                                shape:
                                    BoxShape.rectangle, // <-- ????????????????????? rectangle
                                borderRadius: new BorderRadius.all(
                                  const Radius.circular(
                                      10.0), // <-- rectangle ??????BorderRadius ?????????
                                ),
                              ),
                            ),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    isValidString(userInfo.user!.nick)
                                        ? userInfo.user!.nick!
                                        : '??????????????????',
                                    style: TextStyles.textBold18
                                        .copyWith(color: Colors.white),
                                  ),
                                  // Text(
                                  //   '????????????${userInfo.user!.username}',
                                  //   style: TextStyles.text14
                                  //       .copyWith(color: Colors.white),
                                  // ),
                                  App.isShop == false
                                      ? Text(
                                          '?????????${userInfo.balanceText}',
                                          style: TextStyles.textBold18
                                              .copyWith(color: Colors.white),
                                        )
                                      : SizedBox()
                                ]),
                          ],
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            AppNavigator.push(context, UserQrPage());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.qr_code,
                                color: Colors.white,
                              ),
                              Icon(Icons.keyboard_arrow_right,
                                  color: Colors.white)
                            ],
                          )),
                    ],
                  )),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              //??????
              color: App.isShop ? Color(0xFF333333) : Colours.app_main,
              //??????????????????
              border: Border.all(
                  width: 1,
                  color: App.isShop ? Color(0xFF333333) : Colours.app_main),
            ),
            height: 12.px,
          )
        ],
      );
    });
  }

  Widget _bottom() {
    return Container(
        margin: EdgeInsets.fromLTRB(16, 10, 16, 0),
        child: Column(
          children: [
            _sv_item(
                fromC: Color(0xFFC9B6FD),
                toC: Color(0xFF997FF9),
                text: '????????????',
                icon: Icon(
                  Icons.circle_notifications,
                  color: Colors.white,
                ),
                onTap: () {
                  AppNavigator.push(context, HistoryNoticePage());
                }),
            App.isShop == false
                ? _sv_item(
                    fromC: Color(0xFFC9B6FD),
                    toC: Color(0xFF997FF9),
                    text: '????????????',
                    icon: Icon(
                      Icons.filter_center_focus,
                      color: Colors.yellow,
                    ),
                    onTap: () {
                      AppNavigator.push(context, StoreFocusPage());
                    })
                : SizedBox(),
            App.isShop == false
                ? _sv_item(
                    fromC: Color(0xFFC9B6FD),
                    toC: Color(0xFF997FF9),
                    text: '????????????',
                    icon: Icon(
                      Icons.attach_money,
                      color: Colors.yellow,
                    ),
                    onTap: () {
                      AppNavigator.push(context, RechargePage());
                    })
                : SizedBox(),
            App.isShop == false
                ? _sv_item(
                    fromC: Color(0xFFC9B6FD),
                    toC: Color(0xFF997FF9),
                    text: '????????????',
                    icon: Icon(
                      Icons.history_rounded,
                      color: Colors.white,
                    ),
                    onTap: () {
                      AppNavigator.push(context, HistoryRechargePage());
                    })
                : SizedBox(),
            App.isShop == false
                ? _sv_item(
                    fromC: Color(0xFFC9B6FD),
                    toC: Color(0xFF997FF9),
                    text: '?????????????????????',
                    icon: Image.asset(
                      ImageStandard.shopBalance,
                      width: 32.px,
                      height: 32.px,
                    ),
                    onTap: () {
                      AppNavigator.push(context, HistoryFeePage());
                    })
                : SizedBox(),
            App.isShop
                ? _sv_item(
                    fromC: Color(0xFFC9B6FD),
                    toC: Color(0xFF997FF9),
                    icon: Image.asset(
                      ImageStandard.shopProfile,
                      width: 32.px,
                      height: 32.px,
                    ),
                    text: '????????????',
                    onTap: () {
                      AppNavigator.push(context, StoreInfoPage());
                    })
                : SizedBox(),
            App.isShop
                ? _sv_item(
                    fromC: Color(0xFFC9B6FD),
                    toC: Color(0xFF997FF9),
                    icon: Image.asset(
                      ImageStandard.shopBalance,
                      width: 32.px,
                      height: 32.px,
                    ),
                    text: '??????????????????',
                    onTap: () {
                      AppNavigator.push(context, OrderSumPage());
                    })
                : SizedBox(),
            _sv_item(
                fromC: Color(0xFFB1D0FF),
                toC: Color(0xFF79A3FF),
                text: '????????????',
                icon: Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                onTap: () {
                  AppNavigator.push(context, SettingHomePage());
                }),
            App.isShop
                ? SizedBox()
                : _sv_item(
                    fromC: Color(0xFFFFEA9B),
                    toC: Color(0xFFFED062),
                    text: '??????????????????',
                    icon: Icon(
                      Icons.store,
                      color: Colors.white,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, StoreRegRouter.toStorePage);
                    }),
            _sv_item(
                fromC: Color(0xFFC9B6FD),
                toC: Color(0xFF997FF9),
                text: '???????????????',
                icon: Icon(
                  Icons.feedback,
                  color: Colors.white,
                ),
                onTap: () {
                  AppNavigator.push(context, ProposeFeedbackPage());
                }),
            _sv_item(
                fromC: Color(0xFFC9B6FD),
                toC: Color(0xFF997FF9),
                text: '????????????',
                icon: Icon(
                  Icons.report,
                  color: Colors.white,
                ),
                onTap: () {
                  AppNavigator.push(context, ReportPage());
                }),
          ],
        ));
  }

  Widget _sv_item(
      {Color? fromC, Color? toC, String? text, Widget? icon, Function? onTap}) {
    return InkWell(
        onTap: () {
          onTap!();
        },
        child: Container(
            padding: EdgeInsets.fromLTRB(0, 11, 0, 11),
            child: Row(
              children: [
                Container(
                    height: 32,
                    width: 32,
                    child: icon,
                    decoration: new BoxDecoration(
                        //??????
                        color: Colours.app_main,
                        //?????????????????? ??????
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        //??????????????????
                        gradient: LinearGradient(
                            //????????????
                            begin: Alignment.topCenter, //??????
                            end: Alignment.bottomCenter, //??????
                            stops: [0.0, 1.0], //[???????????????, ???????????????]
                            //????????????[????????????, ????????????]
                            colors: [fromC!, toC!]))),
                SizedBox(height: 12),
                Gaps.hGap12,
                Text(
                  text!,
                  style: TextStyle(color: Colours.dark_text_gray, fontSize: 14),
                ),
                Expanded(child: Container()),
                Icon(Icons.keyboard_arrow_right, color: Color(0xff666666))
              ],
            )));
  }

  @override
  void onLinkMeOrderStatusChange(sdk.OrderInfoData orderInfo) {
    logI('?????????orderid??????---${orderInfo.orderId},??????${orderInfo.state}');
  }
}
