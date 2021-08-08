import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/pages/product/model/order_model.dart';
import 'package:lianmiapp/pages/product/model/product_model.dart';
import 'package:lianmiapp/pages/product/page/order_detail_page.dart';
import 'package:lianmiapp/pages/product/provider/lottery_provider.dart';
import 'package:lianmiapp/pages/product/provider/standart_provider.dart';
import 'package:lianmiapp/pages/product/utils/lottery_data.dart';
import 'package:lianmiapp/pages/product/widget/standart/standart_widget.dart';
import 'package:lianmiapp/widgets/my_app_bar.dart';
import 'package:lianmiapp/widgets/widget/button/common_button.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';
import 'package:lianmiapp/linkme/linkme_manager.dart';
import '../widget/date_widget.dart';

class StandartPage extends StatefulWidget {
  final String businessUsername;

  final int id;

  StandartPage(this.businessUsername, this.id);

  @override
  StandartPageState createState() => StandartPageState();
}

class StandartPageState extends State<StandartPage>
    implements LinkMeManagerOrderStatusListerner {
  ProductModel? _productInfo;
  StoreInfo? _storeInfo;

  @override
  void initState() {
    super.initState();
    LinkMeManager.instance.addOrderListener(this);
    _productInfo = LotteryData.instance.getProduct(widget.id);

    Provider.of<StandartProvider>(context, listen: false)
        .standartOrderData
        .productName = _productInfo!.productName;
    Provider.of<StandartProvider>(context, listen: false).standartOrderData.id =
        widget.id;

    Provider.of<StandartProvider>(context, listen: false)
        .standartOrderData
        .title = '购买 ${_productInfo!.productName}';
    Provider.of<StandartProvider>(context, listen: false)
        .standartOrderData
        .description = '${_productInfo!.productName}内容';
    Provider.of<StandartProvider>(context, listen: false)
        .standartOrderData
        .count = 1;
    Provider.of<StandartProvider>(context, listen: false)
        .standartOrderData
        .multiple = 1;
  }

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance!.addPostFrameCallback((tim) {
      // Provider.of<NumberSelectUtils>(context,listen: false).startSelect();
      // Provider.of<SSQOrderUtils>(context,listen: false).startOrderConfig();
      _requestStoreInfo();

      Provider.of<LotteryProvider>(App.context!, listen: false).lotteryId =
          widget.id;
      Provider.of<StandartProvider>(App.context!, listen: false).businessId =
          widget.businessUsername;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    //商品简介
    List<Widget> children = [
      DateWidget(_productInfo!, maxLines: 5),
      StandartWidget(),
      _bottomWidget(),
    ];

    return Scaffold(
      appBar: MyCustomAppBar(
        centerTitle: '选号标准表单',
        actions: [],
      ),
      backgroundColor: Colours.bg_gray,
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              Positioned(
                child: Container(
                  margin: EdgeInsets.only(bottom: 60.px),
                  child: ListView(
                    children: children,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    LinkMeManager.instance.removeOrderListener(this);
    Provider.of<StandartProvider>(App.context!, listen: false).reset();
  }

  @override
  void onLinkMeOrderStatusChange(OrderInfoData orderInfoData) async {
    logI('监听到orderid变化---${orderInfoData.orderId},状态${orderInfoData.state}');
  }

  void _requestStoreInfo() {
    UserMod.getStoreInfoFromServer(widget.businessUsername).then((val) {
      _storeInfo = val;
    }).catchError((err) {
      logE(err);
    });
  }

  Widget _bottomWidget() {
    return _twoBottom(
        nextTitle: '提交',
        onTapLast: () {
          setState(() {
            // _showPageIndex = 0;
          });
        },
        onTapNext: () {
          _submit();
        });
  }

  Widget _twoBottom(
      {required String nextTitle,
      required Function onTapLast,
      required Function onTapNext}) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.px, 12.px, 16.px, 12.px),
      width: double.infinity,
      height: 64.px,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: CommonButton(
              width: double.infinity,
              height: double.infinity,
              borderRadius: 4.px,
              color: Colours.app_main,
              text: nextTitle,
              fontSize: 16.px,
              textColor: Colors.white,
              boxShadow: BoxShadow(
                  color: Color(0XFFFF4400),
                  offset: Offset(0.0, 0.0),
                  blurRadius: 4.px,
                  spreadRadius: 0),
              onTap: () {
                onTapNext();
              },
            ),
          )
        ],
      ),
    );
  }

  void _submit() async {
    var _standartData =
        Provider.of<StandartProvider>(App.context!, listen: false)
            .standartOrderData;

    OrderModel order = OrderModel();
    order.buyUser = AppManager.currentUsername;
    order.businessUsername = widget.businessUsername;
    order.shopName = _storeInfo == null ? '' : _storeInfo!.branchesName;
    order.orderImageUrl =
        _productInfo == null ? '' : _productInfo!.productPic1Large; //产品图片
    order.productName = _productInfo == null ? '' : _productInfo!.productName;
    order.productID = _productInfo!.productId;
    order.payMode = 1;
    order.loterryType = widget.id;
    order.count = _standartData.count;
    order.multiple = _standartData.multiple;
    order.content = _standartData.productName;

    order.photos = _standartData.photos;

    if (order.count! <= 0) {
      HubView.showToastAfterLoadingHubDismiss('数量最小是1');
      return;
    }
    if (order.multiple! <= 0) {
      HubView.showToastAfterLoadingHubDismiss('倍数最小是1');
      return;
    }

    //要转为元为单位
    logW('${_productInfo!.productPrice},${order.count}, ${order.multiple!}');
    order.cost =
        ((_productInfo!.productPrice! * order.count! * order.multiple!) / 100)
            .toDouble();

    // 跳转到详情页 -> 选择支付方式 ->确认下单
    AppNavigator.push(
        context,
        OrderDetailPage(
          order,
          localUrls: _standartData.attachs,
        ));
  }
}
