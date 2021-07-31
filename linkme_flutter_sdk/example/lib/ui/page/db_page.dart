import '../widget/appbar_widget.dart';
import 'package:flutter/material.dart';

import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';
import '../../model/dlt_model.dart';
import '../../model/pailie3.dart';
import '../../model/pailie5.dart';
import '../../model/fucai3d.dart';
import '../../model/qixingcai.dart';
import '../../model/qilecai.dart';
import '../../util/daletou_calculate_utils.dart';
import '../../util/pailie3_calculate_utils.dart';
import '../../util/pailie5_calculate_utils.dart';
import '../../util/fucai3d_calculate_utils.dart';
import '../../util/qixingcai_calculate_utils.dart';
import '../../util/qilecai_calculate_utils.dart';

class DBPage extends StatefulWidget {
  DBPage({Key? key}) : super(key: key);

  @override
  _DBPageState createState() => _DBPageState();
}

class _DBPageState extends State<DBPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar("数据库", 80, false).build(context),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            _oneColumnWidget(),
            // _twoColumnWidget(),
          ],
        ),
      ),
    );
  }

  Widget _oneColumnWidget() {
    return Expanded(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: ListView(
          children: [
            _customButton('添加彩票', onTap: () async {
              _addLottery();
            }),
            _customButton('删除彩票', onTap: () async {
              _deleteLotterys();
            }),
            _customButton('查询彩票', onTap: () async {
              _queryLotterys();
            })
          ],
        ),
      ),
    );
  }

  Widget _customButton(String title, {required Function() onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        width: double.infinity,
        height: 30,
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  void _addLottery() {
    AppManager.gRepository!
        .insertLottery(1, 1, '1,2,3,4,5,6', 123457891568, 1)
        .then((value) {
      logD('添加彩票成功:$value');
    }).catchError((err) {
      logD('删除彩票失败:$err');
    });
  }

  void _queryLotterys() {
    AppManager.gRepository!.queryLotterys(1, 1, 1).then((value) {
      logD('查询彩票成功:$value');
    }).catchError((err) {
      logD('查询彩票失败:$err');
    });
  }

  void _deleteLotterys() {
    AppManager.gRepository!.deleteLottery(1).then((value) {
      logD('删除彩票成功:$value');
    }).catchError((err) {
      logD('删除彩票失败:$err');
    });
  }

  ///大乐透复式总注数
  void _caculateDLT() {
    DLTModel dlt = new DLTModel();
    dlt.frontSectionNumbers = [1, 2, 3, 4, 5, 6, 7];
    dlt.backSectionNumbers = [1, 2, 4];
    dlt.additional = true; //是否追加, 追加后每注的单价是3元)

    logD('大乐透 复式 投注内容: ${dlt.toString()}');

    int total = DLTCalculateUtils.calculateMultiple(
        dlt.frontSectionNumbers!.length, dlt.backSectionNumbers!.length);

    logD('大乐透复式总注数: $total');

    int totalAmount = 0;

    if (dlt.additional!) {
      totalAmount = total * 3;
    } else {
      totalAmount = total * 2;
    }

    logD('大乐透复式总金额: $totalAmount');
  }

  ///大乐透胆拖
  void _caculateDantuoDLT() {
    DLTModel dlt = new DLTModel();
    dlt.danmaFrontNumbers = [1, 2];
    dlt.frontSectionNumbers = [3, 4, 5, 6, 7, 8];
    dlt.backSectionNumbers = [1, 2, 3];
    dlt.additional = false; //是否追加, 追加后每注的单价是3元)

    logD('大乐透胆拖投注内容: ${dlt.toString()}');

    int total = DLTCalculateUtils.calculateDantuo(dlt.danmaFrontNumbers!.length,
        dlt.frontSectionNumbers!.length, dlt.backSectionNumbers!.length);

    logD('大乐透胆拖总注数: $total');

    int totalAmount = 0;

    if (dlt.additional!) {
      totalAmount = total * 3;
    } else {
      totalAmount = total * 2;
    }

    logD('大乐透胆拖总金额: $totalAmount');
  }

  ///排列3复式总注数
  void _caculatePailie3() {
    PaiLie3Model pailie3 = new PaiLie3Model();
    pailie3.geweiNumbers = [1, 2];
    pailie3.shiweiNumbers = [1, 3];
    pailie3.baiweiNumbers = [1, 4];

    logD('排列3 复式 投注内容: ${pailie3.toString()}');

    int total = PaiLie3CalculateUtils.calculateMultiple(
        pailie3.geweiNumbers!.length,
        pailie3.shiweiNumbers!.length,
        pailie3.baiweiNumbers!.length);

    logD('排列3 复式总注数: $total');

    int totalAmount = total * 2;

    logD('排列3 复式总金额: $totalAmount');
  }

  ///排列5复式总注数
  void _caculatePailie5() {
    PaiLie5Model pailie5 = new PaiLie5Model();
    pailie5.geweiNumbers = [1, 2];
    pailie5.shiweiNumbers = [1, 3];
    pailie5.baiweiNumbers = [1, 4];
    pailie5.qianweiNumbers = [1, 4];
    pailie5.wanweiNumbers = [1];

    logD('排列5 复式 投注内容: ${pailie5.toString()}');

    int total = PaiLie5CalculateUtils.calculateMultiple(
      pailie5.geweiNumbers!.length,
      pailie5.shiweiNumbers!.length,
      pailie5.baiweiNumbers!.length,
      pailie5.qianweiNumbers!.length,
      pailie5.wanweiNumbers!.length,
    );

    logD('排列5 复式总注数: $total');

    int totalAmount = total * 2;

    logD('排列5 复式总金额: $totalAmount');
  }

  ///福彩3d复式总注数
  void _caculateFucai3d() {
    Fucai3dModel fucai3d = new Fucai3dModel();
    fucai3d.geweiNumbers = [1, 2];
    fucai3d.shiweiNumbers = [1, 3];
    fucai3d.baiweiNumbers = [1, 4];

    logD('福彩3d 复式 投注内容: ${fucai3d.toString()}');

    int total = Fucai3dCalculateUtils.calculateMultiple(
        fucai3d.geweiNumbers!.length,
        fucai3d.shiweiNumbers!.length,
        fucai3d.baiweiNumbers!.length);

    logD('福彩3d 复式总注数: $total');

    int totalAmount = total * 2;

    logD('福彩3d 复式总金额: $totalAmount');
  }

  ///七星彩复式总注数
  void _caculateQixingcai() {
    QixingcaiModel qixingcai = new QixingcaiModel();
    qixingcai.oneNumbers = [1, 2];
    qixingcai.twoNumbers = [1];
    qixingcai.threeNumbers = [1];
    qixingcai.fourNumbers = [1];
    qixingcai.fiveNumbers = [1];
    qixingcai.sixNumbers = [1];
    qixingcai.sevenNumbers = [1];

    logD('七星彩 复式 投注内容: ${qixingcai.toString()}');

    int total = QixingcaiCalculateUtils.calculateMultiple(
      qixingcai.oneNumbers!.length,
      qixingcai.twoNumbers!.length,
      qixingcai.threeNumbers!.length,
      qixingcai.fourNumbers!.length,
      qixingcai.fiveNumbers!.length,
      qixingcai.sixNumbers!.length,
      qixingcai.sevenNumbers!.length,
    );

    logD('七星彩 复式总注数: $total');

    int totalAmount = total * 2;

    logD('七星彩 复式总金额: $totalAmount');
  }

  ///七乐彩复式总注数
  void _caculateQilecai() {
    QilecaiModel qilecai = new QilecaiModel();
    qilecai.numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9];

    logD('七乐彩 复式 投注内容: ${qilecai.toString()}');

    int total = QilecaiCalculateUtils.calculateMultiple(
      qilecai.numbers!.length,
    );

    logD('七乐彩 复式总注数: $total');

    int totalAmount = total * 2;

    logD('七乐彩 复式总金额: $totalAmount');
  }
}
