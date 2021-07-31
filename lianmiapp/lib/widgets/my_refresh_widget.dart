import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';

final kMyRefreshDefaultTextColor = Color(0XFFFF4C2B);

class MyRefreshController extends EasyRefreshController {}

typedef RefreshCallback = Function();
typedef LoadMoreCallback = Function();

// ignore: must_be_immutable
class MyRefreshWidget extends StatefulWidget {
  final MyRefreshController? refreshController;

  final ScrollController? scrollController;

  int? itemCount;

  IndexedWidgetBuilder? itemBuilder;

  RefreshCallback? refreshCallback;

  LoadMoreCallback? loadMoreCallback;

  final Color? headerBackgroundColor;

  MyRefreshWidget(
      {Key? key,
      this.scrollController,
      this.refreshController,
      @required this.itemCount,
      @required this.itemBuilder,
      this.refreshCallback,
      this.loadMoreCallback,
      this.headerBackgroundColor})
      : super(key: key);

  @override
  _MyRefreshWidgetState createState() => _MyRefreshWidgetState();
}

class _MyRefreshWidgetState extends State<MyRefreshWidget> {
  GlobalKey<ClassicalFooterWidgetState> _footerkey =
      new GlobalKey<ClassicalFooterWidgetState>();
  _MyRefreshWidgetState() {
    logD('初始化');
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        child: EasyRefresh(
          child: ListView.builder(
              controller: widget.scrollController,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.itemCount,
              itemBuilder: widget.itemBuilder!),
          enableControlFinishRefresh: true,
          enableControlFinishLoad: true,
          controller: widget.refreshController,
          topBouncing: true,
          bottomBouncing: true,
          taskIndependence: true,
          header: ClassicalHeader(
              enableInfiniteRefresh: false,
              enableHapticFeedback: true,
              bgColor: widget.headerBackgroundColor ?? Colors.white,
              textColor: kMyRefreshDefaultTextColor,
              refreshingText: '加载中...',
              infoColor: kMyRefreshDefaultTextColor,
              refreshText: '拉动刷新',
              refreshReadyText: '释放刷新',
              refreshedText: '刷新完成',
              showInfo: false),
          footer: ClassicalFooter(
              enableHapticFeedback: true,
              key: _footerkey,
              bgColor: Colors.white,
              textColor: kMyRefreshDefaultTextColor,
              loadingText: '加载中...',
              infoColor: kMyRefreshDefaultTextColor,
              noMoreText: "没有更多数据...",
              loadReadyText: '上拉加载......',
              loadedText: '加载完成',
              showInfo: false),
          onRefresh: widget.refreshCallback != null
              ? () async {
                  widget.refreshCallback!();
                }
              : null,
          onLoad: () async {
            if (widget.loadMoreCallback != null) {
              widget.loadMoreCallback!();
            }
          },
        ));
  }
}
