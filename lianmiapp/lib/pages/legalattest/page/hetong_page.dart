import 'package:flutter/material.dart';
import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/pages/legalattest/model/hetong_model.dart';
import 'package:lianmiapp/pages/legalattest/page/hetong_widget.dart';
import 'package:lianmiapp/pages/legalattest/page/hetongorder_detail_page.dart';
import 'package:lianmiapp/pages/legalattest/provider/hetong_provider.dart';
import 'package:lianmiapp/pages/product/model/order_model.dart';
import 'package:lianmiapp/pages/product/model/product_model.dart';
import 'package:lianmiapp/pages/product/utils/lottery_data.dart';
import 'package:lianmiapp/widgets/widget/button/common_button.dart';
// import 'package:lianmiapp/pages/product/utils/lottery_data.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';

class HetongPage extends StatefulWidget {
  final String productId;
  final int productPrice;
  final String businessUsername;
  final int id;

  HetongPage(this.productId, this.productPrice, this.businessUsername, this.id);

  @override
  _HetongPageState createState() => _HetongPageState();
}

class _HetongPageState extends State<HetongPage> {
  StoreInfo? _storeInfo;
  ProductModel? _productInfo;

  @override
  void initState() {
    super.initState();

    // _productInfo = LotteryData.instance.getProduct(widget.id);
  }

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance!.addPostFrameCallback((tim) {
      _requestStoreInfo();
      _productInfo = LotteryData.instance.getProduct(widget.id);
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
          backgroundColor: Colors.white,
        ),
        child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  Navigator.of(context, rootNavigator: true)
                      .popUntil(ModalRoute.withName('/'));
                },
                tooltip: 'Back',
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Color(0xff333333),
                ),
              ),
              backgroundColor: Colors.white,
              title:
                  Text('合同协议委托类上链', style: TextStyle(color: Color(0xff333333))),
              centerTitle: true,
              actions: [],
              elevation: 0,
            ),
            body: SingleChildScrollView(child: _body())));
  }

  Widget _body() {
    return Form(
        child: Container(
            color: Color(0xffF3F6F9),
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  child: Column(
                    children: [_contentWiget(), _bottomWidget()],
                  ),
                ),
              ],
            )));
  }

  Widget _contentWiget() {
    return HetongWidget();
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

  void _requestStoreInfo() {
    HttpUtils.get(HttpApi.storeInfo + '/${widget.businessUsername}')
        .then((val) {
      _storeInfo = StoreInfo.fromMap(val);
    }).catchError((err) {});
  }

  @override
  void dispose() {
    super.dispose();
    // Provider.of<HetongProvider>(App.context!, listen: false).reset();
  }

  void _submit() async {
    var _hetongData =
        Provider.of<HetongProvider>(App.context!, listen: false).hetongData;

    if (_hetongData.type == 0) {
      HubView.showToast('请选择合同类型');
      return;
    }
    if (isValidString(_hetongData.description) == false) {
      HubView.showToast('请输入内容');
      return;
    }
    if (isValidString(_hetongData.jiafangName) == false) {
      HubView.showToast('请输入甲方名称');
      return;
    }
    if (isValidString(_hetongData.jiafangPhone) == false) {
      HubView.showToast('请输入甲方联系电话');
      return;
    }
    if (isValidString(_hetongData.jiafangLegalName) == false) {
      HubView.showToast('请输入甲方法人姓名');
      return;
    }
    if (isValidString(_hetongData.jiafangAddress) == false) {
      HubView.showToast('请输入甲方地址');
      return;
    }

    if (isValidString(_hetongData.yifangName) == false) {
      HubView.showToast('请输入乙方名称');
      return;
    }
    if (isValidString(_hetongData.yifangPhone) == false) {
      HubView.showToast('请输入乙方联系电话');
      return;
    }
    if (isValidString(_hetongData.yifangHuji) == false) {
      HubView.showToast('请输入乙方户籍');
      return;
    }
    if (isValidString(_hetongData.yifangAddress) == false) {
      HubView.showToast('请输入乙方地址');
      return;
    }
    if (isValidString(_hetongData.yifangIdCard) == false) {
      HubView.showToast('请输入乙方身份证号码');
      return;
    }
    HubView.showLoading();
    OrderModel order = OrderModel();
    order.buyUser = AppManager.currentUsername;
    order.businessUsername = widget.businessUsername;
    order.shopName = _storeInfo == null ? '' : _storeInfo!.branchesName;
    order.orderImageUrl =
        _productInfo == null ? '' : _productInfo!.productPic1Large; //产品图片
    order.productName = _productInfo == null ? '' : _productInfo!.productName;
    order.productID = widget.productId;
    order.payMode = 1; //TODO 要增加支持支付宝
    order.loterryType = widget.id;

    //要转为元为单位
    order.cost = (widget.productPrice / 100).toDouble();

    //TODO 构造订单 存证数据
    order.cunzhengModelData = HetongDataModel(
      type: _hetongData.type,
      description: _hetongData.description,
      jiafangName: _hetongData.jiafangName,
      jiafangPhone: _hetongData.jiafangPhone,
      jiafangLegalName: _hetongData.jiafangLegalName,
      jiafangAddress: _hetongData.jiafangAddress,
      yifangName: _hetongData.yifangName,
      yifangPhone: _hetongData.yifangPhone,
      yifangHuji: _hetongData.yifangHuji,
      yifangAddress: _hetongData.yifangAddress,
      yifangIdCard: _hetongData.yifangIdCard,
      image1: _hetongData.image1,
      image2: _hetongData.image2,
      image3: _hetongData.image3,
      image4: _hetongData.image4,
      image5: _hetongData.image5,
      image6: _hetongData.image6,
      image7: _hetongData.image7,
      image8: _hetongData.image8,
      image9: _hetongData.image9,
    );

    // 跳转到详情页 -> 选择支付方式 ->确认下单
    AppNavigator.push(context, HetongOrderDetailPage(order));
  }
}
