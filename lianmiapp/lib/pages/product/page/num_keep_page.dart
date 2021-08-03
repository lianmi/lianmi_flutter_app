import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/notification/notification_center.dart';
import 'package:lianmiapp/pages/product/page/dlt_page.dart';
import 'package:lianmiapp/pages/product/page/shuangseqiu_page.dart';
import 'package:lianmiapp/pages/product/provider/fc3d_provider.dart';
import 'package:lianmiapp/pages/product/provider/lottery_provider.dart';
import 'package:lianmiapp/pages/product/provider/pl3_provider.dart';
import 'package:lianmiapp/pages/product/provider/pl5_provider.dart';
import 'package:lianmiapp/pages/product/provider/qlc_provider.dart';
import 'package:lianmiapp/pages/product/provider/qxc_provider.dart';
import 'package:lianmiapp/pages/product/utils/lottery_data.dart';
import 'package:lianmiapp/pages/product/widget/selected_list_widget.dart';
import 'package:lianmiapp/res/view_standard.dart';
import 'package:lianmiapp/pages/product/provider/shuang_se_qiu_provider.dart';
import 'package:lianmiapp/pages/product/provider/dlt_provider.dart';

class NumKeepPage extends StatefulWidget {
  @override
  _NumKeepPageState createState() => _NumKeepPageState();
}

class _NumKeepPageState extends State<NumKeepPage> {
  List<dynamic> _list = [];

  @override
  void initState() {
    super.initState();
    NotificationCenter.instance.addObserver(NotificationDefine.numKeepUpdate, (
        {object}) {
      _loadNumKeeps();
    });
    _loadNumKeeps();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyCustomAppBar(centerTitle: '我的守号', actions: [
          InkWell(
            child: Container(
              margin: ViewStandard.padding,
              alignment: Alignment.centerRight,
              height: 40.px,
              child: CommonText(
                '添加守号',
                color: Colors.black,
                fontSize: 14.px,
              ),
            ),
            onTap: () {
              _addNumKeep();
            },
          )
        ]),
        backgroundColor: Color(0XFFF4F5F6),
        body: SafeArea(
            child: Container(
          width: double.infinity,
          child: _contentArea(),
        )));
  }

  Widget _contentArea() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _list.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 1, color: Colours.line))),
            child: SelectedListWidget([_list[index]]),
          ),
          onTap: () {
            _selectNumKeep(_list[index]);
          },
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    NotificationCenter.instance
        .removeNotification(NotificationDefine.numKeepUpdate);
  }

  void _addNumKeep() {
    int lotteryId =
        Provider.of<LotteryProvider>(context, listen: false).lotteryId;
    switch (LotteryTypeEnum.values[lotteryId]) {
      case LotteryTypeEnum.ssq:
        {
          Provider.of<ShuangseqiuProvider>(context, listen: false)
              .showNumKeep();
        }
        break;
      case LotteryTypeEnum.fc3d:
        {
          Provider.of<Fc3dProvider>(context, listen: false).showNumKeep();
        }
        break;
      case LotteryTypeEnum.qlc:
        {
          Provider.of<QlcProvider>(context, listen: false).showNumKeep();
        }
        break;
      case LotteryTypeEnum.dlt:
        {
          Provider.of<DltProvider>(context, listen: false).showNumKeep();
        }
        break;
      case LotteryTypeEnum.pl3:
        {
          Provider.of<Pl3Provider>(context, listen: false).showNumKeep();
        }
        break;
      case LotteryTypeEnum.pl5:
        {
          Provider.of<Pl5Provider>(context, listen: false).showNumKeep();
        }
        break;
      case LotteryTypeEnum.qxc:
        {
          Provider.of<QxcProvider>(context, listen: false).showNumKeep();
        }
        break;
      default:
    }
  }

  void _loadNumKeeps() async {
    int lotteryId =
        Provider.of<LotteryProvider>(context, listen: false).lotteryId;
    switch (LotteryTypeEnum.values[lotteryId]) {
      case LotteryTypeEnum.ssq:
        {
          _list = await Provider.of<ShuangseqiuProvider>(context, listen: false)
              .getAllNumKeep();
        }
        break;
      case LotteryTypeEnum.fc3d:
        {
          _list = await Provider.of<Fc3dProvider>(context, listen: false)
              .getAllNumKeep();
        }
        break;
      case LotteryTypeEnum.qlc:
        {
          _list = await Provider.of<QlcProvider>(context, listen: false)
              .getAllNumKeep();
        }
        break;
      case LotteryTypeEnum.dlt:
        {
          _list = await Provider.of<DltProvider>(context, listen: false)
              .getAllNumKeep();
        }
        break;
      case LotteryTypeEnum.pl3:
        {
          _list = await Provider.of<Pl3Provider>(context, listen: false)
              .getAllNumKeep();
        }
        break;
      case LotteryTypeEnum.pl5:
        {
          _list = await Provider.of<Pl5Provider>(context, listen: false)
              .getAllNumKeep();
        }
        break;
      case LotteryTypeEnum.qxc:
        {
          _list = await Provider.of<QxcProvider>(context, listen: false)
              .getAllNumKeep();
        }
        break;
      default:
    }
    setState(() {});
  }

  void _selectNumKeep(dynamic model) {
    int lotteryId =
        Provider.of<LotteryProvider>(context, listen: false).lotteryId;
    switch (LotteryTypeEnum.values[lotteryId]) {
      case LotteryTypeEnum.ssq:
        {
          Provider.of<ShuangseqiuProvider>(context, listen: false)
              .selectNumKeep(model);
        }
        break;
      case LotteryTypeEnum.fc3d:
        {
          Provider.of<Fc3dProvider>(context, listen: false)
              .selectNumKeep(model);
        }
        break;
      case LotteryTypeEnum.qlc:
        {
          Provider.of<QlcProvider>(context, listen: false).selectNumKeep(model);
        }
        break;
      case LotteryTypeEnum.dlt:
        {
          Provider.of<DltProvider>(context, listen: false).selectNumKeep(model);
        }
        break;
      case LotteryTypeEnum.pl3:
        {
          Provider.of<Pl3Provider>(context, listen: false).selectNumKeep(model);
        }
        break;
      case LotteryTypeEnum.pl5:
        {
          Provider.of<Pl5Provider>(context, listen: false).selectNumKeep(model);
        }
        break;
      case LotteryTypeEnum.qxc:
        {
          Provider.of<QxcProvider>(context, listen: false).selectNumKeep(model);
        }
        break;
      default:
    }
  }
}
