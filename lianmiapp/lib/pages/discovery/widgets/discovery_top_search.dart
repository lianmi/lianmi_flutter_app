import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/util/keyboard_utils.dart';

class DiscoveryTopSearch extends StatefulWidget {
  final String text;

  final ValueSetter<String> onTapSearch;

  DiscoveryTopSearch({Key? key, required this.text, required this.onTapSearch})
      : super(key: key);

  @override
  _DiscoveryTopSearchState createState() => _DiscoveryTopSearchState();
}

class _DiscoveryTopSearchState extends State<DiscoveryTopSearch> {
  late TextEditingController _textController;

  @override
  Widget build(BuildContext context) {
    if (_textController == null) {
      String searchText = widget.text;
      _textController = TextEditingController(
          text:
              (searchText != null && searchText.length > 0) ? searchText : '');
    }
    return Container(
      margin: EdgeInsets.only(
          top: MediaQueryData.fromWindow(window).padding.top + 10),
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            child: Container(
              margin: EdgeInsets.only(left: 12.px),
              width: 30,
              height: 40,
              alignment: Alignment.centerLeft,
              child: Icon(Icons.arrow_back_ios, color: Colors.black),
            ),
            onTap: () {
              NavigatorUtils.goBack(context);
            },
          ),
          Container(
            width: 300.px,
            height: 60,
            alignment: Alignment.center,
            color: Colors.white,
            child: Container(
              width: 300.px,
              height: 44,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(22.0)),
                  border: Border.all(color: Color(0XFFEDECED), width: 1)),
              alignment: Alignment.centerLeft,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(22.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            height: 44,
                            margin: EdgeInsets.only(left: 15.px),
                            child: Icon(
                              Icons.search,
                              color: Color(0XFF9A9A9A),
                            ),
                          ),
                          Expanded(
                              child: Container(
                            height: 44,
                            child: CupertinoTextField(
                              controller: _textController,
                              textInputAction: TextInputAction.search,
                              placeholder: '搜索商户',
                              placeholderStyle: TextStyle(
                                  fontSize: 15, color: Colors.black38),
                              decoration: BoxDecoration(// 文本框装饰
                                  ),
                              onSubmitted: (String val) {
                                KeyboardUtils.hideKeyboard(context);
                                widget.onTapSearch(_textController.text);
                              },
                            ),
                          ))
                        ],
                      ),
                    ),
                    InkWell(
                      child: Container(
                        width: 60,
                        height: 44,
                        color: Colours.app_main,
                        alignment: Alignment.center,
                        child: Text(
                          '搜索',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                      onTap: () {
                        KeyboardUtils.hideKeyboard(context);
                        widget.onTapSearch(_textController.text);
                      },
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
