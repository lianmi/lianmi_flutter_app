import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/pages/lottery/model/ball_num_model.dart';
import 'package:lianmiapp/pages/lottery/provider/qlc_provider.dart';
import 'package:lianmiapp/pages/lottery/widget/common/circle_button.dart';
import 'package:lianmiapp/res/view_standard.dart';

class BallSelectWidget extends StatefulWidget {
  @override
  _BallSelectWidgetState createState() => _BallSelectWidgetState();
}

class _BallSelectWidgetState extends State<BallSelectWidget> {
  @override
  void initState() { 
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QlcProvider>(
      builder: (context, provider, child){
        int ballSelectedCount = provider.getSelectedCount(provider.ballList);
        return Column(
          children: [
            _titleArea('至少选择${kQlcMinSelectCount}个球，已选择${ballSelectedCount}个'),
            _ballListArea(
              provider.ballList, 
              Colours.app_main,
              onTap: (BallNumModel model) {
                _handlerBall(model);
              }
            ),
          ],
        );
      }
    );
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

  Widget _ballListArea(List<BallNumModel> ballList, Color color, {bool showUnderLine = true, Function(BallNumModel model)? onTap}) {
    return Container(
      padding: EdgeInsets.only(left: 16.px, right: 16.px, bottom: 16.px),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 1, color: showUnderLine?Colours.line:Colors.transparent))
      ),
      child: GridView.builder(
        padding: EdgeInsets.zero,
        itemCount: ballList.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 6,
          crossAxisSpacing: 16.px,
          mainAxisSpacing: 8.px,
          childAspectRatio: 1
        ), 
        itemBuilder: (BuildContext context, int index) {
          BallNumModel numModel = ballList[index];
          return CircleButton(
            '${numModel.number}',
            color: numModel.isSelected?color:Colors.transparent,
            borderColor: numModel.isSelected?color:Color(0XFFD8D8D8),
            fontSize: 16.px,
            textColor: numModel.isSelected?Colors.white:color,
            onTap: () {
              onTap!(numModel);
            },
          );
        },
      )
    );
  }

  void _handlerBall(BallNumModel numModel) {
    numModel.isSelected = !numModel.isSelected;
    setState(() {
    });
    Provider.of<QlcProvider>(App.context!, listen: false).updateCount();
  }
}