import 'package:date_format/date_format.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';
import 'package:lianmiapp/header/common_header.dart';

class OrderSumPage extends StatefulWidget {
  const OrderSumPage({Key? key}) : super(key: key);

  @override
  _OrderSumPageState createState() => _OrderSumPageState();
}

class _OrderSumPageState extends State<OrderSumPage> {
  double _sum = 0;
  int _count = 0;

  @override
  void initState() {
    super.initState();
    _calculateOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyCustomAppBar(
          centerTitle: '当月订单统计',
        ),
        backgroundColor: Color(0XEEEEEEEE),
        body: SafeArea(
            child: Container(
          child: ListView(
            children: [
              Gaps.vGap20,
              _sumItem(),
              Gaps.vGap20,
              _countItem(),
            ],
          ),
        )));
  }

  Widget _sumItem() {
    return Container(
      margin: EdgeInsets.only(bottom: 8.px),
      width: double.infinity,
      height: 72.px,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CommonText(
            '总金额',
            fontSize: 14.px,
            color: Color(0XFF666666),
          ),
          Text('${_sum}元',
              style: TextStyle(
                color: Colors.black,
                fontSize: 28.px,
              ))
        ],
      ),
    );
  }

  Widget _countItem() {
    return Container(
      margin: EdgeInsets.only(bottom: 8.px),
      width: double.infinity,
      height: 72.px,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CommonText(
            '订单总数',
            fontSize: 14.px,
            color: Color(0XFF666666),
          ),
          Text('${_count}笔',
              style: TextStyle(
                color: Colors.black,
                fontSize: 28.px,
              ))
        ],
      ),
    );
  }

  _calculateOrders() {
    // String yearMonth = '2021.7'; //统计月份 TODO
    DateTime _dateTime = DateTime.now();
    String yearMonth = formatDate(_dateTime, [yyyy, '.', m]);

    OrderMod.getStoreOrders(yearMonth).then((value) {
      setState(() {
        _sum = value['sum'] / 100.0;
        _count = value['count'];
      });
    }).catchError((e) {
      logE(e);
    });
  }
}
