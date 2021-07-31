import 'package:lianmiapp/pages/me/models/recharge_history_model.dart';
import 'package:lianmiapp/res/view_standard.dart';
import 'package:lianmiapp/util/date_time_utils.dart';
import 'package:lianmiapp/widgets/my_refresh_widget.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';
import 'package:lianmiapp/header/common_header.dart';

const kHistoryRechargeLoadLimit = 20;

class HistoryRechargePage extends StatefulWidget {
  const HistoryRechargePage({Key? key}) : super(key: key);

  @override
  _HistoryRechargePageState createState() => _HistoryRechargePageState();
}

class _HistoryRechargePageState extends State<HistoryRechargePage> {

  MyRefreshController _refreshController = MyRefreshController();

  ScrollController _scrollController = ScrollController();

  List<RechargeHistoryModel> _list = [];

  int _page = 1;

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance!.addPostFrameCallback((tim) {
      _refreshController.finishLoad(noMore: true);
      _refreshController.callRefresh();
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyCustomAppBar(
        centerTitle: '充值历史',
      ),
      body: Container(
        width: double.infinity,
        child: MyRefreshWidget(
          headerBackgroundColor: Colours.bg_color,
          scrollController: _scrollController,
          refreshController: _refreshController,
          itemCount: _list.length,
          itemBuilder: (context, index) {
            return _historyItem(_list[index]);
          },
          refreshCallback: () {
            _onRefresh();
          },
          loadMoreCallback: () {
            _loadMore();
          },
        ),
      ),
    );
  }

  Widget _historyItem(RechargeHistoryModel model) {
    return Container(
      margin: EdgeInsets.only(top: 16.px),
      padding: ViewStandard.padding,
      width: double.infinity,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.px),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8.px)),
            boxShadow: [
              BoxShadow(
                  color: Color(0XFFF1E8E8),
                  offset: Offset(0.0, 4.px),
                  blurRadius: 4.px,
                  spreadRadius: 0)
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText(
              '充值平台:${model.transactionType==1?'微信':'支付宝'}'
            ),
            CommonText(
              '流水号:${model.outTradeNo}',
              maxLines: 1,
            ),
            CommonText(
              '充值详情:${model.subject}',
              maxLines: 1,
            ),
            CommonText(
              '时间:${DateTimeUtils.currentTargetTimeFromTimeMillis(model.createdAt!)}',
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }

  _onRefresh() {
    _page = 1;
    WalletMod.getTransactions(0, 0, page: _page, limit: kHistoryRechargeLoadLimit).then((value) {
      _refreshController.finishRefresh();
      _refreshController.finishLoad(noMore: value.length < kHistoryRechargeLoadLimit);
      _list.clear();
      for (var item in value) {
        _list.add(RechargeHistoryModel.fromJson(item));
      }
      setState(() {
      });
    });
  }

  _loadMore() {
    _page ++;
    WalletMod.getTransactions(0, 0, page: _page, limit: kHistoryRechargeLoadLimit).then((value) {
      _refreshController.finishRefresh();
      _refreshController.finishLoad(noMore: value.length < kHistoryRechargeLoadLimit);
      for (var item in value) {
        _list.add(RechargeHistoryModel.fromJson(item));
      }
      setState(() {
      });
    });
  }
}
