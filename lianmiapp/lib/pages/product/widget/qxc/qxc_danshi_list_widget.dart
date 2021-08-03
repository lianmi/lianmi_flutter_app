import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/pages/product/model/qxc/qxc_model.dart';
import 'package:lianmiapp/pages/product/provider/qxc_provider.dart';
import 'package:lianmiapp/pages/product/widget/common/circle_button.dart';

class QxcDanshiListItem extends StatelessWidget {
  final List<QxcModel> list;

  final Color? color;

  final Color? ballBorderColor;

  final bool showDelete;

  QxcDanshiListItem(this.list,
      {this.color, this.ballBorderColor, this.showDelete = true});

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    list.forEach((element) {
      children.add(_oneLine(element));
    });

    children.add(Container(
      width: double.infinity,
      height: 20.px,
      alignment: Alignment.topLeft,
      child: CommonText(
        '${list.length}注',
        fontSize: 12.px,
        color: Color(0XFF666666),
      ),
    ));

    return Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        child: Container(
          padding: EdgeInsets.all(16.px),
          width: 375.px,
          color: color ?? Color(0XFFF4F5F6),
          child: Column(
            children: children,
          ),
        ),
        secondaryActions: showDelete
            ? <Widget>[
                IconSlideAction(
                    caption: '删除',
                    color: Color(0XFFE5635C),
                    iconWidget: const SizedBox(),
                    onTap: () {
                      Provider.of<QxcProvider>(context, listen: false)
                          .deleteLotterys(list);
                    }),
              ]
            : []);
  }

  Widget _oneLine(QxcModel model) {
    return Container(
      width: 375.px,
      margin: EdgeInsets.only(bottom: 10.px),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          _oneBallItem('1:', model.oneBalls!.first),
          _oneBallItem('2:', model.twoBalls!.first),
          _oneBallItem('3:', model.threeBalls!.first),
          _oneBallItem('4:', model.fourBalls!.first),
          _oneBallItem('5:', model.fiveBalls!.first),
          _oneBallItem('6:', model.sixBalls!.first),
          _oneBallItem('7:', model.sevenBalls!.first),
        ],
      ),
    );
  }

  Widget _oneBallItem(String title, int number) {
    return Expanded(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CommonText(
              title,
              fontSize: 16.px,
              color: Colors.black,
            ),
            Gaps.hGap5,
            CircleButton('$number',
                color: Colors.white,
                borderColor: ballBorderColor ?? Colors.transparent,
                fontSize: 16.px,
                textColor: Colours.app_main),
          ],
        ),
      ),
    );
  }
}
