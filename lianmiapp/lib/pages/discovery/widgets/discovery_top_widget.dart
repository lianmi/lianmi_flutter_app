import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lianmiapp/res/view_standard.dart';
import 'package:lianmiapp/routers/fluro_navigator.dart';
import '../discovery_router.dart';
import 'package:lianmiapp/header/common_header.dart';

class DiscoveryTopWidget extends StatefulWidget {
  final String? showAddress;

  final Function onTapAddress;

  final Function onTapCategory;

  final Function(String) onSearch;

  DiscoveryTopWidget(
      {this.showAddress,
      required this.onTapAddress,
      required this.onTapCategory,
      required this.onSearch});

  @override
  _DiscoveryTopWidgetState createState() => _DiscoveryTopWidgetState();
}

class _DiscoveryTopWidgetState extends State<DiscoveryTopWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: MediaQueryData.fromWindow(window).padding.top + 10, bottom: 10),
      width: double.infinity,
      height: 44.px,
      child: Row(
        children: [_cityArea(), _searchArea(), _categyroArea()],
      ),
    );
  }

  Widget _searchArea() {
    return Expanded(
      child: InkWell(
        child: Container(
          height: double.infinity,
          alignment: Alignment.center,
          child: Container(
            padding: ViewStandard.padding,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Color(0XFFF5F7FA),
              borderRadius: BorderRadius.all(Radius.circular(4.px)),
            ),
            child: TextField(
              textAlign: TextAlign.center,
              textInputAction: TextInputAction.search,
              style: TextStyle(fontSize: 14.px, color: Colors.black),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: '搜索商户',
                hintStyle: TextStyle(color: Colors.black26),
                counterText: '',
                icon: Image.asset(
                  ImageStandard.discoverySearch,
                  width: 16.px,
                  height: 16.px,
                ),
              ),
              onSubmitted: (String text) {
                widget.onSearch(text);
              },
            ),
            // child: Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     Image.asset(
            //       ImageStandard.discoverySearch,
            //       width: 16.px,
            //       height: 16.px,
            //     ),
            //     Padding(padding: EdgeInsets.only(right:5)),
            //     Text(
            //       '搜索商户',
            //       style: TextStyle(
            //         fontSize: 14.px
            //       ),
            //     )
            //   ],
            // ),
          ),
        ),
        onTap: () {
          // NavigatorUtils.push(context, DiscoveryRouter.searchPage);
        },
      ),
    );
  }

  Widget _bottomArea() {
    return Container(
      width: double.infinity,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {},
            child: Container(
              child: Row(
                children: [
                  Icon(Icons.arrow_drop_down),
                  Text(
                    '广州市',
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
            ),
          ),
          InkWell(
            child: Container(
              margin: EdgeInsets.only(right: 10),
              child: Text(
                '分类',
                style: TextStyle(fontSize: 16),
              ),
            ),
            onTap: () {
              NavigatorUtils.push(context, DiscoveryRouter.searchPage);
            },
          ),
        ],
      ),
    );
  }

  Widget _cityArea() {
    return InkWell(
      onTap: () {
        widget.onTapAddress();
      },
      child: Container(
        width: 75.px,
        height: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CommonText(
              widget.showAddress ?? '广州',
              fontSize: 16.px,
            ),
            Gaps.hGap5,
            Image.asset(
              ImageStandard.discoveryArrowDown,
              width: 12.px,
              height: 12.px,
            )
          ],
        ),
      ),
    );
  }

  Widget _categyroArea() {
    return InkWell(
      child: Container(
        padding: EdgeInsets.only(left: 8.px),
        width: 40.px,
        height: double.infinity,
        alignment: Alignment.centerLeft,
        child: Image.asset(
          ImageStandard.discoveryCategory,
          width: 16.px,
          height: 16.px,
        ),
      ),
      onTap: () {
        widget.onTapCategory();
      },
    );
  }
}
