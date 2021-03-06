import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lianmiapp/common/common.dart';
import 'package:lianmiapp/localization/app_localizations.dart';
import 'package:lianmiapp/net/dio_utils.dart';
import 'package:lianmiapp/net/intercept.dart';
import 'package:lianmiapp/pages/legalattest/provider/hetong_provider.dart';
import 'package:lianmiapp/pages/home/home_page_shop.dart';
import 'package:lianmiapp/pages/home/home_page_user.dart';
import 'package:lianmiapp/pages/home/provider/home_provider.dart';
import 'package:lianmiapp/pages/login/page/bind_mobile_page.dart';
import 'package:lianmiapp/pages/login/page/login_page.dart';
import 'package:lianmiapp/pages/product/utils/lottery_data.dart';
import 'package:lianmiapp/pages/me/provider/propose_feedback_provider.dart';
import 'package:lianmiapp/pages/me/provider/report_provider.dart';
import 'package:lianmiapp/pages/me/provider/store_review_provider.dart';
import 'package:lianmiapp/provider/linkme_provider.dart';
import 'package:lianmiapp/provider/location_provider.dart';
import 'package:lianmiapp/provider/main_tabbar_index_provider.dart';
import 'package:lianmiapp/provider/me/storeInfo_view_model.dart';
import 'package:lianmiapp/provider/me/userInfo_view_model.dart';
import 'package:lianmiapp/provider/store_focus_provider.dart';
import 'package:lianmiapp/provider/theme_provider.dart';
import 'package:lianmiapp/res/colors.dart';
import 'package:lianmiapp/routers/not_found_page.dart';
import 'package:lianmiapp/routers/routers.dart';
import 'package:lianmiapp/util/app.dart';
import 'package:lianmiapp/util/device_utils.dart';
import 'package:lianmiapp/util/http_utils.dart';
import 'package:lianmiapp/util/log_utils.dart';
import 'package:lianmiapp/util/shared_preferences_utils.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';
import 'package:oktoast/oktoast.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:sp_util/sp_util.dart';

import 'net/http_api.dart';

Future initDio() async {
  final List<Interceptor> interceptors = [];

  /// ?????????????????????????????????
  interceptors.add(AuthInterceptor());

  ///?????????dio
  HttpUtils.init(baseUrl: HttpApi.baseUrl);

  /// ??????Token
  interceptors.add(TokenInterceptor());

  /// ??????Log(??????????????????)
  if (!Constant.inProduction) {
    interceptors.add(LoggingInterceptor());
  }

  /// ????????????(???????????????????????????????????????????????????)
  interceptors.add(AdapterInterceptor());
  setInitDio(
    baseUrl: Constant.baseUrl, //??????url
    interceptors: interceptors,
  );
  return;
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// sp?????????
  await SpUtil.getInstance();
  await SharePreferencesUtils.getInstance();
  Log.init();
  await initDio();
  await App.initLinkme();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: UserInfoViewModel()),
      ChangeNotifierProvider.value(value: StoreInfoViewModel()),

      ChangeNotifierProvider.value(value: MainTabbarIndexProvider()),

      ///??????????????????
      ChangeNotifierProvider.value(value: HomeProvider()),
      ChangeNotifierProvider.value(value: LinkMeProvider()),

      ///??????
      ChangeNotifierProvider.value(value: LocationProvider()),

      ///????????????
      ChangeNotifierProvider.value(value: StoreFocusProvider()),

      ///??????????????????,???????????????????????????
      ChangeNotifierProvider.value(value: StoreReviewProvider()),

      ///???????????????
      ChangeNotifierProvider.value(value: ProposeFeedbackProvider()),

      ///??????
      ChangeNotifierProvider.value(value: ReportProvider()),

      ///??????
      ChangeNotifierProvider.value(value: HetongProvider()),

      //TODO ???????????????provider???????????????????????????

      ///????????????
      ...LotteryData.instance.providers
    ],
    child: MyApp(),
  ));
  // ???????????????
  if (Device.isAndroid) {
    const SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  late Widget home; // ????????????
  late ThemeData theme; //????????????

  final BotToastNavigatorObserver _bot = BotToastNavigatorObserver();

  @override
  void initState() {
    super.initState();
    Routes.initRoutes();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
    App.handleAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    App.initApp(context);
    return OKToast(
        child: ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(),
          child: Consumer2<ThemeProvider, LinkMeProvider>(
            builder: (_, provider, linkmeProvide, __) {
              bool isLogin = linkmeProvide.isLogin;
              bool isBindMobile = linkmeProvide.isBindMobile;
              Widget home;
              if (isBindMobile) {
                UserTypeEnum lastUserType = AuthMod.getLastLoginUserType();
                if (lastUserType == UserTypeEnum.UserTypeEnum_Business) {
                  App.isShop = true;
                } else {
                  App.isShop = false;
                }
                home = App.isShop ? HomePageShop() : HomePageUser();
              } else if (isLogin) {
                home = BindMobilePage();
              } else {
                home = LoginPage();
              }
              return MaterialApp(
                title: '????????? App',
                theme: ThemeData(
                  primarySwatch: Colours.createMaterialColor(Colours.app_main),
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                  platform: TargetPlatform.iOS,
                ),
                home: home,
                onGenerateRoute: Routes.router.generator,
                localizationsDelegates: const [
                  AppLocalizationsDelegate(),
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const <Locale>[
                  Locale('zh', 'CN'),
                  Locale('en', 'US')
                ],
                navigatorObservers: [_bot],
                builder: (context, child) {
                  /// ???????????????????????????????????????????????? https://www.kikt.top/posts/flutter/layout/dynamic-text/
                  final botToastBuilder = BotToastInit();
                  child = botToastBuilder(context, child);
                  return MediaQuery(
                    data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                    child: FlutterEasyLoading(
                      child: child,
                    ),
                  );
                },

                /// ???????????????fluro???????????????????????????Web
                onUnknownRoute: (_) {
                  return MaterialPageRoute<void>(
                    builder: (BuildContext context) => NotFoundPage(),
                  );
                },
              );
            },
          ),
        ),

        /// Toast ??????
        backgroundColor: Colors.black54,
        textPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        radius: 20.0,
        position: ToastPosition.bottom);
  }
}
