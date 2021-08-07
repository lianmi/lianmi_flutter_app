import 'package:lianmiapp/pages/me/models/system_msg_model.dart';
import 'package:lianmiapp/res/view_standard.dart';
import 'package:lianmiapp/widgets/my_refresh_widget.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';
import 'package:lianmiapp/header/common_header.dart';

const kHistoryNoticeLoadLimit = 100;

class HistoryNoticePage extends StatefulWidget {
  const HistoryNoticePage({Key? key}) : super(key: key);

  @override
  _HistoryNoticePageState createState() => _HistoryNoticePageState();
}

class _HistoryNoticePageState extends State<HistoryNoticePage> {
  MyRefreshController _refreshController = MyRefreshController();

  ScrollController _scrollController = ScrollController();

  List<HistoryNoticeModel> _list = [];

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
        centerTitle: '系统公告',
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

  Widget _historyItem(HistoryNoticeModel model) {
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
            CommonText('标题 :${model.title}'),
            CommonText(
              '内容:${model.content}',
              maxLines: 5,
            ),
            CommonText(
              '发布时间:${model.publishTime}',
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }

  _onRefresh() {
    _page = 1;
    AuthMod.getSystemMsgs(page: _page, limit: kHistoryNoticeLoadLimit)
        .then((value) {
      _refreshController.finishRefresh();
      _refreshController.finishLoad(
          noMore: value.length < kHistoryNoticeLoadLimit);
      _list.clear();
      for (var item in value) {
        _list.add(HistoryNoticeModel.fromJson(item));
      }
      setState(() {});
    });
  }

  _loadMore() {
    _page++;
    AuthMod.getSystemMsgs(page: _page, limit: kHistoryNoticeLoadLimit)
        .then((value) {
      _refreshController.finishRefresh();
      _refreshController.finishLoad(
          noMore: value.length < kHistoryNoticeLoadLimit);
      for (var item in value) {
        _list.add(HistoryNoticeModel.fromJson(item));
      }
      setState(() {});
    });
  }
}
