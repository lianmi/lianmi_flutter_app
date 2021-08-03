import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/pages/product/model/ball_num_model.dart';
import 'package:lianmiapp/pages/product/model/product_model.dart';
import 'package:lianmiapp/pages/product/provider/shuang_se_qiu_provider.dart';
import 'package:lianmiapp/pages/product/widget/common/circle_button.dart';
import 'package:lianmiapp/pages/product/widget/type_widget.dart';
import 'package:lianmiapp/res/view_standard.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';

class BallSelectWidget extends StatefulWidget {
  @override
  _BallSelectWidgetState createState() => _BallSelectWidgetState();
}

class _BallSelectWidgetState extends State<BallSelectWidget> {
  int _dtRedType = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ShuangseqiuProvider>(builder: (context, provider, child) {
      int redSelectedCount = provider.getSelectedCount(provider.redList);
      int blueSelectedCount = provider.getSelectedCount(provider.blueList);
      int redDanSelectedCount = provider.getSelectedCount(provider.redDanList);
      int redTuoSelectedCount = provider.getSelectedCount(provider.redTuoList);
      int blueDTSelectedCount = provider.getSelectedCount(provider.blueDTList);
      if (provider.type == 0) {
        return Column(
          children: [
            _titleArea('红球，至少选择6个，已选择${redSelectedCount}个'),
            _ballListArea(provider.redList, Color(0XFFFF4400),
                onTap: (BallNumModel model) {
              _handlerRed(model);
            }),
            _titleArea('蓝球，至少选择1个，已选择${blueSelectedCount}个'),
            _ballListArea(provider.blueList, Color(0XFF4289F5),
                showUnderLine: false, onTap: (BallNumModel model) {
              _handlerBlue(model);
            }),
          ],
        );
      } else {
        return Column(
          children: [
            TypeWidget(
              titles: ['红球胆', '红球拖'],
              defaultIndex: _dtRedType,
              showTopLine: true,
              onChangeIndex: (int index) {
                setState(() {
                  _dtRedType = index;
                });
              },
            ),
            _dtRedType == 0
                ? _titleArea(
                    '红球-胆，至少选择1个，至多选择5个，已选择${_dtRedType == 0 ? redDanSelectedCount : redTuoSelectedCount}个')
                : Gaps.vGap12,
            // _titleArea(_dtRedType == 0?'红球-胆，至少选择1个，至多选择5个':'红球-拖，至少选择5个'),
            _ballListArea(
                _dtRedType == 0 ? provider.redDanList : provider.redTuoList,
                Color(0XFFFF4400), onTap: (BallNumModel model) {
              _dtRedType == 0 ? _handlerRedDan(model) : _handlerRedTuo(model);
              // _handlerRed(model);
            }),
            _titleArea('蓝球，至少选择1个，已选择${blueDTSelectedCount}'),
            _ballListArea(provider.blueDTList, Color(0XFF4289F5),
                showUnderLine: false, onTap: (BallNumModel model) {
              _handlerBlue(model);
            }),
          ],
        );
      }
    });
  }

  Widget _titleArea(String title) {
    return Container(
      padding: ViewStandard.padding,
      width: double.infinity,
      height: 40.px,
      alignment: Alignment.centerLeft,
      child: CommonText(
        title,
        fontSize: 14.px,
        color: Color(0XFF535252),
      ),
    );
  }

  Widget _ballListArea(List<BallNumModel> ballList, Color color,
      {bool showUnderLine = true, Function(BallNumModel model)? onTap}) {
    return Container(
        padding: EdgeInsets.only(left: 16.px, right: 16.px, bottom: 16.px),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 1,
                    color: showUnderLine ? Colours.line : Colors.transparent))),
        child: GridView.builder(
          padding: EdgeInsets.zero,
          itemCount: ballList.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 6,
              crossAxisSpacing: 16.px,
              mainAxisSpacing: 8.px,
              childAspectRatio: 1),
          itemBuilder: (BuildContext context, int index) {
            BallNumModel numModel = ballList[index];
            return CircleButton(
              '${numModel.number}',
              color: numModel.isSelected ? color : Colors.transparent,
              borderColor: numModel.isSelected ? color : Color(0XFFD8D8D8),
              fontSize: 16.px,
              textColor: numModel.isSelected ? Colors.white : color,
              onTap: () {
                onTap!(numModel);
              },
            );
          },
        ));
  }

  void _handlerRed(BallNumModel numModel) {
    List<BallNumModel> _redList =
        Provider.of<ShuangseqiuProvider>(App.context!, listen: false).redList;
    numModel.isSelected = !numModel.isSelected;
    int redSelectCount = 0;
    _redList.forEach((element) {
      if (element.isSelected) redSelectCount++;
    });
    if (redSelectCount > kShuangseqiuRedMaxSelectCount) {
      numModel.isSelected = false;
      logW('红球最多选${kShuangseqiuRedMaxSelectCount}个');
      HubView.showToast('红球最多选${kShuangseqiuRedMaxSelectCount}个');
      setState(() {});
      return;
    }
    setState(() {});
    Provider.of<ShuangseqiuProvider>(App.context!, listen: false).updateCount();
  }

  void _handlerBlue(BallNumModel numModel) {
    List<BallNumModel> _blueList =
        Provider.of<ShuangseqiuProvider>(App.context!, listen: false).blueList;
    numModel.isSelected = !numModel.isSelected;
    int blueSelectCount = 0;
    _blueList.forEach((element) {
      if (element.isSelected) blueSelectCount++;
    });
    if (blueSelectCount > kShuangseqiuBlueCount) {
      numModel.isSelected = false;
      logW('蓝球最多选${kShuangseqiuBlueCount}个');
      HubView.showToast('蓝球最多选${kShuangseqiuBlueCount}个');
      setState(() {});
      return;
    }
    setState(() {});
    Provider.of<ShuangseqiuProvider>(App.context!, listen: false).updateCount();
  }

  void _handlerRedDan(BallNumModel numModel) {
    for (BallNumModel item
        in Provider.of<ShuangseqiuProvider>(App.context!, listen: false)
            .redTuoList) {
      if (item.number == numModel.number && item.isSelected) {
        HubView.showToast('红球-拖已选了号码${numModel.number}');
        return;
      }
    }
    List<BallNumModel> _redList =
        Provider.of<ShuangseqiuProvider>(App.context!, listen: false)
            .redDanList;
    numModel.isSelected = !numModel.isSelected;
    int redSelectCount = 0;
    _redList.forEach((element) {
      if (element.isSelected) redSelectCount++;
    });
    if (redSelectCount > kShuangseqiuRedDanMaxSelectCount) {
      numModel.isSelected = false;
      logW('红球-胆最多选${kShuangseqiuRedDanMaxSelectCount}个');
      HubView.showToast('红球-胆最多选${kShuangseqiuRedDanMaxSelectCount}个');
      setState(() {});
      return;
    }
    setState(() {});
    Provider.of<ShuangseqiuProvider>(App.context!, listen: false).updateCount();
  }

  void _handlerRedTuo(BallNumModel numModel) {
    for (BallNumModel item
        in Provider.of<ShuangseqiuProvider>(App.context!, listen: false)
            .redDanList) {
      if (item.number == numModel.number && item.isSelected) {
        HubView.showToast('红球-胆已选了号码${numModel.number}');
        return;
      }
    }
    numModel.isSelected = !numModel.isSelected;
    setState(() {});
    Provider.of<ShuangseqiuProvider>(App.context!, listen: false).updateCount();
  }
}
