import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/pages/product/provider/shuang_se_qiu_provider.dart';
import 'package:lianmiapp/res/view_standard.dart';
import 'package:auto_size_text/auto_size_text.dart';

class BottomWidget extends StatefulWidget {
  ///是否守号
  final bool isNumKeep;

  BottomWidget({this.isNumKeep = false});

  @override
  _BottomWidgetState createState() => _BottomWidgetState();
}

class _BottomWidgetState extends State<BottomWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: ViewStandard.padding,
      width: 375.px,
      height: 60.px,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(width: 1, color: Color(0XFFD8D8D8)))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Consumer<ShuangseqiuProvider>(builder: (context, provider, child) {
            return Expanded(
                child: AutoSizeText(
              '${provider.count}注',
              style: TextStyle(fontSize: 20.px),
              minFontSize: 10,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ));
          }),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Offstage(
                offstage: widget.isNumKeep,
                child: GestureDetector(
                  onTap: () {
                    Provider.of<ShuangseqiuProvider>(App.context!,
                            listen: false)
                        .showSelected();
                  },
                  child: Container(
                    width: 88.px,
                    height: 44.px,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(8.px)),
                        border: Border.all(width: 1, color: Color(0XFFD8D8D8))),
                    alignment: Alignment.center,
                    child: CommonText(
                      '已选号码',
                      fontSize: 16.px,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Gaps.hGap10,
              GestureDetector(
                onTap: () {
                  Provider.of<ShuangseqiuProvider>(App.context!, listen: false)
                      .reset();
                },
                child: Container(
                  width: 88.px,
                  height: 44.px,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8.px)),
                      border: Border.all(width: 1, color: Color(0XFFD8D8D8))),
                  alignment: Alignment.center,
                  child: CommonText(
                    '清空',
                    fontSize: 16.px,
                    color: Colors.black,
                  ),
                ),
              ),
              Gaps.hGap10,
              Consumer<ShuangseqiuProvider>(
                  builder: (context, provider, child) {
                return GestureDetector(
                    onTap: () {
                      if (widget.isNumKeep) {
                        provider.selectKeepBallAction();
                      } else {
                        provider.selectBallAction();
                      }
                    },
                    child: Container(
                        width: 88.px,
                        height: 44.px,
                        decoration: BoxDecoration(
                            color: Colours.app_main,
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.px))),
                        alignment: Alignment.center,
                        child: CommonText(
                          provider.currentBallSelectText,
                          fontSize: 16.px,
                          color: Colors.white,
                        )));
              })
            ],
          )
        ],
      ),
    );
  }
}
