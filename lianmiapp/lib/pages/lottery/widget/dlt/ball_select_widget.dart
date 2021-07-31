import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/pages/lottery/model/ball_num_model.dart';
import 'package:lianmiapp/pages/lottery/provider/dlt_provider.dart';
import 'package:lianmiapp/pages/lottery/widget/common/circle_button.dart';
import 'package:lianmiapp/pages/lottery/widget/type_widget.dart';
import 'package:lianmiapp/res/view_standard.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';

class BallSelectWidget extends StatefulWidget {
  @override
  _BallSelectWidgetState createState() => _BallSelectWidgetState();
}

class _BallSelectWidgetState extends State<BallSelectWidget> {
  int _dtFrontType = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DltProvider>(builder: (context, provider, child) {
      int frontSelectedCount = provider.getSelectedCount(provider.frontList);
      int backSelectedCount = provider.getSelectedCount(provider.backList);
      int frontDanSelectedCount =
          provider.getSelectedCount(provider.frontDanList);
      int frontTuoSelectedCount =
          provider.getSelectedCount(provider.frontTuoList);
      int backDTSelectedCount = provider.getSelectedCount(provider.backDTList);

      if (provider.type == 0) {
        return Column(
          children: [
            _titleArea('前区，至少选择5个，已选择${frontSelectedCount}个'),
            _ballListArea(provider.frontList, Colours.app_main,
                onTap: (BallNumModel model) {
              _handlerFront(model);
            }),
            _titleArea('后区，至少选择2个，已选择${backSelectedCount}个'),
            _ballListArea(provider.backList, Colours.app_main,
                showUnderLine: false, onTap: (BallNumModel model) {
              _handlerBack(model);
            }),
          ],
        );
      } else {
        return Column(
          children: [
            TypeWidget(
              titles: ['前区胆', '前区拖'],
              defaultIndex: _dtFrontType,
              showTopLine: true,
              onChangeIndex: (int index) {
                setState(() {
                  _dtFrontType = index;
                });
              },
            ),
            _dtFrontType == 0
                ? _titleArea(
                    '前区-胆，至少选择1个，至多选择4个，已选择${_dtFrontType == 0 ? frontDanSelectedCount : frontTuoSelectedCount}')
                : Gaps.vGap12,
            _ballListArea(
                _dtFrontType == 0
                    ? provider.frontDanList
                    : provider.frontTuoList,
                Colours.app_main, onTap: (BallNumModel model) {
              _dtFrontType == 0
                  ? _handlerFrontDan(model)
                  : _handlerFrontTuo(model);
            }),
            _titleArea('后区，至少选择2个，已选择${backDTSelectedCount}个'),
            _ballListArea(provider.backDTList, Colours.app_main,
                showUnderLine: false, onTap: (BallNumModel model) {
              _handlerBack(model);
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

  void _handlerFront(BallNumModel numModel) {
    // List<BallNumModel> _frontList = Provider.of<DltProvider>(App.context!, listen: false).frontList;
    numModel.isSelected = !numModel.isSelected;
    // int frontSelectCount = 0;
    // _frontList.forEach((element) {
    //   if(element.isSelected) frontSelectCount++;
    // });
    setState(() {});
    Provider.of<DltProvider>(App.context!, listen: false).updateCount();
  }

  void _handlerBack(BallNumModel numModel) {
    // List<BallNumModel> _backList = Provider.of<DltProvider>(App.context!, listen: false).backList;
    numModel.isSelected = !numModel.isSelected;
    // int backSelectCount = 0;
    // _backList.forEach((element) {
    //   if(element.isSelected) backSelectCount++;
    // });
    setState(() {});
    Provider.of<DltProvider>(App.context!, listen: false).updateCount();
  }

  void _handlerFrontDan(BallNumModel numModel) {
    for (BallNumModel item
        in Provider.of<DltProvider>(App.context!, listen: false).frontTuoList) {
      if (item.number == numModel.number && item.isSelected) {
        HubView.showToast('前区-拖已选了号码${numModel.number}');
        return;
      }
    }
    List<BallNumModel> _frontDanList =
        Provider.of<DltProvider>(App.context!, listen: false).frontDanList;
    numModel.isSelected = !numModel.isSelected;
    int frontDanSelectCount = 0;
    _frontDanList.forEach((element) {
      if (element.isSelected) frontDanSelectCount++;
    });
    if (frontDanSelectCount > kDltFrontDanMaxSelectCount) {
      numModel.isSelected = false;
      logW('前区-胆最多选${kDltFrontDanMaxSelectCount}个');
      HubView.showToast('前区-胆最多选${kDltFrontDanMaxSelectCount}个');
      setState(() {});
      return;
    }
    setState(() {});
    Provider.of<DltProvider>(App.context!, listen: false).updateCount();
  }

  void _handlerFrontTuo(BallNumModel numModel) {
    for (BallNumModel item
        in Provider.of<DltProvider>(App.context!, listen: false).frontDanList) {
      if (item.number == numModel.number && item.isSelected) {
        HubView.showToast('前区-胆已选了号码${numModel.number}');
        return;
      }
    }
    numModel.isSelected = !numModel.isSelected;
    setState(() {});
    Provider.of<DltProvider>(App.context!, listen: false).updateCount();
  }
}
