import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/notification/notification_center.dart';
import 'package:lianmiapp/pages/product/model/dlt/dlt_model.dart';
import 'package:lianmiapp/pages/product/model/fc3d/fc3d_model.dart';
import 'package:lianmiapp/pages/product/model/order_model.dart';
import 'package:lianmiapp/pages/product/model/product_model.dart';
import 'package:lianmiapp/pages/product/model/pl3/pl3_model.dart';
import 'package:lianmiapp/pages/product/model/pl5/pl5_model.dart';
import 'package:lianmiapp/pages/product/model/qlc/qlc_model.dart';
import 'package:lianmiapp/pages/product/model/qxc/qxc_model.dart';
import 'package:lianmiapp/pages/product/model/shuang_se_qiu/shuang_se_qiu_model.dart';
import 'package:lianmiapp/pages/product/page/order_detail_page.dart';
import 'package:lianmiapp/pages/product/provider/dlt_provider.dart';
import 'package:lianmiapp/pages/product/provider/fc3d_provider.dart';
import 'package:lianmiapp/pages/product/provider/lottery_provider.dart';
import 'package:lianmiapp/pages/product/provider/pl3_provider.dart';
import 'package:lianmiapp/pages/product/provider/pl5_provider.dart';
import 'package:lianmiapp/pages/product/provider/qlc_provider.dart';
import 'package:lianmiapp/pages/product/provider/qxc_provider.dart';
import 'package:lianmiapp/pages/product/provider/shuang_se_qiu_provider.dart';
import 'package:lianmiapp/pages/product/utils/daletou_calculate_utils.dart';
import 'package:lianmiapp/pages/product/utils/fucai3d_calculate_utils.dart';
import 'package:lianmiapp/pages/product/utils/lottery_data.dart';
import 'package:lianmiapp/pages/product/utils/pailie3_calculate_utils.dart';
import 'package:lianmiapp/pages/product/utils/pailie5_calculate_utils.dart';
import 'package:lianmiapp/pages/product/utils/qilecai_calculate_utils.dart';
import 'package:lianmiapp/pages/product/utils/qixingcai_calculate_utils.dart';
import 'package:lianmiapp/pages/product/utils/ssq_calculate_utils.dart';
import 'package:lianmiapp/pages/product/widget/select_num_bottom_widget.dart';
import 'package:lianmiapp/pages/product/widget/selected_list_widget.dart';
import 'package:lianmiapp/util/alert_utils.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';

class SelectNumPage extends StatefulWidget {
  final int id;

  final String businessId;

  SelectNumPage(this.id, this.businessId);

  @override
  _SelectNumPageState createState() => _SelectNumPageState();
}

class _SelectNumPageState extends State<SelectNumPage> {
  List _selectedNums = [];

  StoreInfo? _storeInfo;

  @override
  void initState() {
    super.initState();
    NotificationCenter.instance
        .addObserver(NotificationDefine.selectedNumUpdate, ({object}) {
      _loadSelectNums();
    });
  }

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance!.addPostFrameCallback((tim) {
      _loadSelectNums();
      _requestStoreInfo();
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyCustomAppBar(
        centerTitle: '已选号码',
      ),
      backgroundColor: Color(0XEEF0F0F3),
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              Positioned(top: 0, child: _listWidget()),
              Positioned(
                  bottom: 0,
                  child: SelectNumBottomWidget(
                    onTapClearAll: () {
                      AlertUtils.showChooseAlert(context,
                          title: '提示',
                          content: '要清除所有已选号码吗？', onTapConfirm: () {
                        _deleteAll();
                      });
                    },
                    onTapConfirm: () {
                      if (_selectedNums.length > 0) {
                        _genOrder();
                      }
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget _listWidget() {
    if (_selectedNums.length == 0) return SizedBox();
    return SelectedListWidget(_selectedNums);
  }

  @override
  void dispose() {
    super.dispose();
    Provider.of<LotteryProvider>(App.context!, listen: false).clear();
    NotificationCenter.instance
        .removeNotification(NotificationDefine.selectedNumUpdate);
  }

  void _loadSelectNums() {
    _selectedNums.clear();
    switch (LotteryTypeEnum.values[widget.id]) {
      case LotteryTypeEnum.ssq:
        {
          _selectedNums =
              Provider.of<ShuangseqiuProvider>(context, listen: false)
                  .selectLotterys;
        }
        break;
      case LotteryTypeEnum.fc3d:
        {
          _selectedNums =
              Provider.of<Fc3dProvider>(context, listen: false).selectLotterys;
        }
        break;
      case LotteryTypeEnum.dlt:
        {
          _selectedNums =
              Provider.of<DltProvider>(context, listen: false).selectLotterys;
        }
        break;
      case LotteryTypeEnum.qlc:
        {
          _selectedNums =
              Provider.of<QlcProvider>(context, listen: false).selectLotterys;
        }
        break;
      case LotteryTypeEnum.pl3:
        {
          _selectedNums =
              Provider.of<Pl3Provider>(context, listen: false).selectLotterys;
        }
        break;
      case LotteryTypeEnum.pl5:
        {
          _selectedNums =
              Provider.of<Pl5Provider>(context, listen: false).selectLotterys;
        }
        break;
      case LotteryTypeEnum.qxc:
        {
          _selectedNums =
              Provider.of<QxcProvider>(context, listen: false).selectLotterys;
        }
        break;
      default:
    }
    setState(() {});
    _calculateCount();
  }

  void _requestStoreInfo() {
    HttpUtils.get(HttpApi.storeInfo + '/${widget.businessId}').then((val) {
      _storeInfo = StoreInfo.fromMap(val);
    }).catchError((err) {});
  }

  void _calculateCount() {
    int count = 0;
    if (_selectedNums.length > 0) {
      switch (LotteryTypeEnum.values[widget.id]) {
        case LotteryTypeEnum.ssq:
          {
            ShuangseqiuModel model = _selectedNums.first;
            if (model.type == 0) {
              count = _selectedNums.length;
            } else if (_selectedNums.first.type == 1) {
              count = SSQCalculateUtils.calculateMultiple(
                  model.redBalls!.length, model.blueBalls!.length);
            } else {
              count = SSQCalculateUtils.calculateDantuo(model.danBalls!.length,
                  model.redBalls!.length, model.blueBalls!.length);
            }
          }
          break;
        case LotteryTypeEnum.fc3d:
          {
            Fc3dModel model = _selectedNums.first;
            if (model.type == 0) {
              count = _selectedNums.length;
            } else if (_selectedNums.first.type == 1) {
              count = Fucai3dCalculateUtils.calculateMultiple(
                  model.geBalls!.length,
                  model.shiBalls!.length,
                  model.baiBalls!.length);
            }
          }
          break;
        case LotteryTypeEnum.dlt:
          {
            DltModel model = _selectedNums.first;
            if (model.type == 0) {
              count = _selectedNums.length;
            } else if (_selectedNums.first.type == 1) {
              count = DLTCalculateUtils.calculateMultiple(
                  model.frontBalls!.length, model.backBalls!.length);
            } else {
              count = DLTCalculateUtils.calculateDantuo(model.danBalls!.length,
                  model.frontBalls!.length, model.backBalls!.length);
            }
          }
          break;
        case LotteryTypeEnum.qlc:
          {
            QlcModel model = _selectedNums.first;
            if (model.type == 0) {
              count = _selectedNums.length;
            } else if (_selectedNums.first.type == 1) {
              count =
                  QilecaiCalculateUtils.calculateMultiple(model.balls!.length);
            }
          }
          break;
        case LotteryTypeEnum.pl3:
          {
            Pl3Model model = _selectedNums.first;
            if (model.type == 0) {
              count = _selectedNums.length;
            } else if (_selectedNums.first.type == 1) {
              count = PaiLie3CalculateUtils.calculateMultiple(
                  model.geBalls!.length,
                  model.shiBalls!.length,
                  model.baiBalls!.length);
            }
          }
          break;
        case LotteryTypeEnum.pl5:
          {
            Pl5Model model = _selectedNums.first;
            if (model.type == 0) {
              count = _selectedNums.length;
            } else if (_selectedNums.first.type == 1) {
              count = PaiLie5CalculateUtils.calculateMultiple(
                  model.geBalls!.length,
                  model.shiBalls!.length,
                  model.baiBalls!.length,
                  model.qianBalls!.length,
                  model.wanBalls!.length);
            }
          }
          break;
        case LotteryTypeEnum.qxc:
          {
            QxcModel model = _selectedNums.first;
            if (model.type == 0) {
              count = _selectedNums.length;
            } else if (_selectedNums.first.type == 1) {
              count = QixingcaiCalculateUtils.calculateMultiple(
                model.oneBalls!.length,
                model.twoBalls!.length,
                model.threeBalls!.length,
                model.fourBalls!.length,
                model.fiveBalls!.length,
                model.sixBalls!.length,
                model.sevenBalls!.length,
              );
            }
          }
          break;
        default:
      }
    }
    Provider.of<LotteryProvider>(App.context!, listen: false).count = count;
  }

  void _deleteAll() async {
    int lotteryId =
        Provider.of<LotteryProvider>(App.context!, listen: false).lotteryId;
    switch (LotteryTypeEnum.values[lotteryId]) {
      case LotteryTypeEnum.ssq:
        {
          List<ShuangseqiuModel> selectLotterys =
              Provider.of<ShuangseqiuProvider>(App.context!, listen: false)
                  .selectLotterys;
          for (ShuangseqiuModel item in selectLotterys) {
            await AppManager.gRepository!.deleteLottery(item.id!);
          }
          Provider.of<ShuangseqiuProvider>(App.context!, listen: false)
              .updateSelectLotterys();
        }
        break;
      case LotteryTypeEnum.fc3d:
        {
          List<Fc3dModel> selectLotterys =
              Provider.of<Fc3dProvider>(App.context!, listen: false)
                  .selectLotterys;
          for (Fc3dModel item in selectLotterys) {
            await AppManager.gRepository!.deleteLottery(item.id!);
          }
          Provider.of<Fc3dProvider>(App.context!, listen: false)
              .updateSelectLotterys();
        }
        break;
      case LotteryTypeEnum.dlt:
        {
          List<DltModel> selectLotterys =
              Provider.of<DltProvider>(App.context!, listen: false)
                  .selectLotterys;
          for (DltModel item in selectLotterys) {
            await AppManager.gRepository!.deleteLottery(item.id!);
          }
          Provider.of<DltProvider>(App.context!, listen: false)
              .updateSelectLotterys();
        }
        break;
      case LotteryTypeEnum.qlc:
        {
          List<QlcModel> selectLotterys =
              Provider.of<QlcProvider>(App.context!, listen: false)
                  .selectLotterys;
          for (QlcModel item in selectLotterys) {
            await AppManager.gRepository!.deleteLottery(item.id!);
          }
          Provider.of<QlcProvider>(App.context!, listen: false)
              .updateSelectLotterys();
        }
        break;
      case LotteryTypeEnum.pl3:
        {
          List<Pl3Model> selectLotterys =
              Provider.of<Pl3Provider>(App.context!, listen: false)
                  .selectLotterys;
          for (Pl3Model item in selectLotterys) {
            await AppManager.gRepository!.deleteLottery(item.id!);
          }
          Provider.of<Pl3Provider>(App.context!, listen: false)
              .updateSelectLotterys();
        }
        break;
      case LotteryTypeEnum.pl5:
        {
          List<Pl5Model> selectLotterys =
              Provider.of<Pl5Provider>(App.context!, listen: false)
                  .selectLotterys;
          for (Pl5Model item in selectLotterys) {
            await AppManager.gRepository!.deleteLottery(item.id!);
          }
          Provider.of<Pl5Provider>(App.context!, listen: false)
              .updateSelectLotterys();
        }
        break;
      case LotteryTypeEnum.qxc:
        {
          List<QxcModel> selectLotterys =
              Provider.of<QxcProvider>(App.context!, listen: false)
                  .selectLotterys;
          for (QxcModel item in selectLotterys) {
            await AppManager.gRepository!.deleteLottery(item.id!);
          }
          Provider.of<QxcProvider>(App.context!, listen: false)
              .updateSelectLotterys();
        }
        break;
      default:
    }
    _loadSelectNums();
    AppNavigator.goBack(context);
  }

  void _genOrder() {
    ProductModel product =
        LotteryData.instance.getProduct(_selectedNums[0].productId)!;
    OrderModel order = OrderModel();
    order.buyUser = AuthMod.getLastLoginName();
    order.businessUsername = _storeInfo!.userName;
    order.shopName = _storeInfo!.branchesName;
    order.orderImageUrl = product.productPic1Large;
    order.productName = product.productName;
    order.productID = product.productId;
    order.payMode = 1;
    order.loterryType = product.id;
    List<String> straws = [];
    _selectedNums.forEach((element) {
      straws.add(element.toAttach());
    });
    order.straws = straws;
    order.multiple =
        Provider.of<LotteryProvider>(App.context!, listen: false).multiple;
    order.count =
        Provider.of<LotteryProvider>(App.context!, listen: false).count;

    //要转为元为单位
    order.cost = (product.productPrice! / 100 * order.count! * order.multiple!)
        .toDouble();

    _showOrderDetail(order);
  }

  void _showOrderDetail(OrderModel order) {
    AppNavigator.push(context, OrderDetailPage(order));
  }
}
