import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/pages/product/model/dlt/dlt_model.dart';
import 'package:lianmiapp/pages/product/model/fc3d/fc3d_model.dart';
import 'package:lianmiapp/pages/product/model/pl3/pl3_model.dart';
import 'package:lianmiapp/pages/product/model/pl5/pl5_model.dart';
import 'package:lianmiapp/pages/product/model/qlc/qlc_model.dart';
import 'package:lianmiapp/pages/product/model/qxc/qxc_model.dart';
import 'package:lianmiapp/pages/product/model/shuang_se_qiu/shuang_se_qiu_model.dart';
import 'package:lianmiapp/pages/product/utils/lottery_data.dart';
import 'package:lianmiapp/pages/product/widget/dlt/dlt_danshi_list_item.dart';
import 'package:lianmiapp/pages/product/widget/dlt/dlt_dantuo_list_item.dart';
import 'package:lianmiapp/pages/product/widget/dlt/dlt_fushi_list_item.dart';
import 'package:lianmiapp/pages/product/widget/fc3d/fc3d_danshi_list_widget.dart';
import 'package:lianmiapp/pages/product/widget/fc3d/fc3d_fushi_list_widget.dart';
import 'package:lianmiapp/pages/product/widget/pl3/pl3_danshi_list_widget.dart';
import 'package:lianmiapp/pages/product/widget/pl3/pl3_fushi_list_item.dart';
import 'package:lianmiapp/pages/product/widget/pl5/pl5_danshi_list_widget.dart';
import 'package:lianmiapp/pages/product/widget/pl5/pl5_fushi_list_widget.dart';
import 'package:lianmiapp/pages/product/widget/qlc/qlc_list_item.dart';
import 'package:lianmiapp/pages/product/widget/qxc/qxc_danshi_list_widget.dart';
import 'package:lianmiapp/pages/product/widget/qxc/qxc_fushi_list_widget.dart';
import 'package:lianmiapp/pages/product/widget/shuang_se_qiu/ssq_danshi_list_item.dart';
import 'package:lianmiapp/pages/product/widget/shuang_se_qiu/ssq_dantuo_list_item.dart';
import 'package:lianmiapp/pages/product/widget/shuang_se_qiu/ssq_fushi_list_item.dart';

class SelectedListWidget extends StatelessWidget {
  final List<dynamic> selectedNums;

  SelectedListWidget(this.selectedNums);

  @override
  Widget build(BuildContext context) {
    return _listWidget();
  }

  Widget _listWidget() {
    switch (LotteryTypeEnum.values[selectedNums.first.productId]) {
      case LotteryTypeEnum.ssq:
        {
          return _getShuangseqiuItem();
        }
        break;
      case LotteryTypeEnum.dlt:
        {
          return _getDltItem();
        }
        break;
      case LotteryTypeEnum.qlc:
        {
          return _getQlcItem();
        }
        break;
      case LotteryTypeEnum.fc3d:
        {
          return _getFc3dItem();
        }
        break;
      case LotteryTypeEnum.pl3:
        {
          return _getPl3Item();
        }
        break;
      case LotteryTypeEnum.pl5:
        {
          return _getPl5Item();
        }
        break;
      case LotteryTypeEnum.qxc:
        {
          return _getQxcItem();
        }
        break;
      default:
        return SizedBox();
    }
  }

  Widget _getShuangseqiuItem() {
    ///双色球
    ShuangseqiuModel firstModel = selectedNums.first;
    switch (firstModel.type) {
      case 0:
        {
          return SSQDanshiListItem(
            selectedNums.cast<ShuangseqiuModel>(),
            color: Colors.white,
            ballBorderColor: Color(0XFFD8D8D8),
          );
        }
        break;
      case 1:
        {
          return SSQFushiListItem(
            selectedNums.cast<ShuangseqiuModel>(),
            color: Colors.white,
            ballBorderColor: Color(0XFFD8D8D8),
          );
        }
        break;
      case 2:
        {
          return SSQDantuoListItem(
            selectedNums.cast<ShuangseqiuModel>(),
            color: Colors.white,
            ballBorderColor: Color(0XFFD8D8D8),
          );
        }
        break;
      default:
        return SizedBox();
    }
  }

  Widget _getDltItem() {
    ///大乐透
    DltModel firstModel = selectedNums.first;
    switch (firstModel.type) {
      case 0:
        {
          return DltDanshiListItem(
            selectedNums.cast<DltModel>(),
            color: Colors.white,
            ballBorderColor: Color(0XFFD8D8D8),
          );
        }
        break;
      case 1:
        {
          return DltFushiListItem(
            selectedNums.cast<DltModel>(),
            color: Colors.white,
            ballBorderColor: Color(0XFFD8D8D8),
          );
        }
        break;
      case 2:
        {
          return DltDantuoListItem(
            selectedNums.cast<DltModel>(),
            color: Colors.white,
            ballBorderColor: Color(0XFFD8D8D8),
          );
        }
        break;
      default:
        return SizedBox();
    }
  }

  Widget _getQlcItem() {
    ///七乐彩
    return QlcListItem(
      selectedNums.cast<QlcModel>(),
      color: Colors.white,
      ballBorderColor: Color(0XFFD8D8D8),
    );
  }

  Widget _getFc3dItem() {
    ///福彩3D
    Fc3dModel firstModel = selectedNums.first;
    switch (firstModel.type) {
      case 0:
        {
          return Fc3dDanshiListItem(
            selectedNums.cast<Fc3dModel>(),
            color: Colors.white,
            ballBorderColor: Color(0XFFD8D8D8),
          );
        }
        break;
      case 1:
        {
          return Fc3dFushiListItem(
            selectedNums.cast<Fc3dModel>(),
            color: Colors.white,
            ballBorderColor: Color(0XFFD8D8D8),
          );
        }
        break;
      default:
        return SizedBox();
    }
  }

  Widget _getPl3Item() {
    ///排列3
    Pl3Model firstModel = selectedNums.first;
    switch (firstModel.type) {
      case 0:
        {
          return Pl3DanshiListItem(
            selectedNums.cast<Pl3Model>(),
            color: Colors.white,
            ballBorderColor: Color(0XFFD8D8D8),
          );
        }
        break;
      case 1:
        {
          return Pl3FushiListItem(
            selectedNums.cast<Pl3Model>(),
            color: Colors.white,
            ballBorderColor: Color(0XFFD8D8D8),
          );
        }
        break;
      default:
        return SizedBox();
    }
  }

  Widget _getPl5Item() {
    ///排列5
    Pl5Model firstModel = selectedNums.first;
    switch (firstModel.type) {
      case 0:
        {
          return Pl5DanshiListItem(
            selectedNums.cast<Pl5Model>(),
            color: Colors.white,
            ballBorderColor: Color(0XFFD8D8D8),
          );
        }
        break;
      case 1:
        {
          return Pl5FushiListItem(
            selectedNums.cast<Pl5Model>(),
            color: Colors.white,
            ballBorderColor: Color(0XFFD8D8D8),
          );
        }
        break;
      default:
        return SizedBox();
    }
  }

  Widget _getQxcItem() {
    ///七星彩
    QxcModel firstModel = selectedNums.first;
    switch (firstModel.type) {
      case 0:
        {
          return QxcDanshiListItem(
            selectedNums.cast<QxcModel>(),
            color: Colors.white,
            ballBorderColor: Color(0XFFD8D8D8),
          );
        }
        break;
      case 1:
        {
          return QxcFushiListItem(
            selectedNums.cast<QxcModel>(),
            color: Colors.white,
            ballBorderColor: Color(0XFFD8D8D8),
          );
        }
        break;
      default:
        return SizedBox();
    }
  }
}
