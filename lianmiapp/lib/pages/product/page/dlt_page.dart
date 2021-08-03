import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/pages/product/model/product_model.dart';
import 'package:lianmiapp/pages/product/page/num_keep_page.dart';
import 'package:lianmiapp/pages/product/provider/lottery_provider.dart';
import 'package:lianmiapp/pages/product/provider/dlt_provider.dart';
import 'package:lianmiapp/pages/product/utils/lottery_data.dart';
import 'package:lianmiapp/res/view_standard.dart';
import 'package:lianmiapp/widgets/my_app_bar.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';
import 'package:lianmiapp/linkme/linkme_manager.dart';
import '../widget/date_widget.dart';
import '../widget/type_widget.dart';
import '../widget/dlt/ball_select_widget.dart';
import '../widget/dlt/bottom_widget.dart';

class DltPage extends StatefulWidget {
  final String businessUsername;

  final int id;

  final bool isNumKeep;

  DltPage(this.businessUsername, this.id, {this.isNumKeep = false});

  @override
  _DltPageState createState() => _DltPageState();
}

class _DltPageState extends State<DltPage>
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
      // Provider.of<NumberSelectUtils>(context,listen: false).startSelect();
      // Provider.of<SSQOrderUtils>(context,listen: false).startOrderConfig();
      Provider.of<LotteryProvider>(App.context!, listen: false).lotteryId =
          widget.id;
      Provider.of<DltProvider>(App.context!, listen: false).businessId =
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
          Provider.of<DltProvider>(App.context!, listen: false).type = index;
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
                      Provider.of<DltProvider>(App.context!, listen: false)
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
    Provider.of<DltProvider>(App.context!, listen: false).clear();
  }

  @override
  void onLinkMeOrderStatusChange(OrderInfoData orderInfoData) async {
    logI('监听到orderid变化---${orderInfoData.orderId},状态${orderInfoData.state}');
  }
}
