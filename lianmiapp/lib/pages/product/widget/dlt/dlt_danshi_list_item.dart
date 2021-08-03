import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/pages/product/model/dlt/dlt_model.dart';
import 'package:lianmiapp/pages/product/provider/dlt_provider.dart';
import 'package:lianmiapp/pages/product/widget/common/circle_button.dart';

class DltDanshiListItem extends StatelessWidget {
  final List<DltModel> list;

  final Color? color;

  final Color? ballBorderColor;

  final bool? showDelete;

  DltDanshiListItem(this.list,
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
        secondaryActions: showDelete!
            ? <Widget>[
                IconSlideAction(
                    caption: '删除',
                    color: Color(0XFFE5635C),
                    iconWidget: const SizedBox(),
                    onTap: () {
                      Provider.of<DltProvider>(context, listen: false)
                          .deleteLotterys(list);
                    }),
              ]
            : []);
  }

  Widget _oneLine(DltModel model) {
    List<Widget> redChildren = [];
    model.frontBalls!.forEach((element) {
      redChildren.add(CircleButton('$element',
          color: Colors.white,
          borderColor: ballBorderColor ?? Colors.transparent,
          fontSize: 16.px,
          textColor: Colours.app_main));
    });
    List<Widget> blueChildren = [];
    model.backBalls!.forEach((element) {
      blueChildren.add(CircleButton(
        '$element',
        color: Colors.white,
        borderColor: ballBorderColor ?? Colors.transparent,
        fontSize: 16.px,
        textColor: Colours.app_main,
      ));
    });

    return Container(
      width: 375.px,
      margin: EdgeInsets.only(bottom: 10.px),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _titleWidget('前区'),
          _buildGrid(redChildren),
          _titleWidget('后区'),
          _buildGrid(blueChildren),
        ],
      ),
    );
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
