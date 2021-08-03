import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/pages/product/model/qxc/qxc_model.dart';
import 'package:lianmiapp/pages/product/provider/qxc_provider.dart';
import 'package:lianmiapp/pages/product/utils/qixingcai_calculate_utils.dart';
import 'package:lianmiapp/pages/product/widget/common/circle_button.dart';

class QxcFushiListItem extends StatelessWidget {
  final List<QxcModel> list;

  final Color? color;

  final Color? ballBorderColor;

  final bool showDelete;

  QxcFushiListItem(this.list,
      {this.color, this.ballBorderColor, this.showDelete = true});

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    list.forEach((element) {
      children.add(_oneLine(element));
    });

    int count = 1;
    QxcModel model = list.first;
    count = QixingcaiCalculateUtils.calculateMultiple(
      model.oneBalls!.length,
      model.twoBalls!.length,
      model.threeBalls!.length,
      model.fourBalls!.length,
      model.fiveBalls!.length,
      model.sixBalls!.length,
      model.sevenBalls!.length,
    );

    children.add(Container(
      width: double.infinity,
      height: 20.px,
      alignment: Alignment.topLeft,
      child: CommonText(
        '${count}注',
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

  Widget _titleWidget(String title) {
    return Container(
      width: double.infinity,
      height: 20.px,
      alignment: Alignment.topLeft,
      child: CommonText(
        title,
        fontSize: 12.px,
        color: Color(0XFF666666),
      ),
    );
  }

  Widget _oneLine(QxcModel model) {
    List<Widget> oneChildren = _genChildren(model.oneBalls!);
    List<Widget> twoChildren = _genChildren(model.twoBalls!);
    List<Widget> threeChildren = _genChildren(model.threeBalls!);
    List<Widget> fourChildren = _genChildren(model.fourBalls!);
    List<Widget> fiveChildren = _genChildren(model.fiveBalls!);
    List<Widget> sixChildren = _genChildren(model.sixBalls!);
    List<Widget> sevenChildren = _genChildren(model.sevenBalls!);

    return Container(
      width: 375.px,
      margin: EdgeInsets.only(bottom: 10.px),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _titleWidget('1位'),
          _buildGrid(oneChildren),
          _titleWidget('2位'),
          _buildGrid(twoChildren),
          _titleWidget('3位'),
          _buildGrid(threeChildren),
          _titleWidget('4位'),
          _buildGrid(fourChildren),
          _titleWidget('5位'),
          _buildGrid(fiveChildren),
          _titleWidget('6位'),
          _buildGrid(sixChildren),
          _titleWidget('7位'),
          _buildGrid(sevenChildren),
        ],
      ),
    );
  }

  List<Widget> _genChildren(List<int> balls) {
    List<Widget> children = [];
    balls.forEach((element) {
      children.add(CircleButton('$element',
          color: Colors.white,
          borderColor: ballBorderColor ?? Colors.transparent,
          fontSize: 16.px,
          textColor: Colours.app_main));
    });
    return children;
  }

  Widget _buildGrid(List<Widget> children) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      itemCount: children.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          crossAxisSpacing: 16.px,
          mainAxisSpacing: 8.px,
          childAspectRatio: 1),
      itemBuilder: (BuildContext context, int index) {
        return children[index];
      },
    );
  }
}
