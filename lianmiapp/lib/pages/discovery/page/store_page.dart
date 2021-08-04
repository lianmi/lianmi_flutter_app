import 'package:flutter/services.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/pages/discovery/widgets/store_home_middle.dart';
import 'package:lianmiapp/pages/discovery/widgets/store_home_top.dart';
import 'package:lianmiapp/pages/discovery/widgets/store_product_list.dart';
import 'package:lianmiapp/pages/legalattest/utils/legalattest_utils.dart';
import 'package:lianmiapp/pages/product/model/product_model.dart';
import 'package:lianmiapp/pages/product/utils/lottery_data.dart';
import 'package:lianmiapp/pages/product/utils/lottery_utils.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';

class StorePage extends StatefulWidget {
  final String businessUsername;

  StorePage(this.businessUsername);

  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  StoreInfo? _storeInfo;

  EasyRefreshController _controller = EasyRefreshController();

  GlobalKey<ClassicalFooterWidgetState> _footerkey =
      new GlobalKey<ClassicalFooterWidgetState>();

  int _page = 1;

  int _totalPage = 1;

  // List<ProductListModel> _productList = [];

  @override
  void initState() {
    super.initState();
    _requestStoreInfo();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _slivers = [];

    if (_storeInfo != null) {
      _slivers.add(StoreHomeTop(_storeInfo!)); //商户信息显示

      _slivers.add(StoreHomMiddle(_storeInfo!)); //商户支持以下存证智能合约

      //根据商户类型查询出对应的商品列表
      List<ProductModel> products =
          LotteryData.instance.getProducts(_storeInfo!.storeType!);

      if (products.length > 0) {
        _slivers.add(StoreProductList(
          products,
          onTap: (ProductModel model) {
            logI(
                '此商户智能合约信息: productType: ${model.productType},  model.id: ${model.id}, businessUsername: ${widget.businessUsername}');
            switch (model.productType) {
              case 1:
                {
                  LotteryUtils.showLottery(model.id!, widget.businessUsername);
                  break;
                }
              case 2:
                {
                  LotteryUtils.showLottery(model.id!, widget.businessUsername);
                  break;
                }
              case 3:
                {
                  // logW(
                  //     '此商户智能合约绑定公证处,  model.id: ${model.id}, businessUsername: ${widget.businessUsername}');
                  LegalAttestUtils.showLegalAttest(model.id!, model.productId!,
                      model.productPrice!, widget.businessUsername);
                  break;
                }
            }
          },
        ));
      } else {
        logW('此商户的类型没有智能合约绑定');
      }
    }

    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);

    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Scaffold(
          body: Container(
            color: Color(0XFFF3F6F9),
            child: EasyRefresh(
              child: CustomScrollView(
                slivers: _slivers,
              ),
              enableControlFinishRefresh: true,
              enableControlFinishLoad: true,
              controller: _controller,
              topBouncing: true,
              bottomBouncing: true,
              taskIndependence: true,
              header: ClassicalHeader(
                  enableInfiniteRefresh: false,
                  enableHapticFeedback: true,
                  bgColor: Color(0XFFF3F6F9),
                  textColor: Colours.app_main,
                  refreshingText: '加载中...',
                  infoColor: Colours.app_main,
                  refreshText: '拉动刷新',
                  refreshReadyText: '释放刷新',
                  refreshedText: '刷新完成',
                  showInfo: false),
              footer: ClassicalFooter(
                  // enableInfiniteLoad:true,
                  enableHapticFeedback: true,
                  key: _footerkey,
                  bgColor: Color(0XFFF3F6F9),
                  textColor: Colours.app_main,
                  loadingText: '加载中...',
                  infoColor: Colours.app_main,
                  noMoreText: "没有更多数据...",
                  loadReadyText: '上拉加载......',
                  showInfo: false),
            ),
          ),
        ));
  }

  void _requestStoreInfo() {
    HubView.showLoading();
    HttpUtils.get(HttpApi.storeInfo + '/${widget.businessUsername}')
        .then((val) {
      HubView.dismiss();
      _storeInfo = StoreInfo.fromMap(val);
      logD('_requestStoreInfo, _storeInfo: ${_storeInfo!.toJson()}');
      setState(() {});
    }).catchError((err) {
      HubView.dismiss();
    });
  }
}
