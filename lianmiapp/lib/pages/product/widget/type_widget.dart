import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/pages/product/provider/shuang_se_qiu_provider.dart';

class TypeWidget extends StatefulWidget {
  final List<String> titles;

  final int defaultIndex;

  final Function(int index) onChangeIndex;

  final bool showTopLine;

  final bool showUnderLine;

  TypeWidget(
      {required this.titles,
      this.defaultIndex = 0,
      required this.onChangeIndex,
      this.showTopLine = false,
      this.showUnderLine = false});

  @override
  _TypeWidgetState createState() => _TypeWidgetState();
}

class _TypeWidgetState extends State<TypeWidget> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    int _currentIndex = widget.defaultIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 36.px,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              top: BorderSide(
                  width: 1.px,
                  color:
                      widget.showTopLine ? Colours.line : Colors.transparent),
              bottom: BorderSide(
                  width: 1.px,
                  color: widget.showUnderLine
                      ? Colours.line
                      : Colors.transparent))),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.titles.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            child: Container(
              width: 375.px / widget.titles.length,
              height: 36.px,
              alignment: Alignment.center,
              child: CommonText(
                widget.titles[index],
                fontSize: 14.px,
                color: index == _currentIndex ? Colours.app_main : Colors.black,
              ),
            ),
            onTap: () {
              setState(() {
                _currentIndex = index;
              });
              widget.onChangeIndex(index);
            },
          );
        },
      ),
      // child: Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   mainAxisSize: MainAxisSize.max,
      //   children: [
      //     Expanded(
      //       child: IconButton(
      //         icon: CommonText(
      //           '普通',
      //           fontSize: 14.px,
      //           color: index==0?Colours.app_main:Colors.black,
      //         ),
      //         onPressed: () {
      //           Provider.of<ShuangseqiuProvider>(App.context!, listen: false).type = 0;
      //           onChangeIndex(0);
      //         }
      //       ),
      //     ),
      //     Expanded(
      //       child: IconButton(
      //         icon: CommonText(
      //           '胆拖',
      //           fontSize: 14.px,
      //           color: index==1?Colours.app_main:Colors.black,
      //         ),
      //         onPressed: () {
      //           Provider.of<ShuangseqiuProvider>(App.context!, listen: false).type = 1;
      //           onChangeIndex(1);
      //         }
      //       ),
      //     )
      //   ],
      // ),
    );
  }
}
