import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/pages/product/model/product_model.dart';
import 'package:lianmiapp/pages/product/page/num_keep_page.dart';
import 'package:lianmiapp/pages/product/provider/lottery_provider.dart';
import 'package:lianmiapp/pages/product/provider/shuang_se_qiu_provider.dart';
import 'package:lianmiapp/pages/product/utils/lottery_data.dart';
import 'package:lianmiapp/res/view_standard.dart';
import 'package:lianmiapp/util/app_navigator.dart';
import 'package:lianmiapp/widgets/my_app_bar.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';
import 'package:lianmiapp/linkme/linkme_manager.dart';
import '../widget/date_widget.dart';
import '../widget/type_widget.dart';
import '../widget/shuang_se_qiu/ball_select_widget.dart';
import '../widget/shuang_se_qiu/bottom_widget.dart';

class ShuangseqiuPage extends StatefulWidget {
  final String businessUsername;

  final int id;

  ///是否守号
  final bool isNumKeep;

  ShuangseqiuPage(this.businessUsername, this.id, {this.isNumKeep = false});

  @override
  _ShuangseqiuPageState createState() => _ShuangseqiuPageState();
}

class _ShuangseqiuPageState extends State<ShuangseqiuPage>
    implements LinkMeManagerOrderStatusListerner {
  ProductModel? _productInfo;

  int _typeIndex = 0;

  @override
  void initState() {
    super.initState();
    LinkMeManager.instance.addOrderListener(this);
    _productInfo = LotteryData.instance.getProduct(widget.id);
  }

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance!.addPostFrameCallback((tim) {
      Provider.of<LotteryProvider>(App.context!, listen: false).lotteryId =
          widget.id;
      Provider.of<ShuangseqiuProvider>(App.context!, listen: false).businessId =
          widget.businessUsername;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      DateWidget(_productInfo!),
      TypeWidget(
        titles: ['普通', '胆拖'],
        onChangeIndex: (int index) {
          Provider.of<ShuangseqiuProvider>(App.context!, listen: false).type =
              index;
          setState(() {
            _typeIndex = index;
          });
        },
      ),
      BallSelectWidget()
    ];

    return Scaffold(
      appBar: MyCustomAppBar(
        centerTitle: '选号',
        actions: widget.isNumKeep == false
            ? [
                InkWell(
                  child: Container(
                    margin: ViewStandard.padding,
                    alignment: Alignment.centerRight,
                    height: 40.px,
                    child: CommonText(
                      '我的守号',
                      color: Colors.black,
                      fontSize: 14.px,
                    ),
                  ),
                  onTap: () {
                    AppNavigator.push(context, NumKeepPage()).then((value) {
                      Provider.of<ShuangseqiuProvider>(App.context!,
                              listen: false)
                          .businessId = widget.businessUsername;
                    });
                  },
                )
              ]
            : [],
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
              Positioned(
                bottom: 0,
                child: BottomWidget(
                  isNumKeep: widget.isNumKeep,
                ),
              )
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
    Provider.of<ShuangseqiuProvider>(App.context!, listen: false).clear();
  }

  void showPayWithOrder() {}

  @override
  void onLinkMeOrderStatusChange(OrderInfoData orderInfoData) async {
    logI('监听到orderid变化---${orderInfoData.orderId},状态${orderInfoData.state}');
    // if (orderInfoData.state != OrderStateEnum.OS_RecvOK) return;
  }
}
