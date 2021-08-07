import 'package:lianmiapp/pages/me/models/fee_history_model.dart';
import 'package:lianmiapp/res/view_standard.dart';
import 'package:lianmiapp/util/date_time_utils.dart';
import 'package:lianmiapp/util/math_utils.dart';
import 'package:lianmiapp/widgets/my_refresh_widget.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';
import 'package:lianmiapp/header/common_header.dart';

const kHistoryFeeLoadLimit = 100;

class HistoryFeePage extends StatefulWidget {
  const HistoryFeePage({Key? key}) : super(key: key);

  @override
  _HistoryFeePageState createState() => _HistoryFeePageState();
}

class _HistoryFeePageState extends State<HistoryFeePage> {
  MyRefreshController _refreshController = MyRefreshController();

  ScrollController _scrollController = ScrollController();

  List<FeeHistoryModel> _list = [];

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
        centerTitle: '存证费消费历史',
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

  Widget _historyItem(FeeHistoryModel model) {
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
            CommonText('商店名称:${model.branchName}'),
            CommonText(
              '订单号:${model.orderId}',
              maxLines: 1,
            ),
            CommonText(
              '费用:${MathUtils.getTargetTextFromDouble(model.fee! / 100)}元',
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
    WalletMod.getSpendings(0, 0, page: _page, limit: kHistoryFeeLoadLimit)
        .then((value) {
      _refreshController.finishRefresh();
      _refreshController.finishLoad(
          noMore: value.length < kHistoryFeeLoadLimit);
      _list.clear();
      for (var item in value) {
        _list.add(FeeHistoryModel.fromJson(item));
      }
      setState(() {});
    });
  }

  _loadMore() {
    _page++;
    WalletMod.getSpendings(0, 0, page: _page, limit: kHistoryFeeLoadLimit)
        .then((value) {
      _refreshController.finishRefresh();
      _refreshController.finishLoad(
          noMore: value.length < kHistoryFeeLoadLimit);
      for (var item in value) {
        _list.add(FeeHistoryModel.fromJson(item));
      }
      setState(() {});
    });
  }
}
